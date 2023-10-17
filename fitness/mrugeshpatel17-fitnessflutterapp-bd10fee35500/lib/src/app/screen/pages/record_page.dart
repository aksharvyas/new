




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
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:flutter/foundation.dart';

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
import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/ble_listing_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/googlemap_page.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



///3 (third screen)
class RecordPage extends StatefulWidget {

  ListPatientsData addPatientModel;
  RecordPage(this.addPatientModel);
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: GestureDetector(
            onTap: ()async{

            },
            child: Container(
              decoration:
              BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appBarPng),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(recordText,style: appbarTextStyle,),
          //centerTitle: true,
          leadingWidth: 25,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Image.asset(backButtonPng,),
            ),
          ),
        actions: [

          IconButton(icon:Icon(FontAwesomeIcons.bluetoothB),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FitnessBLEApp(addPatientModel: widget.addPatientModel,);
            }));
          })


        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(tabBarPng),
                      fit: BoxFit.fill
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return GoogleMapPage(widget.addPatientModel);
                        }));
                      },
                      child: Container(child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text(trainingText,style: tabbarTextStyle,),
                      )),
                    ),
                    VerticalDivider(color: Colors.white,indent: 10,endIndent: 10,),
                    Container(child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(monitoringText,style: tabbarTextStyle),
                    )),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15,10,15,15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 6,),
                              assetCircleImage(imageName: trainingModeIconPng),
                              SizedBox(width: 10,),
                              Text(trainingModeText,style: cardTextStyle,)
                            ],
                          ),
                          SizedBox(height: 8,),
                          InkWell( onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return GoogleMapPage(widget.addPatientModel);
                            }));
                          },child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius:BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(bicyclePng),
                                  fit: BoxFit.fill
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}



