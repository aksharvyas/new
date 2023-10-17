import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:kremot/main.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/models/HomeListModel.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/colors/AppColors.dart';
import 'package:kremot/view/HomePage.dart';
import 'package:kremot/view/widgets/CustomDialog.dart';
import 'package:kremot/view/widgets/DialogButton.dart';
import 'package:kremot/view/widgets/DialogCenterButton.dart';
import 'package:kremot/view/widgets/DialogListButton.dart';
import 'package:kremot/view/widgets/DialogTitle.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../data/remote/network/NetworkApiService.dart';
import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/HomeModel.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../models/RoomListModel.dart';
import '../../../models/RoomModel.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../view_model/HomeVM.dart';
import '../../../view_model/PlacesWithOwnerPermissionsVM.dart';
import '../../../view_model/RoomVM.dart';
import '../../../view_model/RoomsVM.dart';
import '../../PairingPage.dart';
import '../DialogCloseButton.dart';
import '../dialogs/place/PlacesLayout.dart';
import '../dialogs/place/RoomsLayout.dart';
import '../widget.dart';
import 'HomePagePairingProgress.dart';

class HomePagePairing extends StatefulWidget {
  final HomePageState startPairDevice;
  double width;
  double height;
  MqttServerClient client;
  Function closeCallback;
  HomePagePairing(this.width, this.height, this.client, this.startPairDevice,
      this.closeCallback,
      {Key? key})
      : super(key: key);

  @override
  State<HomePagePairing> createState() => _HomePagePairingState();
}

class _HomePagePairingState extends State<HomePagePairing> {
  late final NordicNrfMesh nordicNrfMesh = NordicNrfMesh();
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  List<BluetoothService> _services = [];
  late final BluetoothDevice _device;
  late MqttServerClient client;
  final TextEditingController homeController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final HomeVM viewModelHome = HomeVM();
  final RoomVM viewModelRoom = RoomVM();
  String? homeId;
  String? tempHomeids;
  String? roomId;
  String? cmacid;
  List<String> listOptions = [
    "BLUETOOTH",
    "WIFI",
    "LOCATION",
  ];

  List<Map<String, dynamic>> listMapOptions = [];

  int selectedPosition = -1;

  bool allowCalled = false;
  bool placeRoomSelected = false;
  bool wifiSelected = false;

  List<String> listPlaces = [];

  List<Map<String, dynamic>> listMapPlaces = [];

  List<String> listRooms = [];
  List<String?> wifiname = [];

  String tempHomeid = "";

  List<Map<String, dynamic>> listMapRooms = [];

  TextEditingController wifiController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int selectedWiFiPosition = 0;

  @override
  void initState() {
    super.initState();

    listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      mapOption['selected'] = false;
      listMapOptions.add(mapOption);
    }
    print("called the method=================");
    getHome();
    wifiinfo();
    listMapRooms = [];
    connectblueDevice();
  }

  void onCreateRoom(BuildContext context, double height, double width) {
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
            // Aligns the container to center
            child: Container(
          width: getWidth(width, 235),
          height: getHeight(height, 210),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(14.86390495300293)),
              border: Border.all(
                  color: homePageDividerColor, width: 1.0617074966430664),
              // boxShadow: const [
              //   BoxShadow(
              //       color: Color(0x40000000),
              //       offset: Offset(5.308538436889648, 5.308538436889648),
              //       blurRadius: 6.370244979858398,
              //       spreadRadius: 0)
              // ],
              //color: const Color(0xff484949)
              image: const DecorationImage(
                  image: AssetImage(dialogBg), fit: BoxFit.fill)),
