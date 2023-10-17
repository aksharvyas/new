//
// discoverServices(BluetoothDevice device) async {
//   print("hiii hi");
// //    List<int> f0f0Data = [158, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41];
//   //   List<int> f0d0Data = [185, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255];
//
//   List<int> f0f0Data = [];
//   List<int> f0d0Data = [];
//   print("device $device");
//   // var deviceMTUSize = 27 + 3;
//   // if(deviceMTUSize != null){
//   //   device.requestMtu(deviceMTUSize);
//   // }
//   List<BluetoothService> services = await device.discoverServices();
//
//   // services.forEach((service) async {
//   //   if (service.uuid.toString() == PPG_SERVICE_UUID)
//   //   {
//   //     var characteristics = service.characteristics;
//   //     for(BluetoothCharacteristic c in characteristics)
//   //     {
//   //       if (c.uuid.toString() == PPG_SERVICE_CHARACTERISTIC_UUID)
//   //       {
//   //         BluetoothCharacteristic targetCharacteristic = c;
//   //         StreamSubscription f0f0;
//   //         await Future.delayed(new Duration(seconds: 10),
//   //                 () async {
//   //                   print("f0f0");
//   //                   List<int> value = [];
//   //               await targetCharacteristic.setNotifyValue(true);
//   //                   f0f0 =  targetCharacteristic.value.listen((response) {
//   //                     var decodedResponse = response;
//   //                     print(" f0f0 =  $decodedResponse");
//   //                   });
//   //             });
//   //            f0f0.cancel();
//   //         //
//   //         // if(targetCharacteristic.isNotifying) {
//   //         //   print("f0f0 targetCharacteristic.isNotifying ${targetCharacteristic.isNotifying}");
//   //         //   await targetCharacteristic.setNotifyValue(true);
//   //         //   List<int> value = await targetCharacteristic.read();
//   //         //   print("f0f0 value $value");
//   //         //   //f0f0Data = value;
//   //         // }
//   //         // print("f0f0 targetCharacteristic.isNotifying ${targetCharacteristic.isNotifying}");
//   //         // else{
//   //         //   print("f0f0 targetCharacteristic.isNotifying false ${targetCharacteristic.isNotifying}");
//   //         //   await targetCharacteristic.setNotifyValue(false);
//   //         // }
//   //
//   //         //print("value BLE f0f0Data $f0f0Data");
//   //       }
//   //     };
//   //   }
//   //   if (service.uuid.toString() == DOF_SERVICE_UUID )
//   //   {
//   //     var characteristics =  service.characteristics;
//   //     for(BluetoothCharacteristic c in characteristics)
//   //     {
//   //       if (c.uuid.toString() == DOF_SERVICE_CHARACTERISTIC_UUID)
//   //       {
//   //         BluetoothCharacteristic targetCharacteristic = c;
//   //         List<int> value = [];
//   //         StreamSubscription f0d0;
//   //         await Future.delayed(new Duration(seconds: 10),
//   //                 () async {
//   //               print("f0f0");
//   //               List<int> value = [];
//   //               await targetCharacteristic.setNotifyValue(true);
//   //               f0d0 =  targetCharacteristic.value.listen((response) {
//   //                 var decodedResponse = response;
//   //                 print(" f0f0 =  $decodedResponse");
//   //               });
//   //             });
//   //         f0d0.cancel();
//   //
//   //         print("value BLE $value ,f0d0 value :- $f0d0Data");
//   //       }
//   //     };
//   //   }
//   // });
//
//
//
//   StreamSubscription f0f0Subscription;
//   StreamSubscription f0d0Subscription;
//   services.forEach((service) async {
//     var characteristics = service.characteristics;
//     for(BluetoothCharacteristic c in characteristics)
//     {
//       BluetoothCharacteristic f0f0;
//       BluetoothCharacteristic f0d0;
//       if(c.uuid.toString() == PPG_SERVICE_CHARACTERISTIC_UUID){
//         f0f0 = c;
//       }else if(c.uuid.toString() == DOF_SERVICE_CHARACTERISTIC_UUID){
//         f0d0 = c;
//       }
//       await f0d0.setNotifyValue(true);
//       f0f0Subscription =  f0f0.value.listen((response) {
//         var decodedResponse = response;
//         print(" f0f0 =  $decodedResponse");
//         f0f0Data = decodedResponse;
//       });
//
//
//       // await Future.delayed(new Duration(seconds: 4),
//       //         () async {
//       //       print("in loop");
//       //
//       //     });
//
//       await Future.delayed(new Duration(seconds: 4),
//               () async {
//             print("in loop");
//             await f0d0.setNotifyValue(true);
//             f0d0Subscription = f0d0.value.listen((response) {
//               var decodedResponse = response;
//               print(" f0d0 = $decodedResponse");
//               f0d0Data = decodedResponse;
//             });
//
//           });
//
//
//
//
//     };
//
//   });
//   // f0f0Subscription.cancel();
//   // f0d0Subscription.cancel();
//   debugPrint("f0f0 $f0f0Data and f0d0 $f0d0Data");
//   debugPrint("f0f0 length :- ${f0f0Data.length} and f0d0 length :- ${f0d0Data.length}");
//
//
//
//
//
// }
//
//
//
//
// /// initialize by getting object representations of all the characteristics
// // Future<void> initialize(BluetoothService remoteBluetoothService) async {
// //   this.remoteBluetoothService = remoteBluetoothService;
// //
// //   // get all characteristics
// //   final characteristics = remoteBluetoothService.characteristics;
// //
// //   // map characteristic object to named characteristics
// //   // enabled notifying for those flagged as notifying
// //   await Future.forEach(characteristics, (BluetoothCharacteristic c) async {
// //     final uuidString = c.uuid.toString();
// //     if (availableServiceCharacteristics.containsKey(uuidString)) {
// //       final characteristicName = availableServiceCharacteristics[uuidString];
// //       serviceCharacteristics[characteristicName] = c;
// //       if (availableServiceCharacteristicNotifications[characteristicName]) {
// //         await Future.delayed(PulseOnDataSourceConsts.timeBetweenBleCommands,
// //                 () async {
// //               await c.setNotifyValue(true);
// //             });
// //       }
// //     }
// //   });
// // }
//
//
//
//
// readCharacteristicData(){
//
//   List<int> dataF0F0 = [79, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41]; //24
//   List<int> dataF0D0 = [173, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255]; //18
//   Uint8List readDataF0F0;
//   readDataF0F0 = Uint8List.fromList(dataF0F0);
//   ///just for testing
//   List sensValue = [...dataF0F0,...dataF0D0];
//
//   debugPrint("sensValue $sensValue ");
//
//
//   int swRevision = 29;
//   bool layoutSetup = false;
//   int battVal;
//   int hrCalc;
//   PpgActivityModel ppgActivityModel = PpgActivityModel();
//
//
//
//   double swHigh;
//   double swLow;
//
//   int heartRate;
//   int heartRate2;
//
//   double sensTemp = 0;
//   var sensType = 0x01;
//
//   if(!layoutSetup){
//     /**
//      * The sensor SW version characteristic UUID.
//      * private static final UUID SW_REV_UUID = UUID.fromString("00002a28-0000-1000-8000-00805f9b34fb"); // SW revision
//      */
//     swHigh = swRevision / 100;
//     swLow = swRevision - (swHigh * 100);
//     ///something  sens type code
//     layoutSetup = true;
//   }
//
//   /// Get temperature, battery and heartbeat
//   if (swRevision >= 356) {
//     /// Get battery value
//     battVal = sensValue[3];
//     sensValue[3] = 0;
//     // Update battery icon
//     // onBatteryLevelChanged(battVal);
//     // Get heart rate sensor 1
//     heartRate = sensValue[7];
//     sensValue[7] = 0;
//     if (heartRate < 0) {
//       heartRate += 127;
//     }
//     String heartBeat = "HR:  + $heartRate +   ";
//     if (((sensType & 0x02) == 0x02) || ((sensType & 0x08) == 0x08)) {
//       // Get heart rate sensor 2
//       heartRate2 = sensValue[13];
//       sensValue[13] = 0;
//       if (heartRate2 < 0) {
//         heartRate2 += 127;
//       }
//
//     }
//     // Get sensor temperature
//     sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
//     debugPrint("sensTemp $sensTemp");
//   }else{
//
//     battVal = sensValue[15];
//     sensValue[3] = 0;
//
//     // Update battery icon
//     //onBatteryLevelChanged(battVal);
//
//     if (sensValue.length >= 23) {
//       // Get heart rate
//       heartRate = sensValue[11];
//       sensValue[11] = 0;
//       if (heartRate < 0) {
//         heartRate += 127;
//       }
//       String heartBeat = "HR:  + $heartRate +   ";
//
//       debugPrint("heartBeat $heartBeat");
//     }
//
//     // Get sensor temperature
//     if (sensValue.length >= 25) {
//       sensTemp = ((sensValue[23] * 100) + sensValue[24]) / 100;
//       sensValue[23] = 0;
//       sensValue[24] = 0;
//       String sensTemperature = "T:  $sensTemp °C";
//       debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
//     } else {
//       sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
//       sensValue[22] = 0;
//       sensValue[23] = 0;
//       String sensTemperature = "T: + $sensTemp + °C";
//       debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
//     }
//
//
//   }
//
//
//   if(readDataF0F0!=null){
//     /// "F0F0"
//     ppgActivityModel.IR1Value = bytesTo24Bit(readDataF0F0,3);
//     // ppgActivityModel.BatterylevelValue  = bytesToInt8(readDataF0F0[0]);
//     ppgActivityModel.Red1Value = bytesTo24Bit(readDataF0F0,7);
//     //ppgActivityModel.Heartratesensor1Value = bytesToInt8(readDataF0F0[0]);
//     ppgActivityModel.ACC1Value = bytesTo16Bit(readDataF0F0,9);
//     ppgActivityModel.IR2Value = bytesTo24Bit(readDataF0F0,13);
//     // ppgActivityModel.Heartratesensor2Value  = bytesToInt32(readDataF0F0[0]);
//     ppgActivityModel.Red2Value = bytesTo32Bit(readDataF0F0,17);
//     ppgActivityModel.ACC2Value = bytesTo16Bit(readDataF0F0,19);
//     ppgActivityModel.GSR_ECGValue = bytesTo16Bit(readDataF0F0,21);
//     //8 bit
//     //ppgActivityModel.Temp_fractional_part = bytesToInt8(readDataF0F0[0]);
//     // ppgActivityModel.Temp_integral_part = bytesToInt8(readDataF0F0[0]);
//     /// one left
//     // ppgActivityModel.IR1Value(bytesToInt16());
//   }
//
// //       if (doAlgo) {
// // //					HrmSensorDevice.sendToAlgo(sensValues[arrayIdx].get_sens1IrVal()
// // //							, sensValues[arrayIdx].get_acc1Value()
// // //							, sensValues[arrayIdx].get_sens1RedVal());
// //         if (((sensType & 0x01) == 0x01) || ((sensType & 0x04) == 0x04)) {
// //           HrmSensorDevice.sendToAlgo(sensValues[arrayIdx].get_sens1IrVal()
// //               , sensValues[arrayIdx].get_acc1Value()
// //               , sensValues[arrayIdx].get_sens1RedVal());
// //         } else if (((sensType & 0x02) == 0x02) || ((sensType & 0x08) == 0x08)) {
// //           HrmSensorDevice.sendToAlgo(sensValues[arrayIdx].get_sens2IrVal()
// //               , sensValues[arrayIdx].get_acc2Value()
// //               , sensValues[arrayIdx].get_sens2RedVal());
// //         }
// //       }
//
//   var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
//   ppgActivityModel.timeStamp = timeStamp;
//   /// F0D0
//   Uint8List sensValuesF0D0;
//   if(dataF0D0!=null){
//     sensValuesF0D0 = Uint8List.fromList(dataF0D0);
//     //print("sensvalue  $sensValuesF0D0");
//     if(sensValuesF0D0!=null){
//       ppgActivityModel.ACCxValue = (bytesTo16Bit(sensValuesF0D0,0)/1000);
//       ppgActivityModel.ACCyValue = (bytesTo16Bit(sensValuesF0D0,2)/1000);
//       ppgActivityModel.ACCzValue = (bytesTo16Bit(sensValuesF0D0,4)/1000);
//       ppgActivityModel.GYRxValue = (bytesTo16Bit(sensValuesF0D0,6)/10);
//       ppgActivityModel.GYRyValue = (bytesTo16Bit(sensValuesF0D0,8)/10);
//       ppgActivityModel.GYRzValue = (bytesTo16Bit(sensValuesF0D0,10)/10);
//       ppgActivityModel.MAGxValue = (bytesTo16Bit(sensValuesF0D0,12));
//       ppgActivityModel.MAGyValue = (bytesTo16Bit(sensValuesF0D0,14));
//       ppgActivityModel.MAGzValue = (bytesTo16Bit(sensValuesF0D0,16));
//       debugPrint("timeStamp :- $timeStamp,"+ ppgActivityModel.toString());
//     }}
//
//
//   var dataSet;
//
//
//   // 24bit sensor value #1 (cba) IR1
//   // 8 bit sensor value #10 (d) Battery level
//   // 24bit sensor value #2 (gfe) Red1
//   // 8 bit sensor value #11 (h) Heart rate sensor 1
//   // 16bit sensor value #3 (ji) ACC1
//   // 24bit sensor value #4 (nml) IR2
//   // 8 bit sensor value #12 (o) Heart rate sensor 2
//   // 32bit sensor value #5 (srqp) Red2
//   // 16bit sensor value #6 (ut) ACC2
//   // 16bit sensor value #7 (wv) GSR/ECG
//   // 8 bit sensor value #8 (x) Temp integral part
//   // 8 bit sensor value #9 (y) Temp fractional part
//   //
//   // Sensor value #13 is calculated as ((x*100)+y)/100 and is a floating point number
//   // with the length of the fractional part limit to two digits, e.g. 25.43.
//   // Data from service "F0D0" comes as byte stream like "abcdefghijlmnopqrs"
//   // Data needs to be convert to
//   // 16bit sensor value #14 (ba) ACCx
//   // 16bit sensor value #15 (dc) ACCy
//   // 16bit sensor value #16 (fe) ACCz
//   // 16bit sensor value #17 (hg) GYRx
//   // 16bit sensor value #18 (ji) GYRy
//   // 16bit sensor value #19 (ml) GYRz
//   // 16bit sensor value #20 (on) MAGx
//   // 16bit sensor value #21 (qp) MAGy
//   // 16bit sensor value #22 (sr) MAGz
//
//   dataSet = "${ppgActivityModel.timeStamp}," + ///1
//       "${ppgActivityModel.IR1Value}," + ///2
//       "${ ppgActivityModel.Red1Value}," + ///3
//       "${ppgActivityModel.ACC1Value}," + ///4
//       "${ppgActivityModel.IR2Value }," +///5
//       "${ppgActivityModel.Red2Value }," +///6
//       "${ppgActivityModel.ACC2Value }," +///7
//       "${ppgActivityModel.ACCxValue }," +///8
//       "${ppgActivityModel.ACCyValue }," +///9
//       "${ppgActivityModel.ACCzValue }," +///10
//       "${ppgActivityModel.GYRxValue }," +///11
//       "${ppgActivityModel.GYRyValue }," +///12
//       "${ppgActivityModel.GYRzValue }," +///13
//       "${ppgActivityModel.MAGxValue }," +///14
//       "${ppgActivityModel.MAGyValue }," +///15
//       "${ppgActivityModel.MAGzValue }," +///16
//       "${ppgActivityModel.GSR_ECGValue }," +///17
//       "${battVal}," +///18
//       "${sensTemp}," +///19
//       "${hrCalc}," +///20
//       "${heartRate}," +///21
//       "\n";
//
//
//   debugPrint("dataset $dataSet");
//   debugPrint("================");
//   debugPrint("ppg activity ${ppgActivityModel.toString()} ");
//
//
//
//
// }
//
//
//
//
//
//
// test1(){
//
//   List<int> dataF0F0 = [161, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41]; //24
//   List<int> dataF0D0 = [195, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255]; //18
//   Uint8List readDataF0F0;
//   readDataF0F0 = Uint8List.fromList(dataF0F0);
//   ///just for testing
//   List sensValue = [...dataF0F0,...dataF0D0];
//
//
//   debugPrint("sensValue $sensValue ");
//
//
//   int swRevision = 29;
//   bool layoutSetup = false;
//   int battVal;
//   int hrCalc;
//
//
//
//   double swHigh;
//   double swLow;
//
//   int heartRate;
//   int heartRate2;
//
//   double sensTemp = 0;
//   var sensType = 0x01;
//   var temp;
//   // if(!layoutSetup){
//   //   /**
//   //    * The sensor SW version characteristic UUID.
//   //    * private static final UUID SW_REV_UUID = UUID.fromString("00002a28-0000-1000-8000-00805f9b34fb"); // SW revision
//   //    */
//   //   swHigh = swRevision / 100;
//   //   swLow = swRevision - (swHigh * 100);
//   //   ///something  sens type code
//   //   layoutSetup = true;
//   // }
//   //
//   // /// Get temperature, battery and heartbeat
//   // if (swRevision >= 356) {
//   //   /// Get battery value
//   //   battVal = sensValue[3];
//   //   sensValue[3] = 0;
//   //   // Update battery icon
//   //   // onBatteryLevelChanged(battVal);
//   //   // Get heart rate sensor 1
//   //   heartRate = sensValue[7];
//   //   sensValue[7] = 0;
//   //   if (heartRate < 0) {
//   //     heartRate += 127;
//   //   }
//   //   String heartBeat = "HR:  + $heartRate +   ";
//   //   if (((sensType & 0x02) == 0x02) || ((sensType & 0x08) == 0x08)) {
//   //     // Get heart rate sensor 2
//   //     heartRate2 = sensValue[13];
//   //     sensValue[13] = 0;
//   //     if (heartRate2 < 0) {
//   //       heartRate2 += 127;
//   //     }
//   //
//   //   }
//   //   // Get sensor temperature
//   //   sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
//   //   debugPrint("sensTemp $sensTemp");
//   // }else{
//   //
//   //   battVal = sensValue[15];
//   //   sensValue[3] = 0;
//   //
//   //   // Update battery icon
//   //   //onBatteryLevelChanged(battVal);
//   //
//   //   if (sensValue.length >= 23) {
//   //     // Get heart rate
//   //     heartRate = sensValue[11];
//   //     sensValue[11] = 0;
//   //     if (heartRate < 0) {
//   //       heartRate += 127;
//   //     }
//   //     String heartBeat = "HR:  + $heartRate +   ";
//   //
//   //     debugPrint("heartBeat $heartBeat");
//   //   }
//   //
//   //   // Get sensor temperature
//   //   if (sensValue.length >= 25) {
//   //     sensTemp = ((sensValue[23] * 100) + sensValue[24]) / 100;
//   //     sensValue[23] = 0;
//   //     sensValue[24] = 0;
//   //     String sensTemperature = "T:  $sensTemp °C";
//   //     debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
//   //   } else {
//   //     sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100;
//   //     sensValue[22] = 0;
//   //     sensValue[23] = 0;
//   //     String sensTemperature = "T: + $sensTemp + °C";
//   //     debugPrint("sensTemperature $sensTemperature  sensTemp $sensTemp");
//   //   }
//   //
//   //
//   // }
//   // 012 (cba)
//   //  3(d) Battery level
//   //  456(gfe) Red1
//   //   7 (h) Heart rate sensor 1
//   //   89(ji) ACC1
//   //   10 11 12 (nml) IR2
//   //   13 (o) Heart rate sensor 2
//   //   14 15 16 17 (srqp) Red2
//   //  18 19 (ut) ACC2
//   //  20 21 (wv) GSR/ECG
//   // 22 (x) Temp integral part
//   //  23 (y)
//
//   // 24bit sensor value #1 (cba) IR1
//   // 8 bit sensor value #10 (d) Battery level
//   // 24bit sensor value #2 (gfe) Red1
//   // 8 bit sensor value #11 (h) Heart rate sensor 1
//   // 16bit sensor value #3 (ji) ACC1
//   // 24bit sensor value #4 (nml) IR2
//   // 8 bit sensor value #12 (o) Heart rate sensor 2
//   // 32bit sensor value #5 (srqp) Red2
//   // 16bit sensor value #6 (ut) ACC2
//   // 16bit sensor value #7 (wv) GSR/ECG
//   // 8 bit sensor value #8 (x) Temp integral part
//   // 8 bit sensor value #9 (y) Temp fractional part
//
//   PpgActivityModel ppgActivityModel = PpgActivityModel();
//   if(readDataF0F0!=null){
//     /// "F0F0"
//     ppgActivityModel.IR1Value = bytesTo24Bit(readDataF0F0,0);
//     ppgActivityModel.BatterylevelValue  = bytesTo8Bit(readDataF0F0,3);
//     ppgActivityModel.Red1Value = bytesTo24Bit(readDataF0F0,4);
//     ppgActivityModel.Heartratesensor1Value = bytesTo8Bit(readDataF0F0,7);
//     ppgActivityModel.ACC1Value = bytesTo16Bit(readDataF0F0,8);
//     ppgActivityModel.IR2Value = bytesTo24Bit(readDataF0F0,10);
//     ppgActivityModel.Heartratesensor2Value  = bytesTo8Bit(readDataF0F0,13);
//     ppgActivityModel.Red2Value = bytesTo32Bit(readDataF0F0,14);
//     ppgActivityModel.ACC2Value = bytesTo16Bit(readDataF0F0,18);
//     ppgActivityModel.GSR_ECGValue = bytesTo16Bit(readDataF0F0,20);
//     //8 bit
//     ppgActivityModel.Temp_integral_part = bytesTo8Bit(readDataF0F0,22);
//     ppgActivityModel.Temp_fractional_part = bytesTo8Bit(readDataF0F0,23);
//
//     // / one left
//     // ppgActivityModel.IR1Value(bytesToInt16());
//   }
//   sensTemp = ((ppgActivityModel.Temp_integral_part*100)+ppgActivityModel.Temp_fractional_part)/100;
//
//   var timeStamp = DateFormat("HH:mm:ss:mmm").format(DateTime.now());
//   ppgActivityModel.timeStamp = timeStamp;
//   /// F0D0
//   Uint8List sensValuesF0D0;
//   if(dataF0D0!=null){
//     sensValuesF0D0 = Uint8List.fromList(dataF0D0);
//     //print("sensvalue  $sensValuesF0D0");
//     if(sensValuesF0D0!=null){
//       ppgActivityModel.ACCxValue = (bytesTo16Bit(sensValuesF0D0,0)/1000);
//       ppgActivityModel.ACCyValue = (bytesTo16Bit(sensValuesF0D0,2)/1000);
//       ppgActivityModel.ACCzValue = (bytesTo16Bit(sensValuesF0D0,4)/1000);
//       ppgActivityModel.GYRxValue = (bytesTo16Bit(sensValuesF0D0,6)/10);
//       ppgActivityModel.GYRyValue = (bytesTo16Bit(sensValuesF0D0,8)/10);
//       ppgActivityModel.GYRzValue = (bytesTo16Bit(sensValuesF0D0,10)/10);
//       ppgActivityModel.MAGxValue = (bytesTo16Bit(sensValuesF0D0,12));
//       ppgActivityModel.MAGyValue = (bytesTo16Bit(sensValuesF0D0,14));
//       ppgActivityModel.MAGzValue = (bytesTo16Bit(sensValuesF0D0,16));
//       debugPrint("timeStamp :- $timeStamp,"+ ppgActivityModel.toString());
//     }}
//
//
//   var dataSet;
//
//   dataSet = "timeStamp :${ppgActivityModel.timeStamp}," +
//       "IR1Value :${ppgActivityModel.IR1Value}," +
//       "Red1Value :${ ppgActivityModel.Red1Value}," +
//       "ACC1Value :${ppgActivityModel.ACC1Value}," +
//       "IR2Value :${ppgActivityModel.IR2Value }," +
//       "Red2Value :${ppgActivityModel.Red2Value }," +
//       "ACC2Value :${ppgActivityModel.ACC2Value }," +
//       "ACCxValue :${ppgActivityModel.ACCxValue }," +
//       "ACCyValue :${ppgActivityModel.ACCyValue }," +
//       "ACCzValue :${ppgActivityModel.ACCzValue }," +
//       "GYRxValue :${ppgActivityModel.GYRxValue }," +
//       "GYRyValue :${ppgActivityModel.GYRyValue }," +
//       "GYRzValue :${ppgActivityModel.GYRzValue }," +
//       "MAGxValue :${ppgActivityModel.MAGxValue }," +
//       "MAGyValue :${ppgActivityModel.MAGyValue }," +
//       "MAGzValue :${ppgActivityModel.MAGzValue }," +
//       "GSR_ECGValue :${ppgActivityModel.GSR_ECGValue }," +
//       "battVa :${battVal}," +
//       "sensTemp :${sensTemp}," +
//       "hrCalc :${hrCalc}," +
//       "heartRate :${heartRate}," +
//       "\n";
//
//
//   debugPrint("dataset $dataSet");
//   debugPrint("================");
//   debugPrint("ppg activity ${ppgActivityModel.toString()} ");
//
//
//
//
// }