class BleDiscoveryServices extends StatelessWidget {
  BuildContext? context;
  ListPatientsData addPatientModel;
  BluetoothDevice? device;
  BleDiscoveryServices({required this.device,required this.addPatientModel,required this.context});
  // BleDiscoveryServices({device,addPatientModel,context}){
  //   this.device = device;
  //   this.addPatientModel = addPatientModel;
  //   this.context = context;
  //   print("cons device ${this.device} addPatientModel ${this.addPatientModel} ");
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    initializeBLEServices();
    return RecordPage(addPatientModel);
  }

  StreamSubscription? characteristicStreamSubscription;
  StreamSubscription? stateStreamSubscription;
  BluetoothCharacteristic? cState;
  List<int> f0f1 = [];
  List<int> f0d1 = [];
  File? csvFile;
  BluetoothDeviceState? state;
  // List<BleDataModel> bleDataList = new List<BleDataModel>();
  // List<BleDataModel> addInCSVBleData = new List<BleDataModel>();
  List<BleDataModel> bleDataList=[];
  List<BleDataModel> addInCSVBleData=[];
  bool bleConnected(device){
    stateStreamSubscription =  device.state.listen((event) {
      state = event;
    });
    if(state == BluetoothDeviceState.connected){
      stateStreamSubscription!.pause();
      return true;
    } else {
      return false;
    }

  }

  Future<void> initializeBLEServices() async {
    BlocProvider.of<GlobalBloc>(context!).patientModelBloc.patientModelStream.listen((event) {
      addPatientModel = event;
      debugPrint("addPatientModel initializeBLEServices ${addPatientModel.toString()}");
    });

    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID : "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d1"
    };

    var deviceMTUSize = 27 + 3;

    device!.requestMtu(deviceMTUSize);
    List<BluetoothService>? services;
    if(state == BluetoothDeviceState.connected){
      services = await device!.discoverServices();
      print("services $services");
    }

    await Future.forEach(services!, (BluetoothService service) async{
      var characteristics = service.characteristics;
      await Future.forEach(characteristics, (BluetoothCharacteristic c) async {
        final uuidString = c.uuid.toString();
        if (Characteristics.containsKey(uuidString)) {
          final characteristicName = Characteristics[uuidString];
          cState = c;
          await Future.delayed(new Duration(seconds: 1),
                  () async {
                readCharacteristic(uuidString,cState);
              });
        }
      });});


  }
  readCharacteristic(uuidString,cState)async{
    await cState.setNotifyValue(true);

    characteristicStreamSubscription = cState.value.listen((event) {
      if(uuidString == PPG_SERVICE_CHARACTERISTIC_UUID){
        if(event!=null){ f0f1 = event; }
      } else if(uuidString == DOF_SERVICE_CHARACTERISTIC_UUID){
        if(event!=null) {   f0d1 = event; }
      }
      createListBleModel(bleDataF0F1:f0f1,bleDataF0D1: f0d1);
    }, );
  }


  bleDisconnectRequest(){

    characteristicStreamSubscription!.cancel();
    cState!.setNotifyValue(false);
    device!.disconnect();
  }

  BleDataModel bleDataCalculation({required List<int> bleDataF0F1,required List<int> bleDataF0D1}){
    //List<int> dataF0F1 = bleDataF0F1; //24
    //List<int> dataF0D1 = bleDataF0D1; //18

    Uint8List? F0F1List;
    if(bleDataF0F1!=null) {
      F0F1List = Uint8List.fromList(bleDataF0F1);
    }
    Uint8List? F0D1List;

    if(bleDataF0D1!=null) {
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

    if(F0F1List!=null){
      bleDataModel.IR1Value = bytesTo24Bit(F0F1List,0);
      bleDataModel.BatterylevelValue  = bytesTo8Bit(F0F1List,3);
      bleDataModel.Red1Value = bytesTo24Bit(F0F1List,4);
      bleDataModel.Heartratesensor1Value = bytesTo8Bit(F0F1List,7);
      bleDataModel.ACC1Value = bytesTo16Bit(F0F1List,8);
      bleDataModel.IR2Value = bytesTo24Bit(F0F1List,10);
      bleDataModel.Heartratesensor2Value  = bytesTo8Bit(F0F1List,13);
      bleDataModel.Red2Value = bytesTo32Bit(F0F1List,14);
      bleDataModel.ACC2Value = bytesTo16Bit(F0F1List,18);
      bleDataModel.GSR_ECGValue = bytesTo16Bit(F0F1List,20);
      bleDataModel.Temp_integral_part = bytesTo8Bit(F0F1List,22);
      bleDataModel.Temp_fractional_part = bytesTo8Bit(F0F1List,23);
    }
    sensTemp = ((bytesTo8Bit(F0F1List!,22)*100)+bytesTo8Bit(F0F1List,23))/100;

    var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
    //var timeStamp = DateTime.now();
    bleDataModel.timeStamp = timeStamp;
    /// F0D0
    if(F0D1List!=null){
      bleDataModel.ACCxValue = (bytesTo16Bit(F0D1List,0)/1000);
      bleDataModel.ACCyValue = (bytesTo16Bit(F0D1List,2)/1000);
      bleDataModel.ACCzValue = (bytesTo16Bit(F0D1List,4)/1000);
      bleDataModel.GYRxValue = (bytesTo16Bit(F0D1List,6)/10);
      bleDataModel.GYRyValue = (bytesTo16Bit(F0D1List,8)/10);
      bleDataModel.GYRzValue = (bytesTo16Bit(F0D1List,10)/10);
      bleDataModel.MAGxValue = (bytesTo16Bit(F0D1List,12));
      bleDataModel.MAGyValue = (bytesTo16Bit(F0D1List,14));
      bleDataModel.MAGzValue = (bytesTo16Bit(F0D1List,16));
    }


    bleDataModel.battVal = battVal;
    bleDataModel.sensTemp =sensTemp;
    bleDataModel.hrCalc = hrCalc;
    bleDataModel.heartRate = heartRate;

    var dataSet;

    dataSet = "timeStamp :${ppgActivityModel.timeStamp}," +
        "IR1Value  :${ppgActivityModel.IR1Value}," +
        "Red1Value :${ ppgActivityModel.Red1Value}," +
        "ACC1Value :${ppgActivityModel.ACC1Value}," +
        "IR2Value  :${ppgActivityModel.IR2Value }," +
        "Red2Value :${ppgActivityModel.Red2Value }," +
        "ACC2Value :${ppgActivityModel.ACC2Value }," +
        "ACCxValue :${ppgActivityModel.ACCxValue }," +
        "ACCyValue :${ppgActivityModel.ACCyValue }," +
        "ACCzValue :${ppgActivityModel.ACCzValue }," +
        "GYRxValue :${ppgActivityModel.GYRxValue }," +
        "GYRyValue :${ppgActivityModel.GYRyValue }," +
        "GYRzValue :${ppgActivityModel.GYRzValue }," +
        "MAGxValue :${ppgActivityModel.MAGxValue }," +
        "MAGyValue :${ppgActivityModel.MAGyValue }," +
        "MAGzValue :${ppgActivityModel.MAGzValue }," +
        "GSR_ECGValue :${ppgActivityModel.GSR_ECGValue }," +
        "battVa :${ppgActivityModel.battVal}," +
        "sensTemp :${ppgActivityModel.sensTemp}," +
        "hrCalc :${ppgActivityModel.hrCalc}," +
        "heartRate :${ppgActivityModel.heartRate}," +
        "\n";
    return bleDataModel;
  }



  createListBleModel({required List<int> bleDataF0F1,required List<int> bleDataF0D1})async{
    BleDataModel bleDataModel = bleDataCalculation(bleDataF0F1: bleDataF0F1,bleDataF0D1: bleDataF0D1);
    bleDataList.add(bleDataModel);
    print("ble data list length ${bleDataList.length}");
    callAPIListToCsv();
  }
  Timer? timerForCsvFile;
  int timerTickCall = 0;
  callAPIListToCsv(){
    timerForCsvFile = Timer.periodic(Duration(minutes:  4), (timer) {
      if(bleDataList != null){
        print("timer = $timer");
        getListToCsv(bleDataList);
        timerTickCall++;
      }
    });
  }
  getListToCsv(List<BleDataModel> bleDataList)async{
    // List<List<dynamic>> rows = List<List<dynamic>>();
    List<List<dynamic>> rows=[];
    ///patient_id,time_stamp,ir1_value,red1_value,acc1_value,ir2_value,red2_value,acc2_value,accx_value,
    ///accy_value,accz_value,gyrx_value,gyry_value,gyrz_value,magx_value,magy_value,magz_value
    ///,gsr_ecg_value,batt_val,sens_temp,hr_calc,heart_rate,value_22,value_23,value_24
    // List<dynamic> row = List();
    List<dynamic> row=[];
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
    rows.insert(0,row);

    print("addPatientModel csv  $addPatientModel");
    for (int i = 0; i < bleDataList.length ;i++) {
      // List<dynamic> row = List();
      List<dynamic> row=[];
      row.add("${addPatientModel.id.toString()}");
      row.add(bleDataList[i].timeStamp);
      row.add(bleDataList[i].IR1Value);
      row.add(bleDataList[i].Red1Value);
      row.add(bleDataList[i].ACC1Value);
      row.add(bleDataList[i].IR2Value );
      row.add(bleDataList[i].Red2Value );
      row.add(bleDataList[i].ACC2Value );
      row.add(bleDataList[i].ACCxValue );
      row.add(bleDataList[i].ACCyValue);
      row.add(bleDataList[i].ACCzValue );
      row.add(bleDataList[i].GYRxValue );
      row.add(bleDataList[i].GYRyValue );
      row.add(bleDataList[i].GYRzValue );
      row.add(bleDataList[i].MAGxValue );
      row.add(bleDataList[i].MAGyValue );
      row.add(bleDataList[i].MAGzValue );
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
    debugPrint("sss csv rows length ${rows.length}");

    createCsvFile(rows);

  }

  int csvFileUpdateCounter = 0;
  List<File> csvFileList  = [];
  createCsvFile(List<List<dynamic>> rows) async {
    DateTime now = DateTime.now();
    if(await Permission.storage.request().isGranted) {
      final directory = await getApplicationDocumentsDirectory();
      final pathOfTheFileToWrite = directory.path + "/BleSensorData #counter$csvFileUpdateCounter.csv";
      csvFile = File(pathOfTheFileToWrite);
      String csv = const ListToCsvConverter().convert(rows);
      csvFile!.writeAsString(csv);
      print("write csv data file path ${csvFile!.path}");

      uploadCsvOnAPI(csvFile!);
    }
  }


  void uploadCsvOnAPI(File filename) async{
    var uri = Uri.parse("$BASE_URL/import-patient-data");
    var request = http.MultipartRequest('POST',uri);
    request.headers["Accept"] = "application/json";
    request.headers["Authorization"] = await LocalStorageService.getToken().toString();
    print("request headers ${request.headers}");

    request.files.add(
        await http.MultipartFile.fromPath(
            'csv_file',filename.path
        )
    );
    print("request ${request}");
    var response = await request.send();
    print("response  $response");
    if (response.statusCode == 200) {
      print("Uploaded Success");
      showToast("csv uploaded Successfully");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).transform(json.decoder).listen((value) {
      ResponseImportCsv? res;
      print("value $value");
      if(response.statusCode == 200 && res!=null){
        res = ResponseImportCsv.fromJson(value as Map<String,dynamic>);
      }
      if(res!.meta!.code == 1){
        csvFileList.add(csvFile!);
        csvFileUpdateCounter++;
        // if(csvFile.exists() == true){
        //   csvFile.delete();
        // }
        print("res.meta.code  ${res.meta!.message}");
        print("csvFileUpdateCounter value $csvFileUpdateCounter");
      }
    });

  }


  bytesTo8Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      var bytes = data.buffer.asByteData();
      return bytes.getInt8(byteOffset);
    }}
  bytesTo16Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      var bytes = data.buffer.asByteData();
      return bytes.getInt16(byteOffset,Endian.big);
    }}

  bytesTo32Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      var bytes = data.buffer.asByteData();
      return bytes.getInt32(byteOffset,Endian.big);
    }}
  ///https://stackoverflow.com/questions/3345553/how-do-you-convert-3-bytes-into-a-24-bit-number-in-c
  bytesTo24Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      Uint8List dataList = Uint8List.fromList([data[byteOffset],data[byteOffset+1],data[byteOffset+2]]);
      // return ReadBuffer.fromUint8List(dataList).uint24;
      ByteData byteData = ByteData.sublistView(dataList);
      return ReadBuffer(byteData);
    }}




}





