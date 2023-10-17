import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/network/NetworkApiService.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/models/AddHomeNetworkStringModel.dart';
import 'package:kremot/models/PairProduction.dart';

import 'package:kremot/models/SwitchItem.dart';
import 'package:kremot/models/SwitchModel.dart';

import 'package:kremot/models/deviceModel.dart';
import 'package:kremot/protocol/DeviceSwitchInfo.dart';
import 'package:kremot/utils/Utils.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../models/AddHomeNetworkStringResponseModel.dart';

import '../../../models/AddProduction.dart';
import '../../../models/FanItem.dart';
import '../../../models/LightItem.dart';
import '../../../models/PairingModel.dart';
import '../../../res/AppColors.dart';
import '../../../test.dart';
import '../../../utils/Constants.dart';
import '../../../view_model/HomeVM.dart';
import '../../HomePage.dart';
import '../DialogCloseButton.dart';
import '../DialogTitle.dart';
import '../widget.dart';

class HomePagePairingProgress extends StatefulWidget {
  HomePageState startPairDevice;
  double width;
  double height;
  Function closeCallback;
  String? homeId;
  String roomId;

  HomePagePairingProgress(this.width, this.height, this.closeCallback,
      this.homeId, this.roomId, this.startPairDevice,
      {Key? key})
      : super(key: key);

  @override
  State<HomePagePairingProgress> createState() =>
      _HomePagePairingProgressState();
}

class _HomePagePairingProgressState extends State<HomePagePairingProgress> {
  Timer? _timer;

  double progressValue = 0;
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  final HomeVM viewModelHome = HomeVM();
  final List<BluetoothDevice> devicesListA5 = <BluetoothDevice>[];
  List<DeviceListViewModel>? deviceListViewModel;
  late final NordicNrfMesh nordicNrfMesh = NordicNrfMesh();
  List<DeviceListViewModel>? deviceListViewModelLocal;

  List<SwitchViewModel>? _switchViewModel;
  List<SwitchViewModel>? _switchViewModelLocal;
  List<SwitchItem> _lightList = [];

  final FixedExtentScrollController _scrollController1 =
      FixedExtentScrollController(initialItem: 1);

  String? mobileNumber;
  String? wifiUsername;
  String? wifiPassword;

  final List<FanItem> _fanList = [];

  void getUserData() async {
    applicationId = await LocalStorageService.getAppId();
    mobileNumber = await LocalStorageService.getMobileNumber();
    wifiUsername = await LocalStorageService.getWifi();
    wifiPassword = await LocalStorageService.getWifiPassword();
  }

  List<String> listDevices = ["4switch"];

