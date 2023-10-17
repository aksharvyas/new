

/// hiiii last funcrtion not calllled


/*

class DeviceScreen extends StatelessWidget {
  DeviceScreen({Key key, this.device,this.addPatientModel}) : super(key: key);
  ListPatientsData addPatientModel;
  BluetoothDevice device;



  @override
  Widget build(BuildContext context) {

    BlocProvider.of<GlobalBloc>(context)
        .patientModelBloc
        .patientModelStream.listen((event) {
      addPatientModel = event;
      debugPrint("addPatientModel ${addPatientModel.toString()}");

    });
    debugPrint("addPatientModel build ${addPatientModel.toString()}");


    return Scaffold(body: Text("hiii"));
    //RecordPage(addPatientModel)
    // return Scaffold(
    //    appBar: AppBar(
    //      title: Text(device.name ?? ""),
    //      actions: <Widget>[
    //        // IconButton(icon: Icon(Icons.clear),
    //        //   onPressed: (){
    //        //     ClearBleRequest();
    //        //   },),
    //        // IconButton(icon: Icon(Icons.ac_unit),
    //        //   onPressed: (){
    //        //    initialize();
    //        //    // discoverServices(device);
    //        //     //discoverServices(device);
    //        //     // readCharacteristicData();
    //        //     // discoverServicesTarget(device);
    //        //    // test1();
    //        //   },),
    //
    //
    //        StreamBuilder<BluetoothDeviceState>(
    //          stream: device.state,
    //          initialData: BluetoothDeviceState.connecting,
    //          builder: (c, snapshot) {
    //            VoidCallback onPressed;
    //            String text;
    //            switch (snapshot.data) {
    //              case BluetoothDeviceState.connected:
    //                onPressed = () => device.disconnect();
    //                text = 'DISCONNECT';
    //                break;
    //              case BluetoothDeviceState.disconnected:
    //                onPressed = () => device.connect();
    //                text = 'CONNECT';
    //                break;
    //              default:
    //                onPressed = null;
    //                text = snapshot.data.toString().substring(21).toUpperCase();
    //                break;
    //            }
    //            return FlatButton(
    //                onPressed: onPressed,
    //                child: Text(
    //                  text,
    //                  style: Theme.of(context)
    //                      .primaryTextTheme
    //                      .button
    //                      .copyWith(color: Colors.white),
    //                ));
    //          },
    //        )
    //      ],
    //    ),
    //    body: SingleChildScrollView(
    //      child: Column(
    //        children: <Widget>[
    //          StreamBuilder<BluetoothDeviceState>(
    //            stream: device.state,
    //            initialData: BluetoothDeviceState.connecting,
    //            builder: (c, snapshot) => ListTile(
    //              leading: (snapshot.data == BluetoothDeviceState.connected)
    //                  ? Icon(Icons.bluetooth_connected)
    //                  : Icon(Icons.bluetooth_disabled),
    //              title: Text(
    //                  'Device is ${snapshot.data.toString().split('.')[1]}.'),
    //              subtitle: Text('${device.id}'),
    //              trailing: StreamBuilder<bool>(
    //                stream: device.isDiscoveringServices,
    //                initialData: false,
    //                builder: (c, snapshot) => IndexedStack(
    //                  index: snapshot.data ? 1 : 0,
    //                  children: <Widget>[
    //                    IconButton(
    //                      icon: Icon(Icons.refresh),
    //                      onPressed: () => device.discoverServices(),
    //                    ),
    //                    IconButton(
    //                      icon: SizedBox(
    //                        child: CircularProgressIndicator(
    //                          valueColor: AlwaysStoppedAnimation(Colors.grey),
    //                        ),
    //                        width: 18.0,
    //                        height: 18.0,
    //                      ),
    //                      onPressed: null,
    //                    )
    //                  ],
    //                ),
    //              ),
    //            ),
    //          ),
    //         SizedBox(height: 50,),
    //          RaisedButton(onPressed: (){
    //
    //            initialize();
    //
    //          }, child: Text("Start notifications  step 1"),),
    //
    //          SizedBox(height: 50,),
    //
    //          RaisedButton(onPressed: (){
    //            ClearBleRequest();
    //
    //          }, child: Text("Stop notifications step 2"),),
    //
    //          SizedBox(height: 50,),
    //
    //          RaisedButton(onPressed: () async {
    //            getListToCsv(bleDataList);
    //            await Future.delayed(Duration(seconds: 1));
    //            if(csvFile.path != null){
    //            uploadCsvOnAPI(csvFile);
    //          }
    //            }, child: Text("Upload CSV on API step 3"),),
    //
    //
    //
    //          // StreamBuilder<int>(
    //          //     stream: device.mtu,
    //          //     initialData: 0,
    //          //     builder: (c, snapshot) {
    //          //       return ListTile(
    //          //         title: Text('MTU Size'),
    //          //         subtitle: Text('${snapshot.data} bytes'),
    //          //         trailing: IconButton(
    //          //             icon: Icon(Icons.edit),
    //          //             onPressed: () {
    //          //               var deviceMTUSize = 27 + 3;
    //          //               if(deviceMTUSize != null){
    //          //                 device.requestMtu(deviceMTUSize);
    //          //               }
    //          //             }
    //          //         ),
    //          //       );
    //          //     }
    //          // ),
    //          // StreamBuilder<List<BluetoothService>>(
    //          //   stream: device.services,
    //          //   initialData: [],
    //          //   builder: (c, snapshot) {
    //          //     return Column(
    //          //       children: _buildServiceTiles(snapshot.data),
    //          //     );
    //          //   },
    //          // ),
    //          //
    //
    //        ],
    //      ),
    //    ),
    //  );
  }



  disconnectBleDevice(){
    device.disconnect();

    characteristicStreamSubscription.cancel();
    characteristicStreamSubscription = null;
    // bleStateStreamSubscription.cancel();
    // bleStateStreamSubscription = null;
  }

  StreamSubscription characteristicStreamSubscription;
  StreamSubscription bleStateStreamSubscription;
  BluetoothCharacteristic cState;
  List<int> f0f1 = [];
  List<int> f0d1 = [];
  File csvFile;
  BluetoothDeviceState state;
  List<BleDataModel> bleDataList = new List<BleDataModel>();
  List<BleDataModel> addInCSVBleData = new List<BleDataModel>();

  Future<void> initialize(BluetoothDevice device) async {


    // var availableServiceCharacteristicNotifications ={
    //   PPG_SERVICE_CHARACTERISTIC_UUID : "f0f0",
    //   DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d0"
    // };
    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID : "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d1"
    };



    var deviceMTUSize = 27 + 3;

    // bleStateStreamSubscription = device.state.listen((event) {
    //   state = event;
    //   print("bleStateSub $event");
    //   });

    device.requestMtu(deviceMTUSize);
    List<BluetoothService> services;
    // if(state == BluetoothDeviceState.connected){
    services = await device.discoverServices();
    print("services $services");
    // }



    await Future.forEach(services, (BluetoothService service) async{
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
    callAPIListToCsv();
  }

  Timer timerForCsvFile;
  int timerTickCall = 0;
  callAPIListToCsv() {
    timerForCsvFile = Timer.periodic(Duration(minutes:  1), (timer) {
      if(bleDataList != null){
        print("timer = $timer");
        getListToCsv(bleDataList);
        timerTickCall++;
      }
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
    }, );
  }


  ClearBleRequest(){
    //getListToCsv(bleDataList);
    device.disconnect();
    characteristicStreamSubscription.cancel();
    cState.setNotifyValue(false);
  }

  BleDataModel bleDataCalculation({List<int> bleDataF0F1,List<int> bleDataF0D1}){
    //List<int> dataF0F1 = bleDataF0F1; //24
    //List<int> dataF0D1 = bleDataF0D1; //18

    Uint8List F0F1List;
    if(bleDataF0F1!=null) {
      F0F1List = Uint8List.fromList(bleDataF0F1);
    }
    Uint8List F0D1List;

    if(bleDataF0D1!=null) {
      F0D1List = Uint8List.fromList(bleDataF0D1);
    }
    int swRevision = 29;
    bool layoutSetup = false;
    int battVal;
    int hrCalc;
    double swHigh;
    double swLow;
    int heartRate;
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
*/
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
*//*

    }
    sensTemp = ((bytesTo8Bit(F0F1List,22)*100)+bytesTo8Bit(F0F1List,23))/100;

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



  createListBleModel({List<int> bleDataF0F1,List<int> bleDataF0D1})async{

    BleDataModel bleDataModel = bleDataCalculation(bleDataF0F1: bleDataF0F1,bleDataF0D1: bleDataF0D1);
    bleDataList.add(bleDataModel);
    print("ble data list length ${bleDataList.length}");

  }

  getListToCsv(List<BleDataModel> bleDataList)async{

    //print("ble getListToCsv ${bleDataList.length}");
    List<List<dynamic>> rows = List<List<dynamic>>();
    ///patient_id,time_stamp,ir1_value,red1_value,acc1_value,ir2_value,red2_value,acc2_value,accx_value,
    ///accy_value,accz_value,gyrx_value,gyry_value,gyrz_value,magx_value,magy_value,magz_value
    ///,gsr_ecg_value,batt_val,sens_temp,hr_calc,heart_rate,value_22,value_23,value_24

    List<dynamic> row = List();
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
      List<dynamic> row = List();
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

    //  await Future.delayed(Duration(minutes: 1),(){
    createCsvFile(rows);
    //  });
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
      csvFile.writeAsString(csv);
      print("write csv data file path ${csvFile.path}");
      //print("write csv $csv");
      uploadCsvOnAPI(csvFile);
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
      return ReadBuffer.fromUint8List(dataList).uint24;
    }}



  void uploadCsvOnAPI(File filename) async{
    var uri = Uri.parse("$BASE_URL/import-patient-data");
    var request = http.MultipartRequest('POST',uri);
    request.headers["Accept"] = "application/json";
    request.headers["Authorization"] = await LocalStorageService.getToken();
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
      ResponseImportCsv res;
      print("value $value");
      if(response.statusCode == 200 && res!=null){
        res = ResponseImportCsv.fromJson(value);
      }
      if(res.meta.code == 1){
        csvFileUpdateCounter++;
        print("res.meta.code  ${res.meta.message}");
        print("csvFileUpdateCounter value $csvFileUpdateCounter");
      }
    });

  }

}

