import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:fitness_ble_app/src/app/screen/bloc/GlobalBloc.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/bloc_provider.dart';
import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';
import 'package:fitness_ble_app/src/app/screen/helper/utility.dart';
import 'package:fitness_ble_app/src/app/screen/model/import_csv_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/chart_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/settings_Page.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:fitness_ble_app/BLE-Lib/constants.dart';
import 'package:fitness_ble_app/BLE-Lib/ppg-activity-model.dart';
import 'package:fitness_ble_app/BLE-Lib/scan-result-tile.dart';
import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/pages/dashboard_card_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/record_page.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1 find device screen BLE listing screen
///
///
class FitnessBLEApp extends StatelessWidget {
  ListPatientsData? addPatientModel;

  FitnessBLEApp({this.addPatientModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          //initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            print("Bluetooth status on or off :- ${snapshot.data}");
            if (state == BluetoothState.on) {
              return BLEListingPage(
                addPatientModelPass: addPatientModel!,
              );
            }
            return BluetoothOffScreen(state: state!);
          }),
    );
  }
}

class BLEListingPage extends StatefulWidget {
  ListPatientsData addPatientModelPass;

  BLEListingPage({required this.addPatientModelPass});

  @override
  BLEListingPageState createState() => BLEListingPageState();
}

class BLEListingPageState extends State<BLEListingPage> {
  ListPatientsData? addPatientModel;

  @override
  void initState() {
    // TODO: implement initState
    getBle();
    super.initState();
    addPatientModel = widget.addPatientModelPass;
  }

