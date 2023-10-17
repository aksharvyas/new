import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';

import 'package:fitness_ble_app/BLE-Lib/ppg-activity-model.dart';
import 'package:fitness_ble_app/BLE-Lib/scan-result-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';
 import 'package:typed_buffer/typed_buffer.dart';

import '../main.dart';
import '../BLE-Lib/constants.dart';
class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device,}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    List<int> f0f0Data = [];
    List<int> f0d0Data = [];

    return services
        .map(
          (s) {
            return   ServiceTile(
        service: s,
        characteristicTiles: s.characteristics
            .map(
              (c) {
                //debugPrint("services list inside service number $s and characteristics $c");
                return  CharacteristicTile(
            characteristic: c,
            onReadPressed: () {
                   c.read();
                   debugPrint("characteristics $c and ${c.value}");
                   debugPrint("f0f0 $f0f0Data and f0d0 $f0d0Data");
                   debugPrint("f0f0 length :- ${f0f0Data.length} and f0d0 length :- ${f0d0Data.length}");

            },
            onWritePressed: () async {
              await c.write(_getRandomBytes(), withoutResponse: true);
              await c.read();
            },
            onNotificationPressed: () async {
              await c.setNotifyValue(!c.isNotifying);
             var value =  await c.read();

              if (s.uuid.toString() == PPG_SERVICE_UUID) {
                var characteristics = await s.characteristics;
                for (BluetoothCharacteristic c in characteristics) {
                  if (c.uuid.toString() == PPG_SERVICE_CHARACTERISTIC_UUID) {
                    f0f0Data = value;
                    print(" f0f0Data $f0f0Data");
                  }
                };
              }
              if (s.uuid.toString() == DOF_SERVICE_UUID )
              {
                var characteristics = await s.characteristics;
                for(BluetoothCharacteristic c in characteristics)
                {
                  if (c.uuid.toString() == DOF_SERVICE_CHARACTERISTIC_UUID)
                  {
                    f0d0Data = value;
                    print("f0d0 value :- $f0d0Data");
                  }


            }}
              debugPrint("f0f0 $f0f0Data and f0d0 $f0d0Data");
              debugPrint("f0f0 length :- ${f0f0Data.length} and f0d0 length :- ${f0d0Data.length}");


            },
            descriptorTiles: c.descriptors
                .map(
                  (d) => DescriptorTile(
                descriptor: d,
                onReadPressed: () => d.read(),
                onWritePressed: () => d.write(_getRandomBytes()),
              ),
            )
                .toList(),
          );
                debugPrint("services list $s");
              }
        )
            .toList(),
      );
          }
    )
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit),
            onPressed: (){
              //discoverServices(device);
             // readCharacteristicData();
             // discoverServicesTarget(device);
              test1();
            },),


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
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    // style: Theme.of(context)
                    //     .primaryTextTheme
                    //     .button
                    //     .copyWith(color: Colors.white),
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
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) {
                //Log.logs("Mtu size from device ${snapshot.data} bytes");
                return ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    var deviceMTUSize = 27 + 3;
                    if(deviceMTUSize != null){
                    device.requestMtu(deviceMTUSize);
                  }
                  }
                ),
              );
              }
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


 // List<BluetoothService> services;
  discoverServicesTarget(BluetoothDevice device)async{
    List<int> f0f0Data = [];
    List<int> f0d0Data = [185, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255];
    device.discoverServices().then((s) async {
     var services = s;

     for(BluetoothService service in services){
       for(BluetoothCharacteristic characteristic in service.characteristics){
         characteristic.setNotifyValue(!characteristic.isNotifying);
         if (characteristic.uuid == new Guid(PPG_SERVICE_CHARACTERISTIC_UUID)) {
           f0f0Data = await characteristic.read();
          }
         if (characteristic.uuid == new Guid(DOF_SERVICE_CHARACTERISTIC_UUID)) {
           f0d0Data = await characteristic.read();
         }
       }
     }
    }
    );
    debugPrint("f0f0 $f0f0Data and f0d0 $f0d0Data");
    debugPrint("f0f0 length :- ${f0f0Data.length} and f0d0 length :- ${f0d0Data.length}");
  }
  
  
  



  discoverServices(BluetoothDevice device) async {
    List<int> f0f0Data = [158, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41];
    List<int> f0d0Data = [185, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255];
    // BluetoothCharacteristic readCharacter = new
    // BluetoothCharacteristic();
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) async {
      if (service.uuid.toString() == PPG_SERVICE_UUID)
     {
        var characteristics = await service.characteristics;
        for(BluetoothCharacteristic c in characteristics)
        {
          if (c.uuid.toString() == PPG_SERVICE_CHARACTERISTIC_UUID)
          {
            BluetoothCharacteristic targetCharacteristic = c;
            await targetCharacteristic.setNotifyValue(!targetCharacteristic.isNotifying);

            List<int> value = await c.read();
            value = f0f0Data;
            print("value BLE $value f0f0Data $f0f0Data");
          }
        };
      }
      if (service.uuid.toString() == DOF_SERVICE_UUID )
          {
        var characteristics = await service.characteristics;
        for(BluetoothCharacteristic c in characteristics)
        {
          if (c.uuid.toString() == DOF_SERVICE_CHARACTERISTIC_UUID)
              {
            BluetoothCharacteristic targetCharacteristic = c;
            await targetCharacteristic.setNotifyValue(!c.isNotifying);
            // targetCharacteristic.value.listen((event) {
            //   debugPrint("targetCharacteristic listen value $event");
            // });
            List<int> value = await c.read();
            value = f0d0Data;
            print("value BLE $value ,f0d0 value :- $f0d0Data");
          }
        };
      }
    });

    debugPrint("f0f0 $f0f0Data and f0d0 $f0d0Data");
    debugPrint("f0f0 length :- ${f0f0Data.length} and f0d0 length :- ${f0d0Data.length}");

}



  readCharacteristicData(){

    List<int> dataF0F0 = [79, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41]; //24
    List<int> dataF0D0 = [173, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255]; //18
    Uint8List readDataF0F0;
    readDataF0F0 = Uint8List.fromList(dataF0F0);
    ///just for testing
    List sensValue = [...dataF0F0,...dataF0D0];

    debugPrint("sensValue $sensValue ");


    int swRevision = 29;
    bool layoutSetup = false;
    int battVal;
    int? hrCalc;
    PpgActivityModel ppgActivityModel = PpgActivityModel();



    double swHigh;
    double swLow;

    int? heartRate;
    int heartRate2;

    double sensTemp = 0;
    var sensType = 0x01;

    if(!layoutSetup){
      /**
       * The sensor SW version characteristic UUID.
       * private static final UUID SW_REV_UUID = UUID.fromString("00002a28-0000-1000-8000-00805f9b34fb"); // SW revision
       */
      swHigh = swRevision / 100;
      swLow = swRevision - (swHigh * 100);
      ///something  sens type code
      layoutSetup = true;
    }

    /// Get temperature, battery and heartbeat
    if (swRevision >= 356) {
      /// Get battery value
      battVal = sensValue[3];
      sensValue[3] = 0;
      // Update battery icon
      // onBatteryLevelChanged(battVal);
      // Get heart rate sensor 1
      heartRate = sensValue[7];
      sensValue[7] = 0;
      if (heartRate! < 0) {
        heartRate += 127;
      }
      String heartBeat = "HR:  + $heartRate +   ";
      if (((sensType & 0x02) == 0x02) || ((sensType & 0x08) == 0x08)) {
        // Get heart rate sensor 2
        heartRate2 = sensValue[13];
        sensValue[13] = 0;
        if (heartRate2 < 0) {
          heartRate2 += 127;
        }

      }
      // Get sensor temperature
      sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
      debugPrint("sensTemp $sensTemp");
    }else{

      battVal = sensValue[15];
      sensValue[3] = 0;

      // Update battery icon
      //onBatteryLevelChanged(battVal);

      if (sensValue.length >= 23) {
        // Get heart rate
        heartRate = sensValue[11];
        sensValue[11] = 0;
        if (heartRate! < 0) {
          heartRate += 127;
        }
        String heartBeat = "HR:  + $heartRate +   ";

        debugPrint("heartBeat $heartBeat");
      }

      // Get sensor temperature
      if (sensValue.length >= 25) {
        sensTemp = ((sensValue[23] * 100) + sensValue[24]) / 100;
        sensValue[23] = 0;
        sensValue[24] = 0;
        String sensTemperature = "T:  $sensTemp °C";
        debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
      } else {
        sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
        sensValue[22] = 0;
        sensValue[23] = 0;
        String sensTemperature = "T: + $sensTemp + °C";
        debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
      }


    }


    if(readDataF0F0!=null){
      /// "F0F0"
      ppgActivityModel.IR1Value = bytesTo24Bit(readDataF0F0,3);
      // ppgActivityModel.BatterylevelValue  = bytesToInt8(readDataF0F0[0]);
      ppgActivityModel.Red1Value = bytesTo24Bit(readDataF0F0,7);
      //ppgActivityModel.Heartratesensor1Value = bytesToInt8(readDataF0F0[0]);
      ppgActivityModel.ACC1Value = bytesTo16Bit(readDataF0F0,9);
      ppgActivityModel.IR2Value = bytesTo24Bit(readDataF0F0,13);
      // ppgActivityModel.Heartratesensor2Value  = bytesToInt32(readDataF0F0[0]);
      ppgActivityModel.Red2Value = bytesTo32Bit(readDataF0F0,17);
      ppgActivityModel.ACC2Value = bytesTo16Bit(readDataF0F0,19);
      ppgActivityModel.GSR_ECGValue = bytesTo16Bit(readDataF0F0,21);
      //8 bit
      //ppgActivityModel.Temp_fractional_part = bytesToInt8(readDataF0F0[0]);
      // ppgActivityModel.Temp_integral_part = bytesToInt8(readDataF0F0[0]);
      /// one left
      // ppgActivityModel.IR1Value(bytesToInt16());
    }

//       if (doAlgo) {
// //					HrmSensorDevice.sendToAlgo(sensValues[arrayIdx].get_sens1IrVal()
// //							, sensValues[arrayIdx].get_acc1Value()
// //							, sensValues[arrayIdx].get_sens1RedVal());
//         if (((sensType & 0x01) == 0x01) || ((sensType & 0x04) == 0x04)) {
//           HrmSensorDevice.sendToAlgo(sensValues[arrayIdx].get_sens1IrVal()
//               , sensValues[arrayIdx].get_acc1Value()
//               , sensValues[arrayIdx].get_sens1RedVal());
//         } else if (((sensType & 0x02) == 0x02) || ((sensType & 0x08) == 0x08)) {
//           HrmSensorDevice.sendToAlgo(sensValues[arrayIdx].get_sens2IrVal()
//               , sensValues[arrayIdx].get_acc2Value()
//               , sensValues[arrayIdx].get_sens2RedVal());
//         }
//       }

    var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
    ppgActivityModel.timeStamp = timeStamp;
    /// F0D0
    Uint8List sensValuesF0D0;
    if(dataF0D0!=null){
      sensValuesF0D0 = Uint8List.fromList(dataF0D0);
      //print("sensvalue  $sensValuesF0D0");
      if(sensValuesF0D0!=null){
        ppgActivityModel.ACCxValue = (bytesTo16Bit(sensValuesF0D0,0)/1000);
        ppgActivityModel.ACCyValue = (bytesTo16Bit(sensValuesF0D0,2)/1000);
        ppgActivityModel.ACCzValue = (bytesTo16Bit(sensValuesF0D0,4)/1000);
        ppgActivityModel.GYRxValue = (bytesTo16Bit(sensValuesF0D0,6)/10);
        ppgActivityModel.GYRyValue = (bytesTo16Bit(sensValuesF0D0,8)/10);
        ppgActivityModel.GYRzValue = (bytesTo16Bit(sensValuesF0D0,10)/10);
        ppgActivityModel.MAGxValue = (bytesTo16Bit(sensValuesF0D0,12));
        ppgActivityModel.MAGyValue = (bytesTo16Bit(sensValuesF0D0,14));
        ppgActivityModel.MAGzValue = (bytesTo16Bit(sensValuesF0D0,16));
        debugPrint("timeStamp :- $timeStamp,"+ ppgActivityModel.toString());
      }}


    var dataSet;


    // 24bit sensor value #1 (cba) IR1
    // 8 bit sensor value #10 (d) Battery level
    // 24bit sensor value #2 (gfe) Red1
    // 8 bit sensor value #11 (h) Heart rate sensor 1
    // 16bit sensor value #3 (ji) ACC1
    // 24bit sensor value #4 (nml) IR2
    // 8 bit sensor value #12 (o) Heart rate sensor 2
    // 32bit sensor value #5 (srqp) Red2
    // 16bit sensor value #6 (ut) ACC2
    // 16bit sensor value #7 (wv) GSR/ECG
    // 8 bit sensor value #8 (x) Temp integral part
    // 8 bit sensor value #9 (y) Temp fractional part
    //
    // Sensor value #13 is calculated as ((x*100)+y)/100 and is a floating point number
    // with the length of the fractional part limit to two digits, e.g. 25.43.
    // Data from service "F0D0" comes as byte stream like "abcdefghijlmnopqrs"
    // Data needs to be convert to
    // 16bit sensor value #14 (ba) ACCx
    // 16bit sensor value #15 (dc) ACCy
    // 16bit sensor value #16 (fe) ACCz
    // 16bit sensor value #17 (hg) GYRx
    // 16bit sensor value #18 (ji) GYRy
    // 16bit sensor value #19 (ml) GYRz
    // 16bit sensor value #20 (on) MAGx
    // 16bit sensor value #21 (qp) MAGy
    // 16bit sensor value #22 (sr) MAGz

    dataSet = "${ppgActivityModel.timeStamp}," + ///1
       "${ppgActivityModel.IR1Value}," + ///2
       "${ ppgActivityModel.Red1Value}," + ///3
       "${ppgActivityModel.ACC1Value}," + ///4
       "${ppgActivityModel.IR2Value }," +///5
       "${ppgActivityModel.Red2Value }," +///6
       "${ppgActivityModel.ACC2Value }," +///7
       "${ppgActivityModel.ACCxValue }," +///8
       "${ppgActivityModel.ACCyValue }," +///9
       "${ppgActivityModel.ACCzValue }," +///10
       "${ppgActivityModel.GYRxValue }," +///11
       "${ppgActivityModel.GYRyValue }," +///12
       "${ppgActivityModel.GYRzValue }," +///13
       "${ppgActivityModel.MAGxValue }," +///14
       "${ppgActivityModel.MAGyValue }," +///15
       "${ppgActivityModel.MAGzValue }," +///16
       "${ppgActivityModel.GSR_ECGValue }," +///17
       "${battVal}," +///18
       "${sensTemp}," +///19
       "${hrCalc}," +///20
       "${heartRate}," +///21
       "\n";


    debugPrint("dataset $dataSet");
    debugPrint("================");
    debugPrint("ppg activity ${ppgActivityModel.toString()} ");




  }


  bytesTo8Bit(Uint8List data, int byteOffset)
  {
    print("8 $data");
    var bytes = data.buffer.asByteData();
    print("8 value ${bytes.getInt8(byteOffset)}");
    return bytes.getInt8(byteOffset);
  }
  bytesTo16Bit(Uint8List data, int byteOffset)
  {

    print("16 $data");
    var bytes = data.buffer.asByteData();
    print("16 value ${bytes.getInt16(byteOffset,Endian.big)}");
    return bytes.getInt16(byteOffset,Endian.big);

  }

  bytesTo32Bit(Uint8List data, int byteOffset)
  {
    print("32 $data");
    var bytes = data.buffer.asByteData();
    print("32 value ${bytes.getInt32(byteOffset,Endian.big)}");
    return bytes.getInt32(byteOffset,Endian.big);
  }