//color: Colors.white,

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 20,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getHeight(height, 20),
              ),
              Container(
                  width: getWidth(width, 341),
                  height: getHeight(height, 45.62),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0x80eceded), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 3),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xb81b1918)),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: roomController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Room',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  addRoomFun();
                },
                child: Container(
                    margin: EdgeInsets.only(top: getHeight(height, 10)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset("assets/images/select.png",
                            height: getHeight(height, 41),
                            width: getWidth(width, 78.02),
                            fit: BoxFit.fill),
                        Positioned.fill(
                          child: Align(
                              child: Text("DONE",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize:
                                          getAdaptiveTextSize(context, 10.3)),
                                  textAlign: TextAlign.center)),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: getHeight(height, 10),
              ),
            ],
          ),
        )),
      ),
    );
  }

  onCreateHome(BuildContext context, double height, double width) {
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
            // Aligns the container to center
            child: Container(
          width: getWidth(width, 235),
          height: getHeight(height, 210),
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(width, 10), vertical: getHeight(height, 10)),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(14.86390495300293)),
              border: Border.all(
                  color: homePageDividerColor, width: 1.0617074966430664),
              // boxShadow: const [
              //   BoxShadow(
              //       color: Color(0x40000000),
              //       offset: Offset(5.308538436889648, 5.308538436889648),
              //       blurRadius: 6.370244979858398,
              //       spreadRadius: 0)
              // ],
              //color: const Color(0xff484949)
              image: const DecorationImage(
                  image: AssetImage(dialogBg), fit: BoxFit.fill)),