// get all characteristics
//final characteristics = remoteBluetoothService.characteristics;

// map characteristic object to named characteristics
// enabled notifying for those flagged as notifying
// await Future.forEach(services, (BluetoothService service) async{
//   var characteristics = service.characteristics;
//   await Future.forEach(characteristics, (BluetoothCharacteristic c) async {
//     final uuidString = c.uuid.toString();
//     if (availableServiceCharacteristics.containsKey(uuidString)) {
//       final characteristicName = availableServiceCharacteristics[uuidString];
//       serviceCharacteristics[characteristicName] = c;
//       if (availableServiceCharacteristicNotifications[characteristicName]) {
//         await Future.delayed(new Duration(seconds: 4),
//                 () async {
//               await c.setNotifyValue(true);
//             });
//       }
//     }
//   });
//
// });




// List<BluetoothService> services;
// discoverServicesTarget(BluetoothDevice device)async{
//   List<int> f0f0Data = [];
//   List<int> f0d0Data = [185, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255];
//   device.discoverServices().then((s) async {
//     var services = s;
//
//     for(BluetoothService service in services){
//       for(BluetoothCharacteristic characteristic in service.characteristics){
//         characteristic.setNotifyValue(!characteristic.isNotifying);
//         if (characteristic.uuid == new Guid(PPG_SERVICE_CHARACTERISTIC_UUID)) {
//           f0f0Data = await characteristic.read();
//         }
//         if (characteristic.uuid == new Guid(DOF_SERVICE_CHARACTERISTIC_UUID)) {
//           f0d0Data = await characteristic.read();
//         }
//       }
//     }
//   }
//   );
//   debugPrint("f0f0 $f0f0Data and f0d0 $f0d0Data");
//   debugPrint("f0f0 length :- ${f0f0Data.length} and f0d0 length :- ${f0d0Data.length}");
// }