///https://stackoverflow.com/questions/3345553/how-do-you-convert-3-bytes-into-a-24-bit-number-in-c
  bytesTo24Bit(Uint8List data, int byteOffset)
  {
    print("24 $data");
    Uint8List dataList = Uint8List.fromList([data[byteOffset],data[byteOffset+1],data[byteOffset+2]]);
    print("24 value ${ReadBuffer.fromUint8List(dataList).uint24}");
    return ReadBuffer.fromUint8List(dataList).uint24;
  }


  test1(){

    List<int> dataF0F0 = [161, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41]; //24
    List<int> dataF0D0 = [195, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255]; //18
    Uint8List readDataF0F0;
    readDataF0F0 = Uint8List.fromList(dataF0F0);
    ///just for testing
    List sensValue = [...dataF0F0,...dataF0D0];


    debugPrint("sensValue $sensValue ");


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
    // if(!layoutSetup){
    //   /**
    //    * The sensor SW version characteristic UUID.
    //    * private static final UUID SW_REV_UUID = UUID.fromString("00002a28-0000-1000-8000-00805f9b34fb"); // SW revision
    //    */
    //   swHigh = swRevision / 100;
    //   swLow = swRevision - (swHigh * 100);
    //   ///something  sens type code
    //   layoutSetup = true;
    // }
    //
    // /// Get temperature, battery and heartbeat
    // if (swRevision >= 356) {
    //   /// Get battery value
    //   battVal = sensValue[3];
    //   sensValue[3] = 0;
    //   // Update battery icon
    //   // onBatteryLevelChanged(battVal);
    //   // Get heart rate sensor 1
    //   heartRate = sensValue[7];
    //   sensValue[7] = 0;
    //   if (heartRate < 0) {
    //     heartRate += 127;
    //   }
    //   String heartBeat = "HR:  + $heartRate +   ";
    //   if (((sensType & 0x02) == 0x02) || ((sensType & 0x08) == 0x08)) {
    //     // Get heart rate sensor 2
    //     heartRate2 = sensValue[13];
    //     sensValue[13] = 0;
    //     if (heartRate2 < 0) {
    //       heartRate2 += 127;
    //     }
    //
    //   }
    //   // Get sensor temperature
    //   sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
    //   debugPrint("sensTemp $sensTemp");
    // }else{
    //
    //   battVal = sensValue[15];
    //   sensValue[3] = 0;
    //
    //   // Update battery icon
    //   //onBatteryLevelChanged(battVal);
    //
    //   if (sensValue.length >= 23) {
    //     // Get heart rate
    //     heartRate = sensValue[11];
    //     sensValue[11] = 0;
    //     if (heartRate < 0) {
    //       heartRate += 127;
    //     }
    //     String heartBeat = "HR:  + $heartRate +   ";
    //
    //     debugPrint("heartBeat $heartBeat");
    //   }
    //
    //   // Get sensor temperature
    //   if (sensValue.length >= 25) {
    //     sensTemp = ((sensValue[23] * 100) + sensValue[24]) / 100;
    //     sensValue[23] = 0;
    //     sensValue[24] = 0;
    //     String sensTemperature = "T:  $sensTemp °C";
    //     debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
    //   } else {
    //     sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
    //     sensValue[22] = 0;
    //     sensValue[23] = 0;
    //     String sensTemperature = "T: + $sensTemp + °C";
    //     debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
    //   }
    //
    //
    // }
   // 012 (cba)
   //  3(d) Battery level
   //  456(gfe) Red1
   //   7 (h) Heart rate sensor 1
   //   89(ji) ACC1
   //   10 11 12 (nml) IR2
   //   13 (o) Heart rate sensor 2
   //   14 15 16 17 (srqp) Red2
   //  18 19 (ut) ACC2
   //  20 21 (wv) GSR/ECG
   // 22 (x) Temp integral part
   //  23 (y)

    // 24bit sensor value #1 (cba) IR1
    // 8 bit sensor value #10 (d) Battery level
    // 24bit sensor value #2 (gfe) Red1
    // 8 bit sensor value #11 (h) Heart rate sensor 1
    // 16bit sensor value #3 (ji) ACC1
    // 24bit sensor value #4 (nml) IR2
    // 8 bit sensor value #12 (o) Heart rate sensor 2
    // 32bit sensor value #5 (srqp) Red2
    // 16bit sensor value #6 (ut) ACC2
    // 16bit sensor value #7 (wv) GSR/ECG
    // 8 bit sensor value #8 (x) Temp integral part
    // 8 bit sensor value #9 (y) Temp fractional part

    PpgActivityModel ppgActivityModel = PpgActivityModel();
    if(readDataF0F0!=null){
      /// "F0F0"
      ppgActivityModel.IR1Value = bytesTo24Bit(readDataF0F0,0);
       ppgActivityModel.BatterylevelValue  = bytesTo8Bit(readDataF0F0,3);
      ppgActivityModel.Red1Value = bytesTo24Bit(readDataF0F0,4);
      ppgActivityModel.Heartratesensor1Value = bytesTo8Bit(readDataF0F0,7);
      ppgActivityModel.ACC1Value = bytesTo16Bit(readDataF0F0,8);
      ppgActivityModel.IR2Value = bytesTo24Bit(readDataF0F0,10);
       ppgActivityModel.Heartratesensor2Value  = bytesTo8Bit(readDataF0F0,13);
      ppgActivityModel.Red2Value = bytesTo32Bit(readDataF0F0,14);
      ppgActivityModel.ACC2Value = bytesTo16Bit(readDataF0F0,18);
      ppgActivityModel.GSR_ECGValue = bytesTo16Bit(readDataF0F0,20);
      //8 bit
      ppgActivityModel.Temp_integral_part = bytesTo8Bit(readDataF0F0,22);
      ppgActivityModel.Temp_fractional_part = bytesTo8Bit(readDataF0F0,23);

     // / one left
      // ppgActivityModel.IR1Value(bytesToInt16());
    }
    sensTemp = ((ppgActivityModel.Temp_integral_part*100)+ppgActivityModel.Temp_fractional_part)/100;

    var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
    ppgActivityModel.timeStamp = timeStamp;
    /// F0D0
    Uint8List sensValuesF0D0;
    if(dataF0D0!=null){
      sensValuesF0D0 = Uint8List.fromList(dataF0D0);
      //print("sensvalue  $sensValuesF0D0");
      if(sensValuesF0D0!=null){
        ppgActivityModel.ACCxValue = (bytesTo16Bit(sensValuesF0D0,0)/1000);
        ppgActivityModel.ACCyValue = (bytesTo16Bit(sensValuesF0D0,2)/1000);
        ppgActivityModel.ACCzValue = (bytesTo16Bit(sensValuesF0D0,4)/1000);
        ppgActivityModel.GYRxValue = (bytesTo16Bit(sensValuesF0D0,6)/10);
        ppgActivityModel.GYRyValue = (bytesTo16Bit(sensValuesF0D0,8)/10);
        ppgActivityModel.GYRzValue = (bytesTo16Bit(sensValuesF0D0,10)/10);
        ppgActivityModel.MAGxValue = (bytesTo16Bit(sensValuesF0D0,12));
        ppgActivityModel.MAGyValue = (bytesTo16Bit(sensValuesF0D0,14));
        ppgActivityModel.MAGzValue = (bytesTo16Bit(sensValuesF0D0,16));
        debugPrint("timeStamp :- $timeStamp,"+ ppgActivityModel.toString());
      }}


    var dataSet;

    dataSet = "timeStamp :${ppgActivityModel.timeStamp}," +
        "IR1Value :${ppgActivityModel.IR1Value}," +
        "Red1Value :${ ppgActivityModel.Red1Value}," +
        "ACC1Value :${ppgActivityModel.ACC1Value}," +
        "IR2Value :${ppgActivityModel.IR2Value }," +
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
        "battVa :${battVal}," +
        "sensTemp :${sensTemp}," +
        "hrCalc :${hrCalc}," +
        "heartRate :${heartRate!}," +
        "\n";


    debugPrint("dataset $dataSet");
    debugPrint("================");
    debugPrint("ppg activity ${ppgActivityModel.toString()} ");




  }

}
