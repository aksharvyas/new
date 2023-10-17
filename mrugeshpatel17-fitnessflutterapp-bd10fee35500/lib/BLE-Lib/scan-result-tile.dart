
import 'dart:typed_data';

import 'package:fitness_ble_app/BLE-Lib/convert-bytetobit.dart';
import 'package:fitness_ble_app/BLE-Lib/ppg-activity-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, required this.onTap}) : super(key: key);

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
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  //.noSuchMethod(invocation)
                  .apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String? getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String? getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      //leading: Text(result.rssi.toString()),
      trailing: RaisedButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'Complete Local Name', result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(
            context,
            'Manufacturer Data',
            getNiceManufacturerData(
                result.advertisementData.manufacturerData) ??
                'N/A'),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result.advertisementData.serviceData) ?? 'N/A'),
      ],
    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key? key, required  this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase()}',
                style: Theme.of(context)
                    .textTheme
                    .body1!
                    .copyWith(color: Theme.of(context).textTheme.caption!.color,fontSize: 12),)
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: Text('Service'),
        subtitle:
        Text('0x${service.uuid.toString().toUpperCase()}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;
  final VoidCallback onNotificationPressed;

  const CharacteristicTile(
      {Key? key,
        required this.characteristic,
        required this.descriptorTiles,
        required this.onReadPressed,
        required this.onWritePressed,
        required this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        debugPrint("Characteristic tile data");
        debugPrint("Characteristic uuid '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}' Characteristic value :- $value and Characteristic length ${value!.length}");
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.body1!.copyWith(
                        color: Theme.of(context).textTheme.caption!.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
                ),
                onPressed: (){
                  onReadPressed();

                 // readCharacteristicData();

                } ,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;

  const DescriptorTile(
      {Key? key,required this.descriptor,required this.onReadPressed,required this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Descriptor'),
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: Theme.of(context)
                  .textTheme
                  .body1!
                  .copyWith(color: Theme.of(context).textTheme.caption!.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead!.color,
        ),
      ),
    );
  }
}





      readCharacteristicData(){

      List<int> dataF0F0 = [79, 1, 0, 100, 2, 2, 0, 0, 206, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 41]; //24
      List<int> dataF0D0 = [173, 2, 55, 253, 103, 38, 0, 0, 0, 0, 0, 0, 246, 255, 250, 255, 229, 255]; //18
        Uint8List readDataF0F0;
       readDataF0F0 = Uint8List.fromList(dataF0F0);
        ///just for testing
       List sensValue = [...dataF0F0,...dataF0D0];



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
          ppgActivityModel.IR1Value = bytesTo32Bit(readDataF0F0,3);
         // ppgActivityModel.BatterylevelValue  = bytesToInt8(readDataF0F0[0]);
         ppgActivityModel.Red1Value = bytesTo32Bit(readDataF0F0,7);
         //ppgActivityModel.Heartratesensor1Value = bytesToInt8(readDataF0F0[0]);
         ppgActivityModel.ACC1Value = bytesTo16Bit(readDataF0F0,9);
         ppgActivityModel.IR2Value = bytesTo32Bit(readDataF0F0,13);
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

        var timeStamp = DateFormat.Hms().add_s().format(DateTime.now());
        ppgActivityModel.timeStamp = timeStamp;
        /// F0D0
       Uint8List sensValuesF0D0;
       if(dataF0D0!=null){
         sensValuesF0D0 = Uint8List.fromList(dataF0D0);
         print("sensvalue  $sensValuesF0D0");
         if(sensValuesF0D0!=null){
         ppgActivityModel.ACCxValue = (bytesTo16Bit(sensValuesF0D0,1)/1000);
         ppgActivityModel.ACCyValue = (bytesTo16Bit(sensValuesF0D0,3)/1000);
         ppgActivityModel.ACCzValue = (bytesTo16Bit(sensValuesF0D0,5)/1000);
         ppgActivityModel.GYRxValue = (bytesTo16Bit(sensValuesF0D0,7)/10);
         ppgActivityModel.GYRyValue = (bytesTo16Bit(sensValuesF0D0,9)/10);
         ppgActivityModel.GYRzValue = (bytesTo16Bit(sensValuesF0D0,11)/10);
         ppgActivityModel.MAGxValue = (bytesTo16Bit(sensValuesF0D0,13));
         ppgActivityModel.MAGyValue = (bytesTo16Bit(sensValuesF0D0,15));
         ppgActivityModel.MAGzValue = (bytesTo16Bit(sensValuesF0D0,17));
         debugPrint("timeStamp :- $timeStamp,"+ ppgActivityModel.toString());
         }}


        var dataSet;

        dataSet.append(ppgActivityModel.timeStamp).append(",")
            .append(ppgActivityModel.IR1Value).append(",")
            .append( ppgActivityModel.Red1Value).append(",")
            .append(ppgActivityModel.ACC1Value).append(",")
            .append(ppgActivityModel.IR2Value ).append(",")
            .append(ppgActivityModel.Red2Value ).append(",")
            .append(ppgActivityModel.ACC2Value ).append(",")
            .append(ppgActivityModel.ACCxValue ).append(",")
            .append(ppgActivityModel.ACCyValue ).append(",")
            .append(ppgActivityModel.ACCzValue ).append(",")
            .append(ppgActivityModel.GYRxValue ).append(",")
            .append(ppgActivityModel.GYRyValue ).append(",")
            .append(ppgActivityModel.GYRzValue ).append(",")
            .append(ppgActivityModel.MAGxValue ).append(",")
            .append(ppgActivityModel.MAGyValue ).append(",")
            .append(ppgActivityModel.MAGzValue ).append(",")
            .append(ppgActivityModel.GSR_ECGValue ).append(",")
            .append(battVal).append(",")
            .append(sensTemp).append(",")
            .append(hrCalc).append(",")
            .append(heartRate).append(",")
            .append("\n");


        debugPrint("dataset $dataSet");
        debugPrint("================");
        debugPrint("ppg activity ${ppgActivityModel.toString()} ");




}

     bytesTo16Bit(Uint8List data, int byteOffset)
     {
       var bytes = data.buffer.asByteData();
       return bytes.getInt16(byteOffset);
     }

    bytesTo32Bit(Uint8List data, int byteOffset)
    {
      var bytes = data.buffer.asByteData();
      return bytes.getInt32(byteOffset);
    }


     sensorSetting(List<int> data){
       List<int>? readData = [];
       if(data!=null){
         readData = data;
       }
       /// F0D0
       /// //List F0F0 = [];
       PpgActivityModel ppgActivityModel = PpgActivityModel();

       // ppgActivityModel.IR1Value(bytesToInt16());
       Uint8List sensValuesF0D0;
       if(data!=null){
         sensValuesF0D0 = Uint8List.fromList(data);
         print("sensvalue  $sensValuesF0D0");
         if(sensValuesF0D0!=null){
           // ppgActivityModel.ACCxValue(bytesToInt16(sensValuesF0D0[1]));
           // ppgActivityModel.ACCyValue(bytesToInt16(sensValuesF0D0[3]));
           // ppgActivityModel.ACCzValue(bytesToInt16(sensValuesF0D0[5]));
           // ppgActivityModel.GYRxValue(bytesToInt16(sensValuesF0D0[7]));
           // ppgActivityModel.GYRyValue(bytesToInt16(sensValuesF0D0[9]));
           // ppgActivityModel.GYRzValue(bytesToInt16(sensValuesF0D0[11]));
           // ppgActivityModel.MAGxValue(bytesToInt16(sensValuesF0D0[13]));
           // ppgActivityModel.MAGzValue(bytesToInt16(sensValuesF0D0[15]));
           debugPrint(ppgActivityModel.toString());
         }}

     }


// sensValues[arrayIdx].set_sens1IrVal(bytesTo32Bit(sensValue, 3));
// sensValues[arrayIdx].set_sens1RedVal(bytesTo32Bit(sensValue, 7));
// sensValues[arrayIdx].set_acc1Value(bytesTo16Bit(sensValue, 9));
// sensValues[arrayIdx].set_sens2IrVal(bytesTo32Bit(sensValue, 13));
// sensValues[arrayIdx].set_sens2RedVal(bytesTo32Bit(sensValue, 17));
// sensValues[arrayIdx].set_acc2Value(bytesTo16Bit(sensValue, 19));
// sensValues[arrayIdx].set_gsrValue(bytesTo16Bit(sensValue, 21));

// Get sensor temperature
// if (sensValue.length >= 25) {
//   sensTemp = ((sensValue[23] * 100) + sensValue[24]) / 100f;
//   sensValue[23] = 0;
//   sensValue[24] = 0;
//   @SuppressLint("DefaultLocale")
//   String sensTemperature = "T: " + String.format("%.2f", sensTemp) + "°C";
//   mDeviceNameView.setText(sensTemperature);
// } else {
//   sensTemp = ((sensValue[22] * 100) + sensValue[23]) / 100f;
//   sensValue[22] = 0;
//   sensValue[23] = 0;
//   @SuppressLint("DefaultLocale")
//   String sensTemperature = "T: " + String.format("%.2f", sensTemp) + "°C";
//   mDeviceNameView.setText(sensTemperature);
// }
//https://stackoverflow.com/questions/3345553/how-do-you-convert-3-bytes-into-a-24-bit-number-in-c
// var data = new byte[] {39, 213, 2, 0};
// int integer = BitConverter.ToInt32(data, 0);