//color: Colors.white,

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 20,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getHeight(height, 20),
              ),
              Container(
                  width: getWidth(width, 341),
                  height: getHeight(height, 45.62),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0x80eceded), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 3),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xb81b1918)),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: homeController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Home',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  addhomeFun();
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(top: getHeight(height, 10)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset("assets/images/select.png",
                            height: getHeight(height, 41),
                            width: getWidth(width, 78.02),
                            fit: BoxFit.fill),
                        Positioned.fill(
                          child: Align(
//alignment: Alignment.topCenter,
                              child: Text("DONE",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize:
                                          getAdaptiveTextSize(context, 10.3)),
                                  textAlign: TextAlign.center)),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: getHeight(height, 10),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void addhomeFun() async {
    String? appuserId = await LocalStorageService.getUserId();
    String? appId = await LocalStorageService.getAppId();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
    DateTime dateTime = DateTime.parse("$formattedDate+05:30");

    String? token = await LocalStorageService.getToken();
    print(token);
    print(appuserId);
    print(appId);

    RequestHome requestHome = RequestHome(
        applicationId: appId,
        name: homeController.text.toString(),
        appUserId: appuserId,
        createdBy: appuserId,
        createdDateTime: "${dateTime.toLocal().toIso8601String()}+05:30");

    print(requestHome.toJson().toString());

    ResponseHome? responseHome = await viewModelHome.addHome(requestHome);
    if (responseHome!.value!.meta!.code == 1) {
      homeController.clear();
      getHome();
    }
  }

  void addRoomFun() async {
    String? appuserId = await LocalStorageService.getUserId();
    String? appId = await LocalStorageService.getAppId();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
    DateTime dateTime = DateTime.parse("$formattedDate+05:30");

    RequestRoom requestRoome = RequestRoom(
      applicationId: appId,
      homeId: homeId,
      roomName: roomController.text.toString(),
      appUserId: appuserId,
      createdDateTime: "${dateTime.toLocal().toIso8601String()}+05:30",
      createdBy: appuserId,
    );
    print("reqroom"+requestRoome.toJson().toString());

    ResponseRoom? responseRoom = await viewModelRoom.addRoom(requestRoome);
    if (responseRoom!.value!.meta!.code == 1) {
      Navigator.pop(context);
      roomController.clear();
      getRoom(homeId);
    }
  }

  void getHome() async {
    applicationId = await LocalStorageService.getAppId();
    String? userId = await LocalStorageService.getUserId();
    print("called inside the method=================");
    print(applicationId);
    print(userId);
    // mobileNumber = await LocalStorageService.getMobileNumber();

    RequestHomeList requestHomeList =
        RequestHomeList(applicationId: applicationId, appuserId: userId);
    print(requestHomeList.toJson().toString());
    ResponseHomeList? responseHomeList =
        await viewModelHome.homeList(requestHomeList);
    if (responseHomeList!.value!.meta!.code == 1) {
      print("inside If");
      listMapPlaces.clear();
      for (int i = 0;
          i < responseHomeList.value!.appUserAccessPermissions!.length;
          i++) {
        setState(() {
          Map<String, dynamic> mapPlace = {};
          mapPlace['name'] =
              responseHomeList.value!.appUserAccessPermissions![i].homeName;
          mapPlace['homeId'] =
              responseHomeList.value!.appUserAccessPermissions![i].homeId;
          mapPlace['selected'] = false;
          homeId = responseHomeList.value!.appUserAccessPermissions![0].homeId;

          debugPrint('Console Message Using Debug Print');
          listMapPlaces.add(mapPlace);
        });
      }
      print("homeid=============" + homeId.toString());
    }

    // getRoom();
  }

  void getRoom(String? tempids) async {
    listMapRooms.clear();
    String? userId = await LocalStorageService.getUserId();
    RequestRoomList requestRoomList = RequestRoomList(
      appuserId: userId,
      applicationId: applicationId,
      homeId: tempids,
    );
    print("roomapihome====================" + homeId.toString());
    ResponseRoomList? responseRoomList =
        await viewModelRoom.roomList(requestRoomList);
    if (responseRoomList!.value!.meta!.code == 1) {
      listMapRooms.clear();
      for (int i = 0;
          i < responseRoomList.value!.appUserAccessPermissionsRoom!.length;
          i++) {
        setState(() {
          Map<String, dynamic> mapRoom = {};
          mapRoom['name'] =
              responseRoomList.value!.appUserAccessPermissionsRoom![i].roomName;
          mapRoom['roomId'] =
              responseRoomList.value!.appUserAccessPermissionsRoom![i].roomId;
          mapRoom['selected'] = false;
          roomId =
              responseRoomList.value!.appUserAccessPermissionsRoom![i].roomId;
          listMapRooms.add(mapRoom);
        });
      }
    }
  }

  Future<void> connectblueDevice() async {
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    await flutterBlue.startScan();
  }

  void _addDeviceTolist(final BluetoothDevice device) async {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
      print(device);
      await device.disconnect();

      if (device.name == "ESP-BLE-MESH") {
        print("device addddddddddddedddddd cmacid");
        cmacid = device.id.toString();
        NetworkApiService apiservices = NetworkApiService();
        // bool? checkSwitch =
        //     await apiservices.checkSwitchByCmac("abc", cmacid!, context);
        // if (checkSwitch == true) {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => HomePage(nordicNrfMesh)),
        //   );
        // }
      }

      if (device.name == "KRSystem") {
        print("device Connected inside if");
        flutterBlue.stopScan();
        try {
          await device.connect();
          setState(() {
            _device = device;
          });

          print("device Connected");
        } on PlatformException catch (e) {
          if (e.code != 'already_connected') {
            rethrow;
          }
        } finally {
          _services = await device.discoverServices();
        }
      }
    }
  }

  Future<void> wifiinfo() async {
    // For scanning
    final wifis = await WiFiForIoTPlugin.loadWifiList();

    wifiname = wifis.map((e) => e.ssid.toString()).toList();
    print("WIFIDATA========= ${wifiname}");
  }

  Widget itemBuild(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        wifiname.elementAt(index).toString(),
        style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            //fontFamily: "Inter",
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: getAdaptiveTextSize(context, 10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PlacesWithOwnerPermissionsVM placesWithOwnerPermissionsVM =
        PlacesWithOwnerPermissionsVM();
    RoomsVM roomsVM = RoomsVM();

    RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions =
        RequestPlacesWithOwnerPermissions(
            applicationId: applicationId, appuserId: appUserId);
    placesWithOwnerPermissionsVM
        .getPlacesWithOwnerPermissions(requestPlacesWithOwnerPermissions);

    Future<bool> _onWillPop() async {
      widget.closeCallback;
      return true;
    }

    return Align(
        alignment: const Alignment(0, 0.37),
        child: Container(
            width: getWidth(widget.width, 326.0),
            height: getHeight(widget.height, dialogHeight),
            // padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(14.86390495300293)),
              border: Border.all(
                  color: homePageDividerColor, width: 1.0617074966430664),
              // boxShadow: const [
              //   BoxShadow(
              //       color: Color(0x40000000),
              //       offset: Offset(5.308538436889648, 5.308538436889648),
              //       blurRadius: 6.370244979858398,
              //       spreadRadius: 0)
              // ],
              //color: const Color(0xff484949)
              image: const DecorationImage(
                  image: AssetImage(dialogBg), fit: BoxFit.fill),
            ),
//color: Colors.white,
            child: wifiSelected
                ? HomePagePairingProgress(
                    widget.width,
                    widget.height,
                    widget.closeCallback,
                    homeId!,
                    roomId!,
                    widget.startPairDevice,
                    )
                : placeRoomSelected
                    ? Stack(
                        children: [
                          DialogTitle(20.57, 21.23, "PAIRING", 12.0, "Roboto"),
                          DialogCloseButton(15, 18, () {
                            widget.closeCallback();
                          }),
                          Positioned(
                              left: getX(widget.width, 132),
                              top: getY(widget.height, 48),
                              child: Text(
                                "SELECT WIFI",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    fontSize:
                                        getAdaptiveTextSize(context, 12.0)),
                              )),
                          Positioned(
                              left: getX(widget.width, 127),
                              top: getY(widget.height, 73),
                              child: Image.asset(
                                "assets/images/wifi_router.png",
                                width: getWidth(widget.width, 82),
                                height: getHeight(widget.height, 60),
                              )),
                          Positioned(
                              left: getX(widget.width, 79),
                              top: getY(widget.height, 144),
                              child: DialogCenterButton(
                                "2.4GHZ",
                                optionsButtonWidth,
                                optionsButtonHeight,
                                optionsButtonTextSize,
                                (selected) {
                                  if (selected) {
                                    setState(() {
                                      selectedWiFiPosition = 0;
                                    });
                                  }
                                },
                                tapped: true,
                                selected: selectedWiFiPosition == 0,
                              )),
                          Positioned(
                              left: getX(widget.width, 189),
                              top: getY(widget.height, 144),
                              child: DialogCenterButton(
                                "5.0GHZ",
                                optionsButtonWidth,
                                optionsButtonHeight,
                                optionsButtonTextSize,
                                (selected) {
                                  if (selected) {
                                    setState(() {
                                      selectedWiFiPosition = 1;
                                    });
                                  }
                                },
                                tapped: true,
                                selected: selectedWiFiPosition == 1,
                              )),
                          Positioned(
                              left: getX(widget.width, 156),
                              top: getY(widget.height, 194),
                              child: Text(
                                "WIFI",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    fontSize:
                                        getAdaptiveTextSize(context, 12.0)),
                              )),
                          Positioned(
                              left: getX(widget.width, 103),
                              top: getY(widget.height, 192),
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/images/ok_tick.png",
                                  width: getWidth(widget.width, 20),
                                  height: getHeight(widget.height, 20),
                                  fit: BoxFit.fill,
                                ),
                              )),
                          Positioned(
                              left: getX(widget.width, 213),
                              top: getY(widget.height, 192),
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/images/not_ok_tick.png",
                                  width: getWidth(widget.width, 20),
                                  height: getHeight(widget.height, 20),
                                  fit: BoxFit.fill,
                                ),
                              )),
                          Positioned(
                              left: getX(widget.width, 24),
                              top: getY(widget.height, 236),
                              child: Text(
                                "WIFI NAME:",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    fontSize:
                                        getAdaptiveTextSize(context, 10.0)),
                              )),
                          Positioned(
                            left: getX(widget.width, 89),
                            top: getY(widget.height, 223),
                            child: Container(
                              width: getWidth(widget.width, 110),
                              height: getHeight(widget.height, 34),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(widget.width, 5)),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0x80eceded), width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0.0, 3),
                                        blurRadius: 2,
                                        spreadRadius: 0)
                                  ],
                                  image: const DecorationImage(
                                    image: AssetImage(textFieldUnSelectedImage),
                                    fit: BoxFit.fill,
                                  )),
                              child: TextFormField(
                                controller: wifiController,
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                textInputAction: TextInputAction.done,
                                cursorColor: textColor,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: getHeight(widget.height, 16),
                                        bottom: getHeight(widget.height, 16))),
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  fontSize: getAdaptiveTextSize(context, 12.0),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: getX(widget.width, 24),
                              top: getY(widget.height, 288),
                              child: Text(
                                "PASSWORD:",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    fontSize:
                                        getAdaptiveTextSize(context, 10.0)),
                              )),
                          Positioned(
                            left: getX(widget.width, 89),
                            top: getY(widget.height, 275),
                            child: Container(
                              width: getWidth(widget.width, 110),
                              height: getHeight(widget.height, 34),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(widget.width, 5)),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0x80eceded), width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0.0, 3),
                                        blurRadius: 2,
                                        spreadRadius: 0)
                                  ],
                                  image: const DecorationImage(
                                    image: AssetImage(textFieldUnSelectedImage),
                                    fit: BoxFit.fill,
                                  )),
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                textInputAction: TextInputAction.done,
                                cursorColor: textColor,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: getHeight(widget.height, 16),
                                        bottom: getHeight(widget.height, 16))),
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  fontSize: getAdaptiveTextSize(context, 12.0),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: getX(widget.width, 215),
                              top: getY(widget.height, 222),
                              child: Container(
                                width: getWidth(widget.width, 99),
                                height: getHeight(widget.height, 140),
                                decoration: BoxDecoration(
                                  border: Border.all(color: textColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight(widget.height, 5),
                                    ),
                                    Text(
                                      "WIFI LIST",
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          //fontFamily: "Inter",
                                          fontStyle: FontStyle.normal,
                                          decoration: TextDecoration.none,
                                          fontSize: getAdaptiveTextSize(
                                              context, 10.0)),
                                    ),
                                    SizedBox(
                                      height: getHeight(widget.height, 10),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      child: SizedBox(
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10) *
                                            0.808,
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(
                                                left: 13, right: 13),
                                            shrinkWrap: true,
                                            itemCount: wifiname.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return itemBuild(context, index);
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          DialogButton(
                              "NEXT",
                              120,
                              336,
                              optionsNextButtonWidth,
                              optionsNextButtonHeight,
                              optionsNextButtonTextSize, () {
                            setState(() {
                              wifiSelected = true;
                              LocalStorageService.setWifi(wifiController.text);
                              LocalStorageService.setWifiPassword(
                                  passwordController.text);
                            });
                          }),
                          Positioned(
                              left: getX(widget.width, 41),
                              top: getY(widget.height, 395),
                              child: Text(
                                "*IF WI-FI ROUTER NOT AVAILABLE THEN",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    fontSize:
                                        getAdaptiveTextSize(context, 11.0)),
                              )),
                          DialogButton(
                              "SKIP",
                              120,
                              419,
                              optionsNextButtonWidth,
                              optionsNextButtonHeight,
                              optionsNextButtonTextSize, () {
                            setState(() {
                              wifiSelected = true;
                            });
                          }),
                        ],
                      )
                    : allowCalled
                        ? Stack(
                            children: [
                              DialogTitle(
                                  20.57, 21.23, "PAIRING", 12.0, "Roboto"),
                              DialogCloseButton(15, 18, () {
                                widget.closeCallback();
                              }),
                              Positioned(
                                left: getX(widget.width, 51),
                                top: getY(widget.height, 40),
                                child: Text("SELECT PLACE",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                        fontSize: getAdaptiveTextSize(
                                            context, placeRoomTextSize)),
                                    textAlign: TextAlign.center),
                              ),
                              Positioned(
                                left: getX(widget.width, 205),
                                top: getY(widget.height, 40),
                                child: Text("SELECT ROOM",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                        fontSize: getAdaptiveTextSize(
                                            context, placeRoomTextSize)),
                                    textAlign: TextAlign.center),
                              ),
                              Positioned(
                                left: getX(
                                    widget.width, placeListButtonLeftMargin),
                                top: getY(
                                    widget.height, placeListButtonTopMargin),
                                child: SizedBox(
                                    width: getWidth(
                                        widget.width, optionsNextButtonWidth),
                                    height: getHeight(widget.height, 300),
                                    child: Column(children: [
                                      listMapPlaces.isNotEmpty
                                          ? SizedBox(
                                              width: getWidth(widget.width,
                                                  optionsNextButtonWidth),
                                              height: getHeight(widget.height,
                                                  placeListHeight),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemCount: listMapPlaces.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int position) {
                                                  return Column(
                                                    children: [
                                                      DialogCenterButton(
                                                          listMapPlaces[
                                                              position]['name'],
                                                          optionsButtonWidth,
                                                          optionsButtonHeight,
                                                          optionsButtonTextSize,
                                                          (selected) {

                                                        setState(() {
                                                          for (int i = 0;
                                                              i <
                                                                  listMapPlaces
                                                                      .length;
                                                              i++) {
                                                            listMapPlaces[i][
                                                                    'selected'] =
                                                                false;
                                                            // homeId =  listMapPlaces[i]['homeId'];
                                                            // tempHomeids=homeId;
                                                            // print("homeid***********************"+tempHomeids.toString());
                                                            // getRoom(tempHomeids);
                                                          }

                                                          if (selected) {
                                                            selectedPosition =
                                                                position;
                                                            listMapPlaces[
                                                                        position]
                                                                    [
                                                                    'selected'] =
                                                                true;
                                                            getRoom(
                                                                listMapPlaces[
                                                                        position]
                                                                    ['homeId']);
                                                          } else {
                                                            //selectedPosition = -1;
                                                          }
                                                        });
                                                      },
                                                          tapped: listMapPlaces[
                                                                          position]
                                                                      [
                                                                      'name'] ==
                                                                  "+"
                                                              ? false
                                                              : true,
                                                          selected:
                                                              listMapPlaces[
                                                                      position]
                                                                  ['selected']),
                                                      // DialogCenterButton(
                                                      //     listMapPlaces[position]['name'],
                                                      //     optionsButtonWidth,
                                                      //     optionsButtonHeight,
                                                      //     optionsButtonTextSize,
                                                      //         (selected) {
                                                      //       setState(() {
                                                      //         for (int i = 0;
                                                      //         i < listMapPlaces.length;
                                                      //         i++) {
                                                      //           listMapPlaces[i]['selected'] =
                                                      //           false;
                                                      //           homeId = listMapPlaces[i][
                                                      //             position]['homeId'].homeId;
                                                      //         }
                                                      //
                                                      //         if (selected) {
                                                      //           selectedPosition = position;
                                                      //           listMapRooms[position]
                                                      //           ['selected'] = true;
                                                      //         } else {
                                                      //           selectedPosition = -1;
                                                      //         }
                                                      //       });
                                                      //     },
                                                      //     tapped: true,
                                                      //         selected:
                                                      //             listMapPlaces[
                                                      //                     position]
                                                      //                 ['selected']),
                                                      // tapped: listMapRooms[position]
                                                      // ['name'] ==
                                                      //     "+"
                                                      //     ? false
                                                      //     : true,
                                                      // selected: listMapRooms[position]
                                                      // ['selected']),

                                                      //old code

                                                      // DialogCenterButton(
                                                      //     listMapPlaces[
                                                      //         position]['name'],
                                                      //     optionsButtonWidth,
                                                      //     optionsButtonHeight,
                                                      //     optionsButtonTextSize,
                                                      //     (selected) {
                                                      //   setState(() {
                                                      //     for (int i = 0;
                                                      //         i <
                                                      //             listMapPlaces
                                                      //                 .length;
                                                      //         i++) {
                                                      //       listMapPlaces[i][
                                                      //               'selected'] =
                                                      //           false;
                                                      //
                                                      //       homeId = listMapPlaces[i][
                                                      //       position]['homeId'].homeId;
                                                      //     }
                                                      //
                                                      //     selectedPosition =
                                                      //         position;
                                                      //     listMapPlaces[
                                                      //                 position]
                                                      //             ['selected'] =
                                                      //         true;
                                                      //   });
                                                      // },
                                                      //     tapped: true,
                                                      //     selected:
                                                      //         listMapPlaces[
                                                      //                 position]
                                                      //             ['selected']),
                                                      if (position !=
                                                          listMapPlaces.length -
                                                              1)
                                                        SizedBox(
                                                          height: getHeight(
                                                              widget.height,
                                                              placeListVerticalMargin),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              ))
                                          : Container(),
                                      DialogCenterButton(
                                          '+',
                                          optionsButtonWidth,
                                          optionsButtonHeight,
                                          optionsButtonTextSize, (selected) {
                                        onCreateHome(context, widget.height,
                                            widget.width);
                                      }, tapped: true, selected: false),
                                    ])),
                              ),
                              Positioned(
                                  left: getX(widget.width, 206),
                                  top: getY(
                                      widget.height, roomListButtonTopMargin),
                                  child: SizedBox(
                                    width: getWidth(
                                        widget.width, optionsNextButtonWidth),
                                    height: getHeight(widget.height, 300),
                                    child: Column(
                                      children: [
                                        listMapRooms.isNotEmpty
                                            ? SizedBox(
                                                width: getWidth(widget.width,
                                                    optionsNextButtonWidth),
                                                height: getHeight(widget.height,
                                                    roomListHeight),
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount:
                                                      listMapRooms.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int position) {
                                                    return Column(
                                                      children: [
                                                        DialogCenterButton(
                                                            listMapRooms[
                                                                    position]
                                                                ['name'],
                                                            optionsButtonWidth,
                                                            optionsButtonHeight,
                                                            optionsButtonTextSize,
                                                            (selected) {
                                                              print("roooom"+listMapRooms[position]['roomId']);
                                                          setState(() {
                                                            for (int i = 0;
                                                                i <
                                                                    listMapRooms
                                                                        .length;
                                                                i++) {
                                                              listMapRooms[i][
                                                                      'selected'] =
                                                                  false;
                                                              roomId =
                                                                  listMapRooms[
                                                                          i][
                                                                      'roomId'];
                                                            }

                                                            if (selected) {
                                                              selectedPosition =
                                                                  position;
                                                              listMapRooms[
                                                                      position][
                                                                  'selected'] = true;
                                                            } else {
                                                              //selectedPosition = -1;
                                                            }
                                                          });
                                                        },
                                                            tapped: listMapRooms[
                                                                            position]
                                                                        [
                                                                        'name'] ==
                                                                    "+"
                                                                ? false
                                                                : true,
                                                            selected:
                                                                listMapRooms[
                                                                        position]
                                                                    [
                                                                    'selected']),
                                                        if (position !=
                                                            listMapRooms
                                                                    .length -
                                                                1)
                                                          SizedBox(
                                                            height: getHeight(
                                                                widget.height,
                                                                roomListVerticalMargin),
                                                          ),
                                                      ],
                                                    );
                                                  },
                                                ))
                                            : Container(),
                                        DialogCenterButton(
                                            '+',
                                            optionsButtonWidth,
                                            optionsButtonHeight,
                                            optionsButtonTextSize, (selected) {
                                          onCreateRoom(context, widget.height,
                                              widget.width);
                                        }, tapped: true, selected: false),
                                      ],
                                    ),
                                  )),
                              DialogButton(
                                  "EXISTING\nPLACE",
                                  130,
                                  340,
                                  optionsNextButtonWidth,
                                  optionsNextButtonHeight,
                                  optionsNextButtonTextSize,
                                  () {}),
                              Positioned(
                                left: getX(widget.width, 130),
                                top: getY(widget.height, 411),
                                child: DialogCenterButton(
                                    "NEXT",
                                    optionsNextButtonWidth,
                                    optionsNextButtonHeight,
                                    optionsNextButtonTextSize,

                                        (selected) {
                                  setState(() {
                                    placeRoomSelected = true;
                                  });
                                }),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              DialogTitle(0, 0, "PAIRING", 12.0, "Roboto"),
                              DialogCloseButton(15, 27, () {
                                widget.closeCallback();
                              }),
                              Positioned(
                                  left: getX(widget.width, 132),
                                  top: getY(widget.height, 119),
                                  child: Text(
                                    "TURN ON",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: "Inter",
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                        fontSize:
                                            getAdaptiveTextSize(context, 12.0)),
                                  )),
                              Positioned.fill(
                                top: getY(widget.height, 127),
                                child: ListView.builder(
                                    itemCount: listMapOptions.length,
                                    itemBuilder: (context, position) {
                                      return Column(
                                        children: [
                                          DialogCenterButton(
                                            listMapOptions[position]['name'],
                                            optionsButtonWidth,
                                            optionsButtonHeight,
                                            optionsButtonTextSize,
                                            (selected) {},
                                          ),
                                          SizedBox(
                                            height: getHeight(dialogHeight, 24),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              // DialogButton("BLUETOOTH", 124, 156, optionsButtonWidth, optionsButtonHeight, optionsButtonTextSize, (){
                              //
                              // }),
                              // DialogButton("WIFI", 124, 209, optionsButtonWidth, optionsButtonHeight, optionsButtonTextSize, (){
                              //
                              // }),
                              // DialogButton("LOCATION", 124, 261, optionsButtonWidth, optionsButtonHeight, optionsButtonTextSize, (){
                              //
                              // }),
                              DialogButton(
                                  "ALLOW",
                                  69,
                                  313,
                                  optionsButtonWidth,
                                  optionsButtonHeight,
                                  optionsButtonTextSize, () {
                                setState(() {
                                  allowCalled = true;
                                });
                              }),
                              DialogButton(
                                  "DENY",
                                  179,
                                  313,
                                  optionsButtonWidth,
                                  optionsButtonHeight,
                                  optionsButtonTextSize, () {
                                widget.closeCallback();
                              })
                            ],
                          )));
  }
}