  getBle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int bleLength = await prefs.getInt("BleLength")!;
    print("bleLength         " + bleLength.toString());
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context)
        .patientModelBloc
        .patientModelStream
        .listen((event) {
      addPatientModel = event;
      debugPrint("addPatientModel ${addPatientModel.toString()}");
    });
    debugPrint("addPatientModel build ${addPatientModel.toString()}");
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(appBarPng),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              "Find Device",
              style: appbarTextStyle,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings_Page()),
                  );
                },
                icon: Icon(Icons.settings))
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 1)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// connected Devices list data
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 1))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: SizedBox(
                              width: 190,
                              child: StreamBuilder<BluetoothDeviceState>(
                                stream: d.state,
                                initialData: BluetoothDeviceState.disconnected,
                                builder: (c, snapshot) {
                                  if (snapshot.data ==
                                      BluetoothDeviceState.connected) {
                                    // print("Ble ${d.id}");

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // SizedBox(
                                        //   width:80,
                                        //   //height: 35,
                                        //   child: RaisedButton(
                                        //       child: Text('OPEN',style: TextStyle(fontSize: 12),),
                                        //     onPressed: () {
                                        //       Navigator.of(context).push(
                                        //           MaterialPageRoute(
                                        //               builder: (context) =>
                                        //                   DeviceScreen(device:d,addPatientModel: widget.addPatientModel,)));
                                        //
                                        //     }),
                                        // ),
                                        // SizedBox(width: 4,),
                                        SizedBox(
                                          // width: 100,
                                          //height: 45,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[400]),
                                              child: Text(
                                                'Disconnect',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              onPressed: () {
                                                showDisconnect(
                                                    "Are you confirm to disconnect this device ${d.name}",
                                                    d);
                                              }),
                                        ),
                                      ],
                                    );
                                  }
                                  return Text(snapshot.data.toString());
                                },
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),

              /// scan result list data
              StreamBuilder<List<ScanResult>>(
                  stream: FlutterBlue.instance.scanResults,
                  initialData: [],
                  builder: (c, snapshot) {
                    // return Column(
                    //     children: snapshot.data
                    //         .map(
                    //           (r) => ScanResultTile(
                    //         result: r,
                    //         // onTap: () {
                    //         //   Navigator.of(context)
                    //         //     .push(MaterialPageRoute(builder: (context) {
                    //         //       // ignore: missing_return
                    //         //       //setState(() {});
                    //         //
                    //         //     BluetoothDevice deviceBLE = r.device;
                    //         //                     deviceBLE.connect();
                    //         //
                    //         //
                    //         //       // if( == BluetoothDeviceState.connected) {
                    //         //       //   showCupertinoDialog("${r.device.name} is Connected");
                    //         //       //   return  DashBoardCardPage(device: r.device);
                    //         //       // }else if(r.device.state == BluetoothDeviceState.disconnected){
                    //         //       //   showCupertinoDialog("${r.device.name} is disconnected");
                    //         //       // }
                    //         //
                    //         //
                    //         //      return  DashBoardCardPage(device: r.device);
                    //         // }));
                    //         // }
                    //       ),
                    //     ).toList()
                    // );
                    //
                    return Column(
                        children: snapshot.data!
                            .map(
                              (r) => ScanResultTile(
                                  result: r,
                                  onTap: () async {
                                    r.device.connect().then((value) {
                                      print("connect value");
                                      showToast(
                                          "connect this device ${r.device.name}");
                                    });
                                    BluetoothDeviceState? state;
                                    r.device.state.listen((event) {
                                      state = event;
                                      print("bleStateSub $event");
                                    });
                                    await Future.delayed(Duration(seconds: 2),
                                        () {
                                      if (state ==
                                          BluetoothDeviceState.connected) {
                                        initialize(r.device, state);
                                      }
                                    });
                                    //DeviceScreen deviceScreen = DeviceScreen(state: state,device: r.device, addPatientModel:widget.addPatientModel,);
                                    // deviceScreen.initialize();
                                    //   if(r.device != null){
                                    //     initialize(r.device);
                                    //   }
                                    // await Future.delayed(Duration(seconds: 1));

                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(builder: (context) {
                                    //   return DeviceScreen(device: r.device, addPatientModel:widget.addPatientModel,);
                                    //
                                    // }));
                                    // if(bleConnected(r.device) == true){
                                    // showToast("BLE Connected");
                                    //bleDiscoveryServices.initializeBLEServices();

                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(builder: (context) {
                                    //   return BleDiscoveryServices(device: r.device,addPatientModel:widget.addPatientModel ,context: context,);
                                    // }));
                                    // } else {
                                    //   showToast("BLE is not connected!! try again");
                                    // }
                                  }),
                            )
                            .toList());
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    Permission.location,
                    Permission.locationAlways,
                    Permission.locationWhenInUse,
                  ].request();
                  print("$statuses");
                  FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
                });
          }
        },
      ),
    );
  }

  showCupertinoDialog(String messages) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: new Text(messages),
            //title: new Text("$deviceName is Connected"),
            //content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  showDisconnect(String messages, BluetoothDevice bluetoothDevice) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: new Text(messages),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  bluetoothDevice.disconnect();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  StreamSubscription? characteristicStreamSubscription;
  StreamSubscription? bleStateStreamSubscription;
  BluetoothCharacteristic? cState;
  List<int> f0f1 = [];
  List<int> f0d1 = [];
  File? csvFile;
  BluetoothDeviceState? state;
  // List<BleDataModel> bleDataList = new List<BleDataModel>();
  // List<BleDataModel> bleDataList_copy = new List<BleDataModel>();
  // List<BleDataModel> addInCSVBleData = new List<BleDataModel>();
  List<BleDataModel> bleDataList = [];
  List<BleDataModel> bleDataList_copy = [];
  List<BleDataModel> addInCSVBleData = [];
  initialize(BluetoothDevice device, state) async {
    DateTime startTime = await DateTime.now();
    print("device $device state $state");
    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID: "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID: "f0d1"
    };

    var deviceMTUSize = 27 + 3;

    await device.requestMtu(deviceMTUSize);

    // bleStateStreamSubscription = device.state.listen((event) {
    //   state = event;
    //   print("bleStateSub $event");
    // });

    // List<BluetoothService> services = new List();
    List<BluetoothService> services = [];
    Future.delayed(Duration(seconds: 2), () async {
      print("calling future");
      await device.discoverServices().then((s) async {
        services = s;

        debugPrint("servicess ${services.toList().toString()}");

        if (services != null) {
          List<List<String>> csvData = [];

          for (BluetoothService service in services) {
            List<String> serviceData = [];
            serviceData.add(service.uuid.toString());
            serviceData.add(service.deviceId.toString());
            serviceData.add(service.isPrimary.toString());

            for (BluetoothCharacteristic characteristic
                in service.characteristics) {
              serviceData.add(characteristic.uuid.toString());
              for (BluetoothDescriptor descriptors
                  in characteristic.descriptors) {
                serviceData.add(descriptors.uuid.toString());
                serviceData.add(DateTime.now().toString());
              }
            }

            csvData.add(serviceData);
          }

          String csv = const ListToCsvConverter().convert(csvData);
          final String dir = (await getApplicationDocumentsDirectory()).path;
          final String path = '$dir/myCsv.csv';
          File file = File(path);
          await file.writeAsString(csv);

          print("CSV file saved at: $path");

          if (await file.exists()) {
            await uploadCsvOnAPI(file);
            String formattedDate =
                DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());

            String path = '$dir/FitnessApp_$formattedDate';
            await file.rename(path);
            file = File(path);
            print("filepath" + file.path);
            String csvData = await file.readAsString();
            print("formatted file" + file.path);
            List<List<dynamic>> csvTable =
                CsvToListConverter().convert(csvData);

            List<List<String>> csvStringTable = csvTable.map((row) {
              return row.map((value) => value.toString()).toList();
            }).toList();

            print("csvStringTable     $csvStringTable");
          }
        }
        DateTime EndTime = await DateTime.now();
        print("diffTime  " + (EndTime.difference(startTime).toString()));
        // if (services != null) {
        //   print("service is not null");
        //   await Future.forEach(services, (BluetoothService service) async {
        //     var characteristics = service.characteristics;
        //     //print("services $services");
        //     await Future.forEach(characteristics,
        //         (BluetoothCharacteristic c) async {
        //       final uuidString = c.uuid.toString();
        //       print(
        //           "characteristics $uuidString   ${Characteristics.toString()}");
        //       if (Characteristics.containsKey(uuidString)) {
        //         print("characteristics containsKey $uuidString");
        //         final characteristicName = Characteristics[uuidString];
        //         //print("characteristics containsKey $uuidString");
        //         //if (availableServiceCharacteristicNotifications[characteristicName] != null) {
        //
        //         cState = c;
        //         await Future.delayed(new Duration(seconds: 1), () async {
        //           print("read character");
        //           readCharacteristic(uuidString, cState);
        //         });
        //         //  }
        //
        //       }
        //     });
        //   });
        // }
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChartPage()),
    );
    //services = await device.discoverServices();

    //  if(state == BluetoothDeviceState.connected){
    // services = await device.discoverServices();
    //  print("services $services");
    //  }

    // var isDiscoveringServices = device.isDiscoveringServices;
    //  print("device.isDiscoveringServices $isDiscoveringServices");
    //  if(isDiscoveringServices == false){
    //    services = await device.discoverServices();
    //
    //  }

    //if(state == BluetoothDeviceState.connected) {
    // print("BluetoothDeviceState.connected");
    // device.discoverServices().then((s) {
    //   services = s;
    //   isServicesDiscovered = true;
    // },);
    // Future.delayed(Duration(seconds: 1), () {
    //   if (!isServicesDiscovered && device != null)
    //     device.discoverServices().then((s) {
    //       services = s;
    //     });
    // });
    // }
  }

  readCharacteristic(uuidString, cState) async {
    cState.setNotifyValue(true);
    print("eventsss ${uuidString}   ${PPG_SERVICE_CHARACTERISTIC_UUID}");
    await cState.value.listen(
      (event) {
        print(
            "event ${event.toString()}  ${uuidString}   ${PPG_SERVICE_CHARACTERISTIC_UUID}");
        if (uuidString == PPG_SERVICE_CHARACTERISTIC_UUID) {
          if (event != null) {
            print("event is not null ${event.toString()}");
            f0f1 = event;
          }
        } else if (uuidString == DOF_SERVICE_CHARACTERISTIC_UUID) {
          if (event != null) {
            print("event is not null ${event.toString()}");
            f0d1 = event;
          }
        }
        print("end of event method");
        createListBleModel(bleDataF0F1: f0f1, bleDataF0D1: f0d1);
      },
    );
  }

  BleDataModel bleDataCalculation(
      {required List<int> bleDataF0F1, required List<int> bleDataF0D1}) {
    //List<int> dataF0F1 = bleDataF0F1; //24
    //List<int> dataF0D1 = bleDataF0D1; //18

    Uint8List? F0F1List;
    if (bleDataF0F1 != null) {
      F0F1List = Uint8List.fromList(bleDataF0F1);
    }
    Uint8List? F0D1List;

    if (bleDataF0D1 != null) {
      F0D1List = Uint8List.fromList(bleDataF0D1);
    }
    int swRevision = 29;
    bool layoutSetup = false;
    int? battVal;
    int? hrCalc;
    double swHigh;
    double swLow;
    int? heartRate;
    int heartRate2;

    double sensTemp = 0;
    var sensType = 0x01;
    var temp;
    List<BleDataModel> bleDataList = [];
    PpgActivityModel ppgActivityModel = PpgActivityModel();
    BleDataModel bleDataModel = BleDataModel();

    if (F0F1List != null) {
      print("F0F1List" + F0F1List.toList().toString());
      bleDataModel.IR1Value = bytesTo24Bit(F0F1List, 0);
      bleDataModel.BatterylevelValue = bytesTo8Bit(F0F1List, 3);
      bleDataModel.Red1Value = bytesTo24Bit(F0F1List, 4);
      bleDataModel.Heartratesensor1Value = bytesTo8Bit(F0F1List, 7);
      bleDataModel.ACC1Value = bytesTo16Bit(F0F1List, 8);
      bleDataModel.IR2Value = bytesTo24Bit(F0F1List, 10);
      bleDataModel.Heartratesensor2Value = bytesTo8Bit(F0F1List, 13);
      bleDataModel.Red2Value = bytesTo32Bit(F0F1List, 14);
      bleDataModel.ACC2Value = bytesTo16Bit(F0F1List, 18);
      bleDataModel.GSR_ECGValue = bytesTo16Bit(F0F1List, 20);
      bleDataModel.Temp_integral_part = bytesTo8Bit(F0F1List, 22);
      bleDataModel.Temp_fractional_part = bytesTo8Bit(F0F1List, 23);
    }
    sensTemp =
        ((bytesTo8Bit(F0F1List!, 22) * 100) + bytesTo8Bit(F0F1List, 23)) / 100;

    //var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
    var timeStamp = DateTime.now();
    bleDataModel.timeStamp = timeStamp;

    /// F0D0
    if (F0D1List != null) {
      bleDataModel.ACCxValue = (bytesTo16Bit(F0D1List, 0) / 1000);
      bleDataModel.ACCyValue = (bytesTo16Bit(F0D1List, 2) / 1000);
      bleDataModel.ACCzValue = (bytesTo16Bit(F0D1List, 4) / 1000);
      bleDataModel.GYRxValue = (bytesTo16Bit(F0D1List, 6) / 10);
      bleDataModel.GYRyValue = (bytesTo16Bit(F0D1List, 8) / 10);
      bleDataModel.GYRzValue = (bytesTo16Bit(F0D1List, 10) / 10);
      bleDataModel.MAGxValue = (bytesTo16Bit(F0D1List, 12));
      bleDataModel.MAGyValue = (bytesTo16Bit(F0D1List, 14));
      bleDataModel.MAGzValue = (bytesTo16Bit(F0D1List, 16));
    }

    bleDataModel.battVal = battVal;
    bleDataModel.sensTemp = sensTemp;
    bleDataModel.hrCalc = hrCalc;
    bleDataModel.heartRate = heartRate;

    var dataSet;

    dataSet = "timeStamp :${ppgActivityModel.timeStamp}," +
        "IR1Value  :${ppgActivityModel.IR1Value}," +
        "Red1Value :${ppgActivityModel.Red1Value}," +
        "ACC1Value :${ppgActivityModel.ACC1Value}," +
        "IR2Value  :${ppgActivityModel.IR2Value}," +
        "Red2Value :${ppgActivityModel.Red2Value}," +
        "ACC2Value :${ppgActivityModel.ACC2Value}," +
        "ACCxValue :${ppgActivityModel.ACCxValue}," +
        "ACCyValue :${ppgActivityModel.ACCyValue}," +
        "ACCzValue :${ppgActivityModel.ACCzValue}," +
        "GYRxValue :${ppgActivityModel.GYRxValue}," +
        "GYRyValue :${ppgActivityModel.GYRyValue}," +
        "GYRzValue :${ppgActivityModel.GYRzValue}," +
        "MAGxValue :${ppgActivityModel.MAGxValue}," +
        "MAGyValue :${ppgActivityModel.MAGyValue}," +
        "MAGzValue :${ppgActivityModel.MAGzValue}," +
        "GSR_ECGValue :${ppgActivityModel.GSR_ECGValue}," +
        "battVa :${ppgActivityModel.battVal}," +
        "sensTemp :${ppgActivityModel.sensTemp}," +
        "hrCalc :${ppgActivityModel.hrCalc}," +
        "heartRate :${ppgActivityModel.heartRate}," +
        "\n";

    return bleDataModel;
  }

  createListBleModel(
      {required List<int> bleDataF0F1, required List<int> bleDataF0D1}) async {
    BleDataModel bleDataModel =
        bleDataCalculation(bleDataF0F1: bleDataF0F1, bleDataF0D1: bleDataF0D1);

    bleDataList.add(bleDataModel);
    print("ble            " + bleDataModel.toString());
    print("ble data list length ${bleDataList.length}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int bleLength = await prefs.getInt("BleLength") ?? 5000;

    print("bleeeeeee" + bleLength.toString());
    if (bleDataList.length > bleLength) {
      if (bleDataList_copy.length > 5000) {
        bleDataList_copy.clear();
      }
      bleDataList_copy.addAll(bleDataList);
      bleDataList.clear();

      // getListToCsv(bleDataList_copy);

      //bleDataList_copy.clear();
    }
  }

  getListToCsv(List<BleDataModel> bleDataList) {
    // List<List<dynamic>> rows = List<List<dynamic>>();
    List<List<dynamic>> rows = [];

    ///patient_id,time_stamp,ir1_value,red1_value,acc1_value,ir2_value,red2_value,acc2_value,accx_value,
    ///accy_value,accz_value,gyrx_value,gyry_value,gyrz_value,magx_value,magy_value,magz_value
    ///,gsr_ecg_value,batt_val,sens_temp,hr_calc,heart_rate,value_22,value_23,value_24
    List<dynamic> row = [];
    // List<dynamic> row = List();
    row.add("patient_id");
    row.add("time_stamp");
    row.add("ir1_value");
    row.add("red1_value");
    row.add("acc1_value");
    row.add("ir2_value");
    row.add("red2_value");
    row.add("acc2_value");
    row.add("accx_value");
    row.add("accy_value");
    row.add("accz_value");
    row.add("gyrx_value");
    row.add("gyry_value");
    row.add("gyrz_value");
    row.add("magx_value");
    row.add("magy_value");
    row.add("magz_value");
    row.add("gsr_ecg_value");
    row.add("batt_val");
    row.add("sens_temp");
    row.add("hr_calc");
    row.add("heart_rate");
    row.add("value_22");
    row.add("value_23");
    row.add("value_24");
    rows.insert(0, row);

    for (int i = 0; i < bleDataList.length; i++) {
      // List<dynamic> row = List();
      List<dynamic> row = [];
      row.add("${addPatientModel!.id.toString()}");
      row.add(bleDataList[i].timeStamp);
      row.add(bleDataList[i].IR1Value);
      row.add(bleDataList[i].Red1Value);
      row.add(bleDataList[i].ACC1Value);
      row.add(bleDataList[i].IR2Value);
      row.add(bleDataList[i].Red2Value);
      row.add(bleDataList[i].ACC2Value);
      row.add(bleDataList[i].ACCxValue);
      row.add(bleDataList[i].ACCyValue);
      row.add(bleDataList[i].ACCzValue);
      row.add(bleDataList[i].GYRxValue);
      row.add(bleDataList[i].GYRyValue);
      row.add(bleDataList[i].GYRzValue);
      row.add(bleDataList[i].MAGxValue);
      row.add(bleDataList[i].MAGyValue);
      row.add(bleDataList[i].MAGzValue);
      row.add(bleDataList[i].GSR_ECGValue);
      row.add(bleDataList[i].battVal);
      row.add(bleDataList[i].sensTemp);
      row.add(bleDataList[i].hrCalc);
      row.add(bleDataList[i].heartRate);
      row.add("0");
      row.add("0");
      row.add("0");
      rows.add(row);
    }
    print("roe" + rows.toString());
    createCsvFile(rows);
  }

  int csvFileUpdateCounter = 1;
  List csvfileList = [];

  createCsvFile(List<List<dynamic>> rows) async {
    DateTime now = DateTime.now();

    ///17 03 2021
    // if(await Permission.storage.request().isGranted) {
    //   final directory = await getApplicationDocumentsDirectory();
    //   // if(Directory("CSVData").exists() == false) {
    //   //   Directory("CSVData").create();
    //   // }
    //   // List file = new List();
    //   // file = Directory(directory.path +"/CSVData").listSync();
    //
    //  // final pathOfTheFileToWrite = directory.path + "/CSVData/${file.length +1}.csv";
    //   final pathOfTheFileToWrite = directory.path + "/CSVData.csv";
    //    csvFile = File(pathOfTheFileToWrite);
    //
    //   String csv = const ListToCsvConverter().convert(rows);
    //   csvFile.writeAsString(csv);
    //   print("write csv data file path ${csvFile.path}");
    //   //print("write csv $csv");
    //  // uploadCsvOnAPI(csvFile);
    //  // return csvFile.path;
    // }
    print("permissionnn" +
        await Permission.storage.request().isGranted.toString());
    if (await Permission.storage.request().isGranted) {
      createDirectory().then((value) {
        final pathOfTheFileToWrite =
            value + "/CSVFile #date$now #counter$csvFileUpdateCounter.csv";
        File csvFile = File(pathOfTheFileToWrite);
        String csv = const ListToCsvConverter().convert(rows);
        csvFile.writeAsString(csv).then((fvalue) async {
          csvfileList.add(fvalue);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          print("filepath" + fvalue.path);
          await prefs.setString("CsvFileVal", json.encode(fvalue));
          //   uploadCsvOnAPI(fvalue);
        });

        print("write csv data file path ${csvFile.path} and list file length");
      });
    }
  }

  Future createDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder = Directory('${directory.path}/CSVData');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  bytesTo8Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      var bytes = data.buffer.asByteData();
      return bytes.getInt8(byteOffset);
    }
  }

  bytesTo16Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      var bytes = data.buffer.asByteData();
      return bytes.getInt16(byteOffset, Endian.big);
    }
  }

  bytesTo32Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      var bytes = data.buffer.asByteData();
      return bytes.getInt32(byteOffset, Endian.big);
    }
  }
  //https://stackoverflow.com/questions/3345553/how-do-you-convert-3-bytes-into-a-24-bit-number-in-c

  bytesTo24Bit(Uint8List data, int byteOffset) {
    print("dataaaaaaa" + data.toString());
    if (data != null && byteOffset != null) {
      Uint8List dataList = Uint8List.fromList(
          [data[byteOffset], data[byteOffset + 1], data[byteOffset + 2]]);
      // return ReadBuffer.fromUint8List(dataList).uint24;
      ByteData byteData = ByteData.sublistView(dataList);
      return ReadBuffer(byteData);
    }
  }

  uploadCsvOnAPI(File filename) async {

    var uri = Uri.parse("$BASE_URL/import-patient-data");
    var request = http.MultipartRequest('POST', uri);
    request.headers["Accept"] = "application/json";
    request.headers["Authorization"] = (await LocalStorageService.getToken())!;
    print("request headers ${request.headers}");

    request.files
        .add(await http.MultipartFile.fromPath('csv_file', filename.path));
    print("request ${request}");
    showToast("uploading csv file wait few second");
    var response = await request.send();
    print("response  ${await response.statusCode.toString()}");
    print(response.reasonPhrase.toString());
    if (response.statusCode == 200) {
      print("Uploaded Success");
      showToast("Successfully upload csv file");
    } else {
      print("Upload Failed");
      showToast("Upload Failed");
    }
    response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .listen((value) {
      ResponseImportCsv? res;
      print("value $value");
      if (response.statusCode == 200 && res != null) {
        res = ResponseImportCsv.fromJson(value as Map<String, dynamic>);
        if (res.meta!.code == 1) {
          csvFileUpdateCounter++;
          csvfileList.remove(filename);
          filename.delete();
        }
      }
    });
  }
}

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, required this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          // Text(
          //   result.device.id.toString(),
          //   style: Theme.of(context).textTheme.caption,
          // )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  checkingConnectedOrNot(BuildContext context, BluetoothDevice deviceBLE) {
    final Ble = deviceBLE.state;
    var ev;
    final subscription = Ble.listen((event) {
      print("ble state $event");
      ev = event;
    });
    if (ev == BluetoothDeviceState.connected) {
      subscription.cancel();
      showCupertinoDialog(context, "${deviceBLE.name} is Connected", deviceBLE);
      print(" subscription.cancel ${subscription.runtimeType} ");
    } else if (ev == BluetoothDeviceState.disconnected) {
      subscription.cancel();
      showCupertinoDialog(context, "${deviceBLE.name} is Not Connected");
      print(" subscription.cancel ${subscription.runtimeType} ");
    }
  }

  streamBuilder(BuildContext context, BluetoothDevice deviceBLE) {
    StreamBuilder<BluetoothDeviceState>(
        stream: deviceBLE.state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == BluetoothDeviceState.connected) {
              showCupertinoDialog(
                  context, "${deviceBLE.name} is Connected", deviceBLE);
            } else if (snapshot.data == BluetoothDeviceState.disconnected) {
              showCupertinoDialog(
                  context, "${deviceBLE.name} is Not Connected");
            }
          }
          /////*********************////////////
          return Container();
        });
  }

  showCupertinoDialog(BuildContext context, String messages,
      [BluetoothDevice? deviceBLE]) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: new Text(messages),
            //title: new Text("$deviceName is Connected"),
            //content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoardCardPage()));
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      trailing: ElevatedButton(
        child: Text(
          'CONNECT',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        onPressed: (result.advertisementData.connectable)
            ? onTap
            : () {
                print("null");
                null;
              },
      ),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceScreen {
  DeviceScreen({state, device, addPatientModel}) {
    this.addPatientModel = addPatientModel;
    this.device = device;
    this.state = state;
    initialize();
  }

  ListPatientsData? addPatientModel;
  BluetoothDevice? device;

  // List<Widget> _buildServiceTiles(List<BluetoothService> services) {
  //   List<int> f0f0Data = [];
  //   List<int> f0d0Data = [];
  //
  //   return services
  //       .map(
  //           (s) {
  //         return   ServiceTile(
  //           service: s,
  //           characteristicTiles: s.characteristics
  //               .map(
  //                   (c) {
  //                 //debugPrint("services list inside service number $s and characteristics $c");
  //                 return  CharacteristicTile(
  //                   characteristic: c,
  //                   onReadPressed: () {
  //                     c.read();
  //
  //                   },
  //                   onWritePressed: () async {
  //                     await c.write(_getRandomBytes(), withoutResponse: true);
  //                     await c.read();
  //                   },
  //                   onNotificationPressed: () async {
  //                     await c.setNotifyValue(!c.isNotifying);
  //                     var value =  await c.read();
  //
  //                   },
  //                   descriptorTiles: c.descriptors
  //                       .map(
  //                         (d) => DescriptorTile(
  //                       descriptor: d,
  //                       onReadPressed: () => d.read(),
  //                       onWritePressed: () => d.write(_getRandomBytes()),
  //                     ),
  //                   )
  //                       .toList(),
  //                 );
  //                 debugPrint("services list $s");
  //               }
  //           )
  //               .toList(),
  //         );
  //       }
  //   )
  //       .toList();
  // }

/*
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context)
        .patientModelBloc
        .patientModelStream.listen((event) {
      addPatientModel = event;
      debugPrint("addPatientModel ${addPatientModel.toString()}");

    });
    debugPrint("addPatientModel build ${addPatientModel.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name ?? ""),
        actions: <Widget>[

          // StreamBuilder<BluetoothDeviceState>(
          //   stream: device.state,
          //   initialData: BluetoothDeviceState.connecting,
          //   builder: (c, snapshot) {
          //     VoidCallback onPressed;
          //     String text;
          //     switch (snapshot.data) {
          //       case BluetoothDeviceState.connected:
          //         onPressed = () => device.disconnect();
          //         text = 'DISCONNECT';
          //         break;
          //       case BluetoothDeviceState.disconnected:
          //         onPressed = () => device.connect();
          //         text = 'CONNECT';
          //         break;
          //       default:
          //         onPressed = null;
          //         text = snapshot.data.toString().substring(21).toUpperCase();
          //         break;
          //     }
          //     return FlatButton(
          //         onPressed: onPressed,
          //         child: Text(
          //           text,
          //           style: Theme.of(context)
          //               .primaryTextTheme
          //               .button
          //               .copyWith(color: Colors.white),
          //         ));
          //   },
          // )
          //

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                // trailing: StreamBuilder<bool>(
                //   stream: device.isDiscoveringServices,
                //   initialData: false,
                //   builder: (c, snapshot) => IndexedStack(
                //     index: snapshot.data ? 1 : 0,
                //     children: <Widget>[
                //       IconButton(
                //         icon: Icon(Icons.refresh),
                //         onPressed: () => device.discoverServices(),
                //       ),
                //       IconButton(
                //         icon: SizedBox(
                //           child: CircularProgressIndicator(
                //             valueColor: AlwaysStoppedAnimation(Colors.grey),
                //           ),
                //           width: 18.0,
                //           height: 18.0,
                //         ),
                //         onPressed: null,
                //       )
                //     ],
                //   ),
                // ),
              ),
            ),
            SizedBox(height: 50,),
            RaisedButton(onPressed: (){

              initialize();

            }, child: Text("Start notifications step 1"),),

            SizedBox(height: 50,),

            RaisedButton(onPressed: (){
              ClearBleRequest();

            }, child: Text("after device disconnected call Stop notifications step 2"),),

            SizedBox(height: 50,),

            RaisedButton(onPressed: () async {
              getListToCsv(bleDataList_copy);
              //getListToCsv(bleDataList_copy);
              //   if(csvFile.path != null){
              //   uploadCsvOnAPI(csvFile);
              // }
            }, child: Text("Upload CSV on API step 3"),),



            // StreamBuilder<int>(
            //     stream: device.mtu,
            //     initialData: 0,
            //     builder: (c, snapshot) {
            //       return ListTile(
            //         title: Text('MTU Size'),
            //         subtitle: Text('${snapshot.data} bytes'),
            //         trailing: IconButton(
            //             icon: Icon(Icons.edit),
            //             onPressed: () {
            //               var deviceMTUSize = 27 + 3;
            //               if(deviceMTUSize != null){
            //                 device.requestMtu(deviceMTUSize);
            //               }
            //             }
            //         ),
            //       );
            //     }
            // ),
            // StreamBuilder<List<BluetoothService>>(
            //   stream: device.services,
            //   initialData: [],
            //   builder: (c, snapshot) {
            //     return Column(
            //       children: _buildServiceTiles(snapshot.data),
            //     );
            //   },
            // ),
            //

          ],
        ),
      ),
    );
  }
*/

  disconnectBleDevice() {
    device!.disconnect();

    characteristicStreamSubscription!.cancel();
    characteristicStreamSubscription = null;
    // bleStateStreamSubscription.cancel();
    // bleStateStreamSubscription = null;
  }

  StreamSubscription? characteristicStreamSubscription;
  StreamSubscription? bleStateStreamSubscription;
  BluetoothCharacteristic? cState;
  List<int> f0f1 = [];
  List<int> f0d1 = [];
  File? csvFile;
  BluetoothDeviceState? state;
  // List<BleDataModel> bleDataList = new List<BleDataModel>();
  // List<BleDataModel> bleDataList_copy = new List<BleDataModel>();
  // List<BleDataModel> addInCSVBleData = new List<BleDataModel>();
  List<BleDataModel> bleDataList = [];
  List<BleDataModel> bleDataList_copy = [];
  List<BleDataModel> addInCSVBleData = [];
  Future<void> initialize() async {
    // var availableServiceCharacteristicNotifications ={
    //   PPG_SERVICE_CHARACTERISTIC_UUID : "f0f0",
    //   DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d0"
    // };
    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID: "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID: "f0d1"
    };

    var deviceMTUSize = 27 + 3;
    device!.requestMtu(deviceMTUSize);
    // bleStateStreamSubscription = device.state.listen((event) {
    //   state = event;
    //   print("bleStateSub $event");
    // });

    //Future.delayed(Duration(seconds: 2));

    // List<BluetoothService> services = new List();
    List<BluetoothService> services = [];
    //  if(state == BluetoothDeviceState.connected){
    // services = await device.discoverServices();
    //  print("services $services");
    //  }

    // var isDiscoveringServices = device.isDiscoveringServices;
    //  print("device.isDiscoveringServices $isDiscoveringServices");
    //  if(isDiscoveringServices == false){
    //    services = await device.discoverServices();
    //
    //  }

    bool isServicesDiscovered = false;
    //if(state == BluetoothDeviceState.connected) {
    print("BluetoothDeviceState.connectedsssssssssssss");
    device!.discoverServices().then((s) {
      services = s;
      isServicesDiscovered = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      if (!isServicesDiscovered && device != null)
        device!.discoverServices().then((s) {
          services = s;
        });
    });
    // }
    if (services != null)
      await Future.forEach(services, (BluetoothService service) async {
        var characteristics = service.characteristics;
        //print("services $services");
        await Future.forEach(characteristics,
            (BluetoothCharacteristic c) async {
          final uuidString = c.uuid.toString();
          // print("characteristics $uuidString");
          if (Characteristics.containsKey(uuidString)) {
            // print("characteristics containsKey $uuidString");
            final characteristicName = Characteristics[uuidString];
            //print("characteristics containsKey $uuidString");
            //if (availableServiceCharacteristicNotifications[characteristicName] != null) {

            cState = c;
            await Future.delayed(new Duration(seconds: 1), () async {
              readCharacteristic(uuidString, cState);
            });
            //  }
          }
        });
      });
  }

  readCharacteristic(uuidString, cState) async {
    await cState.setNotifyValue(true);
    showToast("wait few second after press step 2");
    characteristicStreamSubscription = cState.value.listen(
      (event) {
        if (uuidString == PPG_SERVICE_CHARACTERISTIC_UUID) {
          if (event != null) {
            f0f1 = event;
          }
        } else if (uuidString == DOF_SERVICE_CHARACTERISTIC_UUID) {
          if (event != null) {
            f0d1 = event;
          }
        }

        createListBleModel(bleDataF0F1: f0f1, bleDataF0D1: f0d1);
      },
    );
  }

  ClearBleRequest() {
    //getListToCsv(bleDataList);
    cState!.setNotifyValue(false);
    characteristicStreamSubscription!.cancel();
    device!.disconnect();
  }

  BleDataModel bleDataCalculation(
      {required List<int> bleDataF0F1, required List<int> bleDataF0D1}) {
    //List<int> dataF0F1 = bleDataF0F1; //24
    //List<int> dataF0D1 = bleDataF0D1; //18

    Uint8List? F0F1List;
    if (bleDataF0F1 != null) {
      F0F1List = Uint8List.fromList(bleDataF0F1);
    }
    Uint8List? F0D1List;

    if (bleDataF0D1 != null) {
      F0D1List = Uint8List.fromList(bleDataF0D1);
    }
    int swRevision = 29;
    bool layoutSetup = false;
    int? battVal;
    int? hrCalc;
    double swHigh;
    double swLow;
    int? heartRate;
    int heartRate2;

    double sensTemp = 0;
    var sensType = 0x01;
    var temp;
    List<BleDataModel> bleDataList = [];
    PpgActivityModel ppgActivityModel = PpgActivityModel();
    BleDataModel bleDataModel = BleDataModel();

    if (F0F1List != null) {
      bleDataModel.IR1Value = bytesTo24Bit(F0F1List, 0);
      bleDataModel.BatterylevelValue = bytesTo8Bit(F0F1List, 3);
      bleDataModel.Red1Value = bytesTo24Bit(F0F1List, 4);
      bleDataModel.Heartratesensor1Value = bytesTo8Bit(F0F1List, 7);
      bleDataModel.ACC1Value = bytesTo16Bit(F0F1List, 8);
      bleDataModel.IR2Value = bytesTo24Bit(F0F1List, 10);
      bleDataModel.Heartratesensor2Value = bytesTo8Bit(F0F1List, 13);
      bleDataModel.Red2Value = bytesTo32Bit(F0F1List, 14);
      bleDataModel.ACC2Value = bytesTo16Bit(F0F1List, 18);
      bleDataModel.GSR_ECGValue = bytesTo16Bit(F0F1List, 20);
      bleDataModel.Temp_integral_part = bytesTo8Bit(F0F1List, 22);
      bleDataModel.Temp_fractional_part = bytesTo8Bit(F0F1List, 23);
    }
    sensTemp =
        ((bytesTo8Bit(F0F1List!, 22) * 100) + bytesTo8Bit(F0F1List, 23)) / 100;

    //var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
    var timeStamp = DateTime.now();
    bleDataModel.timeStamp = timeStamp;

    /// F0D0
    if (F0D1List != null) {
      bleDataModel.ACCxValue = (bytesTo16Bit(F0D1List, 0) / 1000);
      bleDataModel.ACCyValue = (bytesTo16Bit(F0D1List, 2) / 1000);
      bleDataModel.ACCzValue = (bytesTo16Bit(F0D1List, 4) / 1000);
      bleDataModel.GYRxValue = (bytesTo16Bit(F0D1List, 6) / 10);
      bleDataModel.GYRyValue = (bytesTo16Bit(F0D1List, 8) / 10);
      bleDataModel.GYRzValue = (bytesTo16Bit(F0D1List, 10) / 10);
      bleDataModel.MAGxValue = (bytesTo16Bit(F0D1List, 12));
      bleDataModel.MAGyValue = (bytesTo16Bit(F0D1List, 14));
      bleDataModel.MAGzValue = (bytesTo16Bit(F0D1List, 16));
    }

    bleDataModel.battVal = battVal;
    bleDataModel.sensTemp = sensTemp;
    bleDataModel.hrCalc = hrCalc;
    bleDataModel.heartRate = heartRate;

    var dataSet;

    dataSet = "timeStamp :${ppgActivityModel.timeStamp}," +
        "IR1Value  :${ppgActivityModel.IR1Value}," +
        "Red1Value :${ppgActivityModel.Red1Value}," +
        "ACC1Value :${ppgActivityModel.ACC1Value}," +
        "IR2Value  :${ppgActivityModel.IR2Value}," +
        "Red2Value :${ppgActivityModel.Red2Value}," +
        "ACC2Value :${ppgActivityModel.ACC2Value}," +
        "ACCxValue :${ppgActivityModel.ACCxValue}," +
        "ACCyValue :${ppgActivityModel.ACCyValue}," +
        "ACCzValue :${ppgActivityModel.ACCzValue}," +
        "GYRxValue :${ppgActivityModel.GYRxValue}," +
        "GYRyValue :${ppgActivityModel.GYRyValue}," +
        "GYRzValue :${ppgActivityModel.GYRzValue}," +
        "MAGxValue :${ppgActivityModel.MAGxValue}," +
        "MAGyValue :${ppgActivityModel.MAGyValue}," +
        "MAGzValue :${ppgActivityModel.MAGzValue}," +
        "GSR_ECGValue :${ppgActivityModel.GSR_ECGValue}," +
        "battVa :${ppgActivityModel.battVal}," +
        "sensTemp :${ppgActivityModel.sensTemp}," +
        "hrCalc :${ppgActivityModel.hrCalc}," +
        "heartRate :${ppgActivityModel.heartRate}," +
        "\n";

    return bleDataModel;
  }

  createListBleModel(
      {required List<int> bleDataF0F1, required List<int> bleDataF0D1}) async {
    BleDataModel bleDataModel =
        bleDataCalculation(bleDataF0F1: bleDataF0F1, bleDataF0D1: bleDataF0D1);

    bleDataList.add(bleDataModel);
    //print("ble data list length ${bleDataList.length}");
    if (bleDataList.length > 5000) {
      if (bleDataList_copy.length > 5000) {
        bleDataList_copy.clear();
      }
      bleDataList_copy.addAll(bleDataList);
      bleDataList.clear();

      getListToCsv(bleDataList_copy);

      //bleDataList_copy.clear();
    }
  }

  getListToCsv(List<BleDataModel> bleDataList) {
    // List<List<dynamic>> rows = List<List<dynamic>>();
    List<List<dynamic>> rows = [];

    ///patient_id,time_stamp,ir1_value,red1_value,acc1_value,ir2_value,red2_value,acc2_value,accx_value,
    ///accy_value,accz_value,gyrx_value,gyry_value,gyrz_value,magx_value,magy_value,magz_value
    ///,gsr_ecg_value,batt_val,sens_temp,hr_calc,heart_rate,value_22,value_23,value_24
    List<dynamic> row = [];
    // List<dynamic> row = List();
    row.add("patient_id");
    row.add("time_stamp");
    row.add("ir1_value");
    row.add("red1_value");
    row.add("acc1_value");
    row.add("ir2_value");
    row.add("red2_value");
    row.add("acc2_value");
    row.add("accx_value");
    row.add("accy_value");
    row.add("accz_value");
    row.add("gyrx_value");
    row.add("gyry_value");
    row.add("gyrz_value");
    row.add("magx_value");
    row.add("magy_value");
    row.add("magz_value");
    row.add("gsr_ecg_value");
    row.add("batt_val");
    row.add("sens_temp");
    row.add("hr_calc");
    row.add("heart_rate");
    row.add("value_22");
    row.add("value_23");
    row.add("value_24");
    rows.insert(0, row);

    for (int i = 0; i < bleDataList.length; i++) {
      // List<dynamic> row = List();
      List<dynamic> row = [];
      row.add("${addPatientModel!.id.toString()}");
      row.add(bleDataList[i].timeStamp);
      row.add(bleDataList[i].IR1Value);
      row.add(bleDataList[i].Red1Value);
      row.add(bleDataList[i].ACC1Value);
      row.add(bleDataList[i].IR2Value);
      row.add(bleDataList[i].Red2Value);
      row.add(bleDataList[i].ACC2Value);
      row.add(bleDataList[i].ACCxValue);
      row.add(bleDataList[i].ACCyValue);
      row.add(bleDataList[i].ACCzValue);
      row.add(bleDataList[i].GYRxValue);
      row.add(bleDataList[i].GYRyValue);
      row.add(bleDataList[i].GYRzValue);
      row.add(bleDataList[i].MAGxValue);
      row.add(bleDataList[i].MAGyValue);
      row.add(bleDataList[i].MAGzValue);
      row.add(bleDataList[i].GSR_ECGValue);
      row.add(bleDataList[i].battVal);
      row.add(bleDataList[i].sensTemp);
      row.add(bleDataList[i].hrCalc);
      row.add(bleDataList[i].heartRate);
      row.add("0");
      row.add("0");
      row.add("0");
      rows.add(row);
    }
    createCsvFile(rows);
  }

  int csvFileUpdateCounter = 1;
  List csvfileList = [];

  createCsvFile(List<List<dynamic>> rows) async {
    DateTime now = DateTime.now();

    ///17 03 2021
    // if(await Permission.storage.request().isGranted) {
    //   final directory = await getApplicationDocumentsDirectory();
    //   // if(Directory("CSVData").exists() == false) {
    //   //   Directory("CSVData").create();
    //   // }
    //   // List file = new List();
    //   // file = Directory(directory.path +"/CSVData").listSync();
    //
    //  // final pathOfTheFileToWrite = directory.path + "/CSVData/${file.length +1}.csv";
    //   final pathOfTheFileToWrite = directory.path + "/CSVData.csv";
    //    csvFile = File(pathOfTheFileToWrite);
    //
    //   String csv = const ListToCsvConverter().convert(rows);
    //   csvFile.writeAsString(csv);
    //   print("write csv data file path ${csvFile.path}");
    //   //print("write csv $csv");
    //  // uploadCsvOnAPI(csvFile);
    //  // return csvFile.path;
    // }

    if (await Permission.storage.request().isGranted) {
      createDirectory().then((value) {
        final pathOfTheFileToWrite =
            value + "/CSVFile #date$now #counter$csvFileUpdateCounter.csv";
        File csvFile = File(pathOfTheFileToWrite);
        String csv = const ListToCsvConverter().convert(rows);
        csvFile.writeAsString(csv).then((fvalue) {
          csvfileList.add(fvalue);
          // uploadCsvOnAPI(fvalue);
        });

        print("write csv data file path ${csvFile.path} and list file length");
      });
    }
  }

  Future createDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder = Directory('${directory.path}/CSVData');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  bytesTo8Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      var bytes = data.buffer.asByteData();
      return bytes.getInt8(byteOffset);
    }
  }

  bytesTo16Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      var bytes = data.buffer.asByteData();
      return bytes.getInt16(byteOffset, Endian.big);
    }
  }

  bytesTo32Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      var bytes = data.buffer.asByteData();
      return bytes.getInt32(byteOffset, Endian.big);
    }
  }

  ///https://stackoverflow.com/questions/3345553/how-do-you-convert-3-bytes-into-a-24-bit-number-in-c
  bytesTo24Bit(Uint8List data, int byteOffset) {
    if (data != null && byteOffset != null) {
      Uint8List dataList = Uint8List.fromList(
          [data[byteOffset], data[byteOffset + 1], data[byteOffset + 2]]);
      ByteData byteData = ByteData.sublistView(dataList);
      return ReadBuffer(byteData);
    }
  }
}