class DeviceScreen extends StatelessWidget {
  late ListPatientsData addPatientModel;
  late final BluetoothDevice device;
  DeviceScreen({Key? key, required this.device,required this.addPatientModel}) : super(key: key);



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

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context)
        .patientModelBloc
        .patientModelStream.listen((event) {
      addPatientModel = event;
      debugPrint("addPatientModel ${addPatientModel.toString()}");

    });
    debugPrint("addPatientModel build ${addPatientModel.toString()}");
    // initialize();
    // if(bleDataList != null){
    //   getListToCsv(bleDataList);
    // }

//    return RecordPage(addPatientModel);

    return Scaffold(
       appBar: AppBar(
         title: Text(device.name==null?"":device.name),
         actions: <Widget>[
           // IconButton(icon: Icon(Icons.clear),
           //   onPressed: (){
           //     ClearBleRequest();
           //   },),
           // IconButton(icon: Icon(Icons.ac_unit),
           //   onPressed: (){
           //    initialize();
           //    // discoverServices(device);
           //     //discoverServices(device);
           //     // readCharacteristicData();
           //     // discoverServicesTarget(device);
           //    // test1();
           //   },),


           StreamBuilder<BluetoothDeviceState>(
             stream: device.state,
             initialData: BluetoothDeviceState.connecting,
             builder: (c, snapshot) {
               VoidCallback onPressed;
               String text;
               switch (snapshot.data) {
                 case BluetoothDeviceState.connected:
                   onPressed = () => device.disconnect();
                   text = 'DISCONNECT';
                   break;
                 case BluetoothDeviceState.disconnected:
                   onPressed = () => device.connect();
                   text = 'CONNECT';
                   break;
                 default:
                   onPressed = (){};
                   text = snapshot.data.toString().substring(21).toUpperCase();
                   break;
               }
               return ElevatedButton(
                   onPressed: onPressed,
                   child: Text(
                     text,
                     style: Theme.of(context)
                         .primaryTextTheme
                         .button!
                         .copyWith(color: Colors.white),
                   ));
             },
           )
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
                 trailing: StreamBuilder<bool>(
                   stream: device.isDiscoveringServices,
                   initialData: false,
                   builder: (c, snapshot) => IndexedStack(
                     index: snapshot.data! ? 1 : 0,
                     children: <Widget>[
                       IconButton(
                         icon: Icon(Icons.refresh),
                         onPressed: () => device.discoverServices(),
                       ),
                       IconButton(
                         icon: SizedBox(
                           child: CircularProgressIndicator(
                             valueColor: AlwaysStoppedAnimation(Colors.grey),
                           ),
                           width: 18.0,
                           height: 18.0,
                         ),
                         onPressed: null,
                       )
                     ],
                   ),
                 ),
               ),
             ),
            SizedBox(height: 50,),
             ElevatedButton(onPressed: (){

               initialize();

             }, child: Text("Start notifications  step 1"),),

             SizedBox(height: 50,),

             ElevatedButton(onPressed: (){
               ClearBleRequest();

             }, child: Text("Stop notifications step 2"),),

             SizedBox(height: 50,),

             ElevatedButton(onPressed: () async {
               getListToCsv(bleDataList);
               await Future.delayed(Duration(seconds: 1));
               if(csvFile!.path != null){
               uploadCsvOnAPI(csvFile!);
             }
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



  disconnectBleDevice(){
    device.disconnect();

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
  // List<BleDataModel> addInCSVBleData = new List<BleDataModel>();
  List<BleDataModel> bleDataList=[];
  List<BleDataModel> addInCSVBleData=[];
  Future<void> initialize() async {


    // var availableServiceCharacteristicNotifications ={
    //   PPG_SERVICE_CHARACTERISTIC_UUID : "f0f0",
    //   DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d0"
    // };
    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID : "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d1"
    };



    var deviceMTUSize = 27 + 3;

    bleStateStreamSubscription = device.state.listen((event) {
      state = event;
      print("bleStateSub $event");
    });

    device.requestMtu(deviceMTUSize);
    List<BluetoothService>? services;
    if(state == BluetoothDeviceState.connected){
      services = await device.discoverServices();
      print("services $services");
    }



    await Future.forEach(services!, (BluetoothService service) async{
      var characteristics = service.characteristics;
      //print("services $services");
      await Future.forEach(characteristics, (BluetoothCharacteristic c) async {
        final uuidString = c.uuid.toString();
        // print("characteristics $uuidString");
        if (Characteristics.containsKey(uuidString)) {
          // print("characteristics containsKey $uuidString");
          final characteristicName = Characteristics[uuidString];
          //print("characteristics containsKey $uuidString");
          //if (availableServiceCharacteristicNotifications[characteristicName] != null) {

          cState = c;
          await Future.delayed(new Duration(seconds: 1),
                  () async {
                readCharacteristic(uuidString,cState);
              });
          //  }

        }
      });

    });



  }


  readCharacteristic(uuidString,cState)async{
    await cState.setNotifyValue(true);

    characteristicStreamSubscription = cState.value.listen((event) {
      if(uuidString == PPG_SERVICE_CHARACTERISTIC_UUID){
        if(event!=null){ f0f1 = event; }
      } else if(uuidString == DOF_SERVICE_CHARACTERISTIC_UUID){
        if(event!=null) {   f0d1 = event; }
      }
      createListBleModel(bleDataF0F1:f0f1,bleDataF0D1: f0d1);
      //bleDataCal(bleDataF0F1:f0f1,bleDataF0D1: f0d1);
      //print("both value f0f1 = $f0f1 ,, f0d1 = $f0d1");
      // var timeStamp = DateTime.now();
      //print("timeStamp $timeStamp");
    }, );
  }


  ClearBleRequest(){
    //getListToCsv(bleDataList);
    device.disconnect();
    characteristicStreamSubscription!.cancel();
    cState!.setNotifyValue(false);
  }

  BleDataModel bleDataCalculation({required List<int> bleDataF0F1,required List<int> bleDataF0D1}){
    //List<int> dataF0F1 = bleDataF0F1; //24
    //List<int> dataF0D1 = bleDataF0D1; //18

    Uint8List? F0F1List;
    if(bleDataF0F1!=null) {
      F0F1List = Uint8List.fromList(bleDataF0F1);
    }
    Uint8List? F0D1List;

    if(bleDataF0D1!=null) {
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

    if(F0F1List!=null){
      // bleDataModel = new BleDataModel(
      // IR1Value : bytesTo24Bit(F0F1List,0),
      // BatterylevelValue  : bytesTo8Bit(F0F1List,3),
      // Red1Value : bytesTo24Bit(F0F1List,4),
      // Heartratesensor1Value: bytesTo8Bit(F0F1List,7),
      // ACC1Value : bytesTo16Bit(F0F1List,8),
      // IR2Value : bytesTo24Bit(F0F1List,10),
      // Heartratesensor2Value  : bytesTo8Bit(F0F1List,13),
      // Red2Value : bytesTo32Bit(F0F1List,14),
      // ACC2Value: bytesTo16Bit(F0F1List,18),
      // GSR_ECGValue : bytesTo16Bit(F0F1List,20),
      // Temp_integral_part : bytesTo8Bit(F0F1List,22),
      // Temp_fractional_part : bytesTo8Bit(F0F1List,23),
      // );
      bleDataModel.IR1Value = bytesTo24Bit(F0F1List,0);
      bleDataModel.BatterylevelValue  = bytesTo8Bit(F0F1List,3);
      bleDataModel.Red1Value = bytesTo24Bit(F0F1List,4);
      bleDataModel.Heartratesensor1Value = bytesTo8Bit(F0F1List,7);
      bleDataModel.ACC1Value = bytesTo16Bit(F0F1List,8);
      bleDataModel.IR2Value = bytesTo24Bit(F0F1List,10);
      bleDataModel.Heartratesensor2Value  = bytesTo8Bit(F0F1List,13);
      bleDataModel.Red2Value = bytesTo32Bit(F0F1List,14);
      bleDataModel.ACC2Value = bytesTo16Bit(F0F1List,18);
      bleDataModel.GSR_ECGValue = bytesTo16Bit(F0F1List,20);
      bleDataModel.Temp_integral_part = bytesTo8Bit(F0F1List,22);
      bleDataModel.Temp_fractional_part = bytesTo8Bit(F0F1List,23);
/*
      ppgActivityModel.IR1Value = bytesTo24Bit(F0F1List,0);
      ppgActivityModel.BatterylevelValue  = bytesTo8Bit(F0F1List,3);
      ppgActivityModel.Red1Value = bytesTo24Bit(F0F1List,4);
      ppgActivityModel.Heartratesensor1Value = bytesTo8Bit(F0F1List,7);
      ppgActivityModel.ACC1Value = bytesTo16Bit(F0F1List,8);
      ppgActivityModel.IR2Value = bytesTo24Bit(F0F1List,10);
      ppgActivityModel.Heartratesensor2Value  = bytesTo8Bit(F0F1List,13);
      ppgActivityModel.Red2Value = bytesTo32Bit(F0F1List,14);
      ppgActivityModel.ACC2Value = bytesTo16Bit(F0F1List,18);
      ppgActivityModel.GSR_ECGValue = bytesTo16Bit(F0F1List,20);
      ppgActivityModel.Temp_integral_part = bytesTo8Bit(F0F1List,22);
      ppgActivityModel.Temp_fractional_part = bytesTo8Bit(F0F1List,23);
*/
    }
    sensTemp = ((bytesTo8Bit(F0F1List!,22)*100)+bytesTo8Bit(F0F1List,23))/100;

    //var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
    var timeStamp = DateTime.now();
    bleDataModel.timeStamp = timeStamp;
    /// F0D0
    if(F0D1List!=null){
      bleDataModel.ACCxValue = (bytesTo16Bit(F0D1List,0)/1000);
      bleDataModel.ACCyValue = (bytesTo16Bit(F0D1List,2)/1000);
      bleDataModel.ACCzValue = (bytesTo16Bit(F0D1List,4)/1000);
      bleDataModel.GYRxValue = (bytesTo16Bit(F0D1List,6)/10);
      bleDataModel.GYRyValue = (bytesTo16Bit(F0D1List,8)/10);
      bleDataModel.GYRzValue = (bytesTo16Bit(F0D1List,10)/10);
      bleDataModel.MAGxValue = (bytesTo16Bit(F0D1List,12));
      bleDataModel.MAGyValue = (bytesTo16Bit(F0D1List,14));
      bleDataModel.MAGzValue = (bytesTo16Bit(F0D1List,16));
      //debugPrint("timeStamp :- $timeStamp,"+ ppgActivityModel.toString());
    }


    bleDataModel.battVal = battVal;
    bleDataModel.sensTemp =sensTemp;
    bleDataModel.hrCalc = hrCalc;
    bleDataModel.heartRate = heartRate;

    var dataSet;

    dataSet = "timeStamp :${ppgActivityModel.timeStamp}," +
        "IR1Value  :${ppgActivityModel.IR1Value}," +
        "Red1Value :${ ppgActivityModel.Red1Value}," +
        "ACC1Value :${ppgActivityModel.ACC1Value}," +
        "IR2Value  :${ppgActivityModel.IR2Value }," +
        "Red2Value :${ppgActivityModel.Red2Value }," +
        "ACC2Value :${ppgActivityModel.ACC2Value }," +
        "ACCxValue :${ppgActivityModel.ACCxValue }," +
        "ACCyValue :${ppgActivityModel.ACCyValue }," +
        "ACCzValue :${ppgActivityModel.ACCzValue }," +
        "GYRxValue :${ppgActivityModel.GYRxValue }," +
        "GYRyValue :${ppgActivityModel.GYRyValue }," +
        "GYRzValue :${ppgActivityModel.GYRzValue }," +
        "MAGxValue :${ppgActivityModel.MAGxValue }," +
        "MAGyValue :${ppgActivityModel.MAGyValue }," +
        "MAGzValue :${ppgActivityModel.MAGzValue }," +
        "GSR_ECGValue :${ppgActivityModel.GSR_ECGValue }," +
        "battVa :${ppgActivityModel.battVal}," +
        "sensTemp :${ppgActivityModel.sensTemp}," +
        "hrCalc :${ppgActivityModel.hrCalc}," +
        "heartRate :${ppgActivityModel.heartRate}," +
        "\n";


    // debugPrint("dataset $dataSet");
    // debugPrint("================");
    // debugPrint("ppg activity ${ppgActivityModel.toString()} ");
    //bleDataList.add(bleDataModel);
    //print("bleDataList length ${bleDataList.length}");
    //if(bleDataList.length == 15){
    //getListToCsv(bleDataList);
    //print("ble data list length ${bleDataList.length}");
    //}
    return bleDataModel;
  }



  createListBleModel({required List<int> bleDataF0F1,required List<int> bleDataF0D1})async{

    BleDataModel bleDataModel = bleDataCalculation(bleDataF0F1: bleDataF0F1,bleDataF0D1: bleDataF0D1);

    // if(bleDataList.length == 3000){
    //   addInCSVBleData.addAll(bleDataList);
    //   bleDataList.clear();
    //   print("cState false :---- ${cState.isNotifying}");
    //   bleStateSub.pause();
    //   cState.setNotifyValue(false);
    //   print("cState false :---- ${cState.isNotifying}");
    //   getListToCsv(addInCSVBleData);
    //
    //    if(bleStateSub.isPaused){
    //      await Future.delayed(const Duration(seconds: 2));
    //      cState.setNotifyValue(true);
    //      bleStateSub.resume();
    //      print("resume ble");
    //    }
    // }

    bleDataList.add(bleDataModel);
    print("ble data list length ${bleDataList.length}");

    /* bleDataList.add(new BleDataModel(
      timeStamp :bleDataModel.timeStamp,
      IR1Value  :bleDataModel.IR1Value,
      Red1Value : bleDataModel.Red1Value,
      ACC1Value :bleDataModel.ACC1Value,
      IR2Value  :bleDataModel.IR2Value,
      Red2Value :bleDataModel.Red2Value,
      ACC2Value :bleDataModel.ACC2Value,
      ACCxValue :bleDataModel.ACCxValue,
      ACCyValue :bleDataModel.ACCyValue,
      ACCzValue :bleDataModel.ACCzValue,
      GYRxValue :bleDataModel.GYRxValue,
      GYRyValue :bleDataModel.GYRyValue,
      GYRzValue :bleDataModel.GYRzValue,
      MAGxValue :bleDataModel.MAGxValue,
      MAGyValue :bleDataModel.MAGyValue,
      MAGzValue :bleDataModel.MAGzValue,
      GSR_ECGValue :bleDataModel.GSR_ECGValue,
      battVal :bleDataModel.battVal,
      sensTemp :bleDataModel.sensTemp,
      hrCalc :bleDataModel.hrCalc,
      heartRate :bleDataModel.heartRate,
    ));*/

    // print("after ble data list length ${bleDataList.length}");
    //print("ble data list $bleDataList");

    // Future.delayed(Duration(seconds: 5),() {
    //   getListToCsv(addInCSVBleData);
    // });

    //   if(bleDataList.length == 500){
    //     //bleStateSub?.cancel();
    //     print("ble data list delay ${bleDataList.length}");
    //     Future.delayed(Duration(seconds: 5),(){
    //       getListToCsv(bleDataList);
    //     });
    //
    // }

  }

  getListToCsv(List<BleDataModel> bleDataList)async{

    //print("ble getListToCsv ${bleDataList.length}");
    // List<List<dynamic>> rows = List<List<dynamic>>();
    List<List<dynamic>> rows=[];
    ///patient_id,time_stamp,ir1_value,red1_value,acc1_value,ir2_value,red2_value,acc2_value,accx_value,
    ///accy_value,accz_value,gyrx_value,gyry_value,gyrz_value,magx_value,magy_value,magz_value
    ///,gsr_ecg_value,batt_val,sens_temp,hr_calc,heart_rate,value_22,value_23,value_24

    // List<dynamic> row = List();
    List<dynamic> row=[];
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
    rows.insert(0,row);

    print("addPatientModel csv  $addPatientModel");
    for (int i = 0; i < bleDataList.length ;i++) {
      // List<dynamic> row = List();
      List<dynamic> row=[];
      row.add("${addPatientModel.id.toString()}");
      row.add(bleDataList[i].timeStamp);
      row.add(bleDataList[i].IR1Value);
      row.add(bleDataList[i].Red1Value);
      row.add(bleDataList[i].ACC1Value);
      row.add(bleDataList[i].IR2Value );
      row.add(bleDataList[i].Red2Value );
      row.add(bleDataList[i].ACC2Value );
      row.add(bleDataList[i].ACCxValue );
      row.add(bleDataList[i].ACCyValue);
      row.add(bleDataList[i].ACCzValue );
      row.add(bleDataList[i].GYRxValue );
      row.add(bleDataList[i].GYRyValue );
      row.add(bleDataList[i].GYRzValue );
      row.add(bleDataList[i].MAGxValue );
      row.add(bleDataList[i].MAGyValue );
      row.add(bleDataList[i].MAGzValue );
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
    debugPrint("sss csv rows length ${rows.length}");

    await Future.delayed(Duration(minutes: 1),(){
      createCsvFile(rows);
    });
    // if(await Permission.storage.request().isGranted) {
    //   final directory = await getApplicationDocumentsDirectory();
    //   final pathOfTheFileToWrite = directory.path + "/BleSensorData.csv";
    //   File file = File(pathOfTheFileToWrite);
    //
    //    debugPrint("csv rows length ${rows.length}");
    //   String csv = const ListToCsvConverter().convert(rows);
    //   file.writeAsString(csv);
    //   print("write csv data file path ${file.path}");
    //   print("write csv $csv");
    // }




  }

  int csvFileUpdateCounter = 0;
  createCsvFile(List<List<dynamic>> rows) async {
    // Map<Permission, PermissionStatus> statuses = await [
    // Permission.storage,
    // ].request();
    // print(statuses[Permission.storage]);
    // #time$now #count${csvFileUpdateCounter}
    DateTime now = DateTime.now();
    if(await Permission.storage.request().isGranted) {
      final directory = await getApplicationDocumentsDirectory();
      final pathOfTheFileToWrite = directory.path + "/BleSensorData #count$csvFileUpdateCounter.csv";
      csvFile = File(pathOfTheFileToWrite);

      String csv = const ListToCsvConverter().convert(rows);
      csvFile!.writeAsString(csv);
      print("write csv data file path ${csvFile!.path}");
      //print("write csv $csv");
      uploadCsvOnAPI(csvFile!);
    }
  }




  bytesTo8Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      var bytes = data.buffer.asByteData();
      return bytes.getInt8(byteOffset);
    }}
  bytesTo16Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      var bytes = data.buffer.asByteData();
      return bytes.getInt16(byteOffset,Endian.big);
    }}

  bytesTo32Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      var bytes = data.buffer.asByteData();
      return bytes.getInt32(byteOffset,Endian.big);
    }}
  ///https://stackoverflow.com/questions/3345553/how-do-you-convert-3-bytes-into-a-24-bit-number-in-c
  bytesTo24Bit(Uint8List data, int byteOffset)
  {
    if(data!=null && byteOffset!=null){
      Uint8List dataList = Uint8List.fromList([data[byteOffset],data[byteOffset+1],data[byteOffset+2]]);
      // return ReadBuffer.fromUint8List(dataList).uint24;
      ByteData byteData = ByteData.sublistView(dataList);
      return ReadBuffer(byteData);
    }}



  void uploadCsvOnAPI(File filename) async{
    var uri = Uri.parse("$BASE_URL/import-patient-data");
    var request = http.MultipartRequest('POST',uri);
    request.headers["Accept"] = "application/json";
    request.headers["Authorization"] = (await LocalStorageService.getToken())!;
    print("request headers ${request.headers}");

    // var stream = new http.ByteStream(
    //     DelegatingStream.type(filename.openRead()));
    // var length = await filename.length();

    request.files.add(
        await http.MultipartFile.fromPath(
            'csv_file',filename.path
        )
    );
    print("request ${request}");
    var response = await request.send();
    print("response  $response");
    if (response.statusCode == 200) {
      print("Uploaded Success");
      showToast("Success");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).transform(json.decoder).listen((value) {
      ResponseImportCsv? res;
      print("value $value");
      if(response.statusCode == 200 && res!=null){
        res = ResponseImportCsv.fromJson(value as Map<String, dynamic>);
      }
      if(res!.meta!.code == 1){
        csvFileUpdateCounter++;
        print("res.meta.code  ${res.meta!.message}");
        print("csvFileUpdateCounter value $csvFileUpdateCounter");
      }
    });

  }

}