///17 03 2021 1515
///

/*

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
import 'package:typed_buffer/typed_buffer.dart';
/// 1 find device screen BLE listing screen
///
///
class FitnessBLEApp extends StatelessWidget {

  ListPatientsData addPatientModel;
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
              return BLEListingPage(addPatientModel: addPatientModel,);
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

class BLEListingPage extends StatefulWidget {
  ListPatientsData addPatientModel;
  BLEListingPage({this.addPatientModel});
  @override
  _BLEListingPageState createState() => _BLEListingPageState();
}

class _BLEListingPageState extends State<BLEListingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        flexibleSpace: Container(
          decoration:
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage(appBarPng),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text("Find Device",style: appbarTextStyle,),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 2)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// connected Devices list data
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map((d) => ListTile(
                    title: Text(d.name),
                    subtitle: Text(d.id.toString()),
                    trailing: SizedBox(
                      width:190,
                      child: StreamBuilder<BluetoothDeviceState>(
                        stream: d.state,
                        initialData: BluetoothDeviceState.disconnected,
                        builder: (c, snapshot) {
                          if (snapshot.data == BluetoothDeviceState.connected) {
                            // print("Ble ${d.id}");

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  width:100,
                                  //height: 45,
                                  child: RaisedButton(
                                      child: Text('Disconnect',style: TextStyle(fontSize: 12),),
                                      onPressed: () {
                                        showDisconnect("Are you confirm to disconnect this device ${d.name}",d);
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
                        children: snapshot.data
                            .map((r) =>
                            ScanResultTile(
                                result: r ,
                                onTap: ()  async {
                                  r.device.connect();
                                  //   if(r.device != null){
                                  //     initialize(r.device);
                                  //   }
                                  // await Future.delayed(Duration(seconds: 1));

                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return DeviceScreen(device: r.device, addPatientModel:widget.addPatientModel,);

                                  }));
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
                            .toList()
                    );
                  }
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () async{
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    Permission.location,
                    Permission.locationAlways,
                  ].request();
                  print("$statuses");
                  FlutterBlue.instance
                      .startScan(timeout: Duration(seconds: 4));});
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
              FlatButton(
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
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              FlatButton(
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
}


class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);

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


  checkingConnectedOrNot(BuildContext context,BluetoothDevice deviceBLE){
    final Ble = deviceBLE.state;
    var ev;
    final subscription =  Ble.listen((event) {
      print("ble state $event");
      ev = event;
    });
    if(ev == BluetoothDeviceState.connected) {
      subscription.cancel();
      showCupertinoDialog(context,"${deviceBLE.name} is Connected",deviceBLE);
      print(" subscription.cancel ${subscription.runtimeType} ");
    }else if(ev == BluetoothDeviceState.disconnected){
      subscription.cancel();
      showCupertinoDialog(context,"${deviceBLE.name} is Not Connected");
      print(" subscription.cancel ${subscription.runtimeType} ");
    }
  }

  streamBuilder(BuildContext context,BluetoothDevice deviceBLE){
    StreamBuilder<BluetoothDeviceState>(
        stream: deviceBLE.state,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data == BluetoothDeviceState.connected) {
              showCupertinoDialog(context,"${deviceBLE.name} is Connected",deviceBLE);
            }else if(snapshot.data == BluetoothDeviceState.disconnected){
              showCupertinoDialog(context,"${deviceBLE.name} is Not Connected");
            }}
          return null;
        }
    );
  }

  showCupertinoDialog(BuildContext context,String messages,[BluetoothDevice deviceBLE]) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: new Text(messages),
            //title: new Text("$deviceName is Connected"),
            //content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(
                      builder: (context) =>
                          DashBoardCardPage()));
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
      trailing: RaisedButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
    );
  }
}



class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

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
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}



class DeviceScreen extends StatelessWidget {
  DeviceScreen({Key key, this.device,this.addPatientModel}) : super(key: key);
  ListPatientsData addPatientModel;
  final BluetoothDevice device;


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context)
        .patientModelBloc
        .patientModelStream.listen((event) {
      addPatientModel = event;
    });
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
  List<BleDataModel> bleDataList_copy = new List<BleDataModel>();
  List<BleDataModel> addInCSVBleData = new List<BleDataModel>();

  Future<void> initialize() async {

    var Characteristics = {
      PPG_SERVICE_CHARACTERISTIC_UUID : "f0f1",
      DOF_SERVICE_CHARACTERISTIC_UUID  : "f0d1"
    };

    var deviceMTUSize = 27 + 3;

    // bleStateStreamSubscription = device.state.listen((event) {
    //   state = event;
    //   print("bleStateSub $event");
    // });

    device.requestMtu(deviceMTUSize);
    List<BluetoothService> services;
    // if(state == BluetoothDeviceState.connected){
    services = await device.discoverServices();
    // print("services $services");
    // }



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
    }, );
  }


  ClearBleRequest(){
    //getListToCsv(bleDataList);
    cState.setNotifyValue(false);
    characteristicStreamSubscription.cancel();
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



  createListBleModel({List<int> bleDataF0F1,List<int> bleDataF0D1}){
    BleDataModel bleDataModel = bleDataCalculation(bleDataF0F1: bleDataF0F1,bleDataF0D1: bleDataF0D1);
    bleDataList.add(bleDataModel);

    if(bleDataList.length > 2000) {
      if(bleDataList_copy.length > 2000){
        bleDataList_copy.clear();
      }
      bleDataList_copy.addAll(bleDataList);
      bleDataList.clear();

      getListToCsv(bleDataList_copy);

    }
  }

  getListToCsv(List<BleDataModel> bleDataList){

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
    createCsvFile(rows);
  }

  int csvFileUpdateCounter = 1;
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

    if(await Permission.storage.request().isGranted) {
      List file = [];
      createDirectory().then((value) {
        final pathOfTheFileToWrite = value + "CSVFile #date$now #counter$csvFileUpdateCounter.csv";
        File csvFile = File(pathOfTheFileToWrite);
        String csv = const ListToCsvConverter().convert(rows);
        csvFile.writeAsString(csv);

        file.add(csvFile);
        print("write csv data file path ${csvFile.path} and list file length ${file.length}");
        uploadCsvOnAPI(csvFile);

      });
    }
  }

  Future createDirectory()async{
    final directory = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder = Directory('${directory.path}/CSVData/');
    if(await _appDocDirFolder.exists()){
      //if folder already exists return path
      return _appDocDirFolder.path;
    }else{
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
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
    request.files.add(
        await http.MultipartFile.fromPath(
            'csv_file',filename.path
        )
    );
    print("request ${request.files}");
    var response = await request.send();
    print("response  $response");
    if (response.statusCode == 200) {
      print("Uploaded Success");
      showToast("Successfully upload csv file");
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


///18 03 2021 running csv upload



/*

class DeviceScreen extends StatelessWidget {
  DeviceScreen({Key key, this.device,this.addPatientModel}) : super(key: key);
  ListPatientsData addPatientModel;
  final BluetoothDevice device;


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
  List<BleDataModel> bleDataList_copy = new List<BleDataModel>();
  List<BleDataModel> addInCSVBleData = new List<BleDataModel>();

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

    // bleStateStreamSubscription = device.state.listen((event) {
    //   state = event;
    //   print("bleStateSub $event");
    // });

    device.requestMtu(deviceMTUSize);
    List<BluetoothService> services;
    // if(state == BluetoothDeviceState.connected){
    services = await device.discoverServices();
    // print("services $services");
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



  }


  readCharacteristic(uuidString,cState)async{
    await cState.setNotifyValue(true);
    showToast("wait few second after press step 2");
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
    cState.setNotifyValue(false);
    characteristicStreamSubscription.cancel();
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
    //print("ble data list length ${bleDataList.length}");
    if(bleDataList.length > 5000) {
      if(bleDataList_copy.length > 5000){
        bleDataList_copy.clear();
      }
      bleDataList_copy.addAll(bleDataList);
      bleDataList.clear();

      getListToCsv(bleDataList_copy);

      //bleDataList_copy.clear();
    }



  }

  getListToCsv(List<BleDataModel> bleDataList){

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

    if(await Permission.storage.request().isGranted) {
      createDirectory().then((value) {
        final pathOfTheFileToWrite = value + "/CSVFile #date$now #counter$csvFileUpdateCounter.csv";
        File csvFile = File(pathOfTheFileToWrite);
        String csv = const ListToCsvConverter().convert(rows);
        csvFile.writeAsString(csv).then((fvalue) {
          csvfileList.add(fvalue);
          uploadCsvOnAPI(fvalue);
        });

        print("write csv data file path ${csvFile.path} and list file length");



      });
    }
  }

  Future createDirectory()async{
    final directory = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder =  Directory('${directory.path}/CSVData');

    if(await _appDocDirFolder.exists()){ //if folder already exists return path
      return _appDocDirFolder.path;
    }else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
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

    request.files.add(
        await http.MultipartFile.fromPath(
            'csv_file',filename.path
        )
    );
    print("request ${request}");
    showToast("uploading csv file wait few second");
    var response = await request.send();
    print("response  $response");
    if (response.statusCode == 200) {
      print("Uploaded Success");
      showToast("Successfully upload csv file");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).transform(json.decoder).listen((value) {
      ResponseImportCsv res;
      print("value $value");
      if(response.statusCode == 200 && res!=null){
        res = ResponseImportCsv.fromJson(value);
        if(res?.meta?.code == 1){
          csvFileUpdateCounter++;
          csvfileList.remove(filename);
          filename.delete();
        }
      }
    });

  }

}

*/