*/


///dwdhdvg
///
///


/*

class BleDiscoveryServices extends StatelessWidget {
  BuildContext context;
  ListPatientsData addPatientModel;
  BluetoothDevice device;
  BleDiscoveryServices({this.device,this.addPatientModel,this.context});
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

  StreamSubscription characteristicStreamSubscription;
  StreamSubscription stateStreamSubscription;
  BluetoothCharacteristic cState;
  List<int> f0f1 = [];
  List<int> f0d1 = [];
  File csvFile;
  BluetoothDeviceState state;
  List<BleDataModel> bleDataList = new List<BleDataModel>();
  List<BleDataModel> addInCSVBleData = new List<BleDataModel>();

  bool bleConnected(device){
    stateStreamSubscription =  device.state.listen((event) {
      state = event;
    });
    if(state == BluetoothDeviceState.connected){
      stateStreamSubscription.pause();
      return true;
    } else {
      return false;
    }

  }

  Future<void> initializeBLEServices() async {
    BlocProvider.of<GlobalBloc>(context).patientModelBloc.patientModelStream.listen((event) {
      addPatientModel = event;
      debugPrint("addPatientModel initializeBLEServices ${addPatientModel.toString()}");
    });

    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID : "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d1"
    };

    var deviceMTUSize = 27 + 3;

    device.requestMtu(deviceMTUSize);
    List<BluetoothService> services;
    if(state == BluetoothDeviceState.connected){
      services = await device.discoverServices();
      print("services $services");
    }

    await Future.forEach(services, (BluetoothService service) async{
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

    characteristicStreamSubscription.cancel();
    cState.setNotifyValue(false);
    device.disconnect();
  }

  BleDataModel bleDataCalculation({List<int> bleDataF0F1,List<int> bleDataF0D1}){
    //List<int> dataF0F1 = bleDataF0F1; //24
    //List<int> dataF0D1 = bleDataF0D1; //18

    Uint8List F0F1List;
    if(bleDataF0F1!=null) {
      F0F1List = Uint8List.fromList(bleDataF0F1);
    }
    Uint8List F0D1List;

    if(bleDataF0D1!=null) {
      F0D1List = Uint8List.fromList(bleDataF0D1);
    }
    int swRevision = 29;
    bool layoutSetup = false;
    int battVal;
    int hrCalc;
    double swHigh;
    double swLow;
    int heartRate;
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
    sensTemp = ((bytesTo8Bit(F0F1List,22)*100)+bytesTo8Bit(F0F1List,23))/100;

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



  createListBleModel({List<int> bleDataF0F1,List<int> bleDataF0D1})async{
    BleDataModel bleDataModel = bleDataCalculation(bleDataF0F1: bleDataF0F1,bleDataF0D1: bleDataF0D1);
    bleDataList.add(bleDataModel);
    print("ble data list length ${bleDataList.length}");
    callAPIListToCsv();
  }
  Timer timerForCsvFile;
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
    List<List<dynamic>> rows = List<List<dynamic>>();
    ///patient_id,time_stamp,ir1_value,red1_value,acc1_value,ir2_value,red2_value,acc2_value,accx_value,
    ///accy_value,accz_value,gyrx_value,gyry_value,gyrz_value,magx_value,magy_value,magz_value
    ///,gsr_ecg_value,batt_val,sens_temp,hr_calc,heart_rate,value_22,value_23,value_24
    List<dynamic> row = List();
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
      List<dynamic> row = List();
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
      csvFile.writeAsString(csv);
      print("write csv data file path ${csvFile.path}");

      uploadCsvOnAPI(csvFile);
    }
  }


  void uploadCsvOnAPI(File filename) async{
    var uri = Uri.parse("$BASE_URL/import-patient-data");
    var request = http.MultipartRequest('POST',uri);
    request.headers["Accept"] = "application/json";
    request.headers["Authorization"] = await LocalStorageService.getToken();
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
      ResponseImportCsv res;
      print("value $value");
      if(response.statusCode == 200 && res!=null){
        res = ResponseImportCsv.fromJson(value);
      }
      if(res.meta.code == 1){
        csvFileList.add(csvFile);
        csvFileUpdateCounter++;
        // if(csvFile.exists() == true){
        //   csvFile.delete();
        // }
        print("res.meta.code  ${res.meta.message}");
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
      return ReadBuffer.fromUint8List(dataList).uint24;
    }}




}


*/