  @override
  initState() {
    // TODO: implement initState

    super.initState();
    print("roooom" + widget.roomId);
    addStringToSF();

    if (progressValue == 0) {
      _timer = Timer.periodic(const Duration(milliseconds: 200),
          (Timer _timer) async {
        setState(() {
          progressValue++;
            if (progressValue == 100) {
            _timer.cancel();
            Future.delayed(Duration(seconds: 3),);

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => HomePage(nordicNrfMesh)));

          }
        });
      });
    }

    //close dailogbox
    calldelay();
  }

  void calldelay() {
    Future.delayed(const Duration(milliseconds: 2000), calledmethod);
  }

  void dispose() {
    //...
    super.dispose();
    //...
    _timer?.cancel();
  }

  Future<void> calledmethod() async {
    print("called ");
    // widget.startPairDevice.startPairDevice();
    await widget.startPairDevice.scanUnprovisionned();
    print("Method is called ");
    await Future.delayed(const Duration(milliseconds: 2000), () {
// }
    });
    if (widget.startPairDevice.udevices.length == 0) {
      print("=======No device found try again============");
    } else {
      // widget.startPairDevice.productIdentifire ;
      widget.startPairDevice.processPairDevice();
      for (int i = 0; i < widget.startPairDevice.udevices.length; i++) {
        print("udevice  ${widget.startPairDevice.udevices.length}  ${widget.startPairDevice.udevices.elementAt(i).name}");
        addProduction(widget.startPairDevice.udevices.elementAt(i).id);
      }

    }
    print(
        "paring bool=========${widget.startPairDevice.startNextDeviceProcess}");

    try {
      print(widget.startPairDevice.bleMeshManager.bleInstance.status.name);
    } catch (e) {
      print(e);
    }
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('flag', "yes");
  }

  Future addProduction(String cmdId) async {
    NetworkApiService apiservices = NetworkApiService();
    bool? checkSwitch =
        await apiservices.checkSwitchByCmac("abc", cmdId, context);

    String? userid = await LocalStorageService.getUserId();

    AddProduction addProductionRequest = AddProduction(
      applicationId: await LocalStorageService.getAppId(),
      cmacID: cmdId,
      companyId: 1,
      deviceTypeId: 7,
      createdDateTime:
          (DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'))
              .toString(),
      createdBy: userid,
    );
    AddHomeNetworkStringModel addHomeNetworkStringRequest =
        AddHomeNetworkStringModel(
      homeId: widget.homeId,
      applicationId: await LocalStorageService.getAppId(),
      networkString: "",
    );
    PairProduction pairProductionRequest = PairProduction(
      applicationId: await LocalStorageService.getAppId(),
      id: 10,
      pairedBy: userid,
      homeId: widget.homeId.toString(),
      roomId: widget.roomId.toString(),
      updatedDateTime:
          (DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'))
              .toString(),
      updatedBy: userid,
    );

    try {
      final response = (await apiservices.add(ApiEndPoints.ADD_PRODUCTION,
          addProductionRequest.toJson(), AddProduction.fromJson));

      if (response == null) {
        Utils.toastMessage(false, "Switch not added Production", context);
        await Future.delayed(const Duration(seconds: 3));
      } else {
        if (checkSwitch == true) {
          Utils.toastMessage(
              true, "Switch already added to Production", context);
          await Future.delayed(Duration(seconds: 3));
        } else {
          Utils.toastMessage(
              true, "Switch added Successfully to Production", context);
          await Future.delayed(const Duration(seconds: 3));
        }
      }
    } catch (e) {
      Utils.toastMessage(false, "Add production" + e.toString(), context);
      await Future.delayed(Duration(seconds: 3));
    }
    try {
      final response = (await apiservices.add(ApiEndPoints.PAIR_PRODUCTION,
          pairProductionRequest.toJson(), PairProduction.fromJson));
      if (response == null) {
        Utils.toastMessage(false, "Switch not added", context);
        await Future.delayed(Duration(seconds: 3));
      } else {
        print("responseeeeeeeeeeeeeeeeeeeeee" + response.toString());
        Utils.toastMessage(true, "Switch added Successfully", context);
        await Future.delayed(Duration(seconds: 3));
      }
    } catch (e) {
      Utils.toastMessage(false, "pair production" + e.toString(), context);
      await Future.delayed(Duration(seconds: 3));
    }
    try {
      final response = (await apiservices.add(
          ApiEndPoints.ADD_HOME_NETWORK_STRING,
          addHomeNetworkStringRequest.toJson(),
          AddHomeNetworkStringModel.fromJson));

      if (response == null) {
        Utils.toastMessage(false, "Home Network not added", context);
        await Future.delayed(Duration(seconds: 3));
      } else {
        if (response['value']['meta']['code'] == 1) {
          Utils.toastMessage(true, "Home Network added Successfully", context);
          await Future.delayed(Duration(seconds: 3));
        } else {
          Utils.toastMessage(false, "Home Network Already added", context);
          await Future.delayed(Duration(seconds: 3));
        }
      }
    } catch (e) {
      Utils.toastMessage(
          false, "home add network string" + e.toString(), context);
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("homeid" + widget.homeId!);
    return Stack(
      children: [
        DialogTitle(20.57, 21.23, "PAIRING", 12.0, "Roboto"),
        DialogCloseButton(15, 18, () {
          //widget.closeCallback();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage(nordicNrfMesh)));
        }),
        Positioned(
            left: getX(widget.width, 20),
            right: getX(widget.width, 20),
            top: getY(widget.height, 41),
            child: Wrap(
              spacing: getWidth(widget.width, 45),
              children: listDevices
                  .map((e) => SizedBox(
                        width: getWidth(widget.width, 118),
                        height: getHeight(widget.height, 76),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/$e.png",
                              width: getWidth(widget.width, 58),
                              height: getHeight(widget.height, 55),
                            ),
                            SizedBox(
                              width: getWidth(widget.width, 15),
                            ),
                            progressValue == 100.0
                                ? Image.asset(
                                    "assets/images/ok_tick.png",
                                    width: getWidth(widget.width, 30),
                                    height: getHeight(widget.height, 30),
                                  )
                                : SizedBox(
                                    width: getWidth(widget.width, 45),
                                    height: getHeight(widget.height, 43),
                                    child: SfRadialGauge(axes: <RadialAxis>[
                                      RadialAxis(
                                          minimum: 0,
                                          maximum: 100,
                                          showLabels: false,
                                          showTicks: false,
                                          radiusFactor: 1,
                                          startAngle: 270,
                                          endAngle: 270,
                                          axisLineStyle: const AxisLineStyle(
                                            thickness: 0.15,
                                            //cornerStyle: CornerStyle.bothCurve,
                                            color: Colors.white,
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                                value: progressValue,
                                                cornerStyle:
                                                    CornerStyle.bothCurve,
                                                color: progressColor,
                                                width: 0.15,
                                                sizeUnit: GaugeSizeUnit.factor,
                                                enableAnimation: true,
                                                animationDuration: 100,
                                                animationType:
                                                    AnimationType.linear)
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                                positionFactor: 0,
                                                widget: Text(
                                                  '${progressValue.toStringAsFixed(0)}%',
                                                  style: TextStyle(
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 9.0),
                                                      color: textColor),
                                                ))
                                          ])
                                    ]),
                                  ),
                          ],
                        ),
                      ))
                  .toList(),
            )),
        Positioned(
            left: getX(widget.width, 20),
            right: getX(widget.width, 20),
            top: getY(widget.height, 359),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(progressColor),
              value: progressValue / 100,
            )),
        Positioned(
            left: getX(widget.width, 70),
            right: getX(widget.width, 70),
            top: getY(widget.height, 374),
            child: Text(
              "90 SECONDS (MAX. 120 SECONDS)",
              style: TextStyle(
                  color: textColor,
                  fontSize: getAdaptiveTextSize(context, 10.0),
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
