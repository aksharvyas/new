
import 'dart:typed_data';
import 'package:fitness_ble_app/BLE-Lib/byte_data_convert.dart';

// int bytesToInt16( byteArray, int index) {
//   ByteBuffer buffer = byteArray.buffer;
//   ByteData data = new ByteData.view(buffer);
//   int short = data.getInt16(index, Endian.big);
//   return short;
// }
//
//
// int bytesToInt8( byteArray, int index){
//   ByteBuffer buffer = byteArray.buffer;
//   ByteData data = new ByteData.view(buffer);
//   int short = data.getInt8(index);
//   return short;
//
// }
//
// int bytesToInt32(byteArray, int index){
//   ByteBuffer buffer = Uint8List.view(byteArray).buffer;
//   ByteData data = new ByteData.view(buffer);
//   int short = data.getInt32(index, Endian.big);
//   return short;
// }
Uint8List bytesToInt8(int value) =>
    Uint8List(1)..buffer.asByteData().setUint8(0, value);

// int bytesToInt16(byteArray,int index){
//   ByteBuffer buffer = Uint8List(byteArray).buffer;
//   ByteData data = new ByteData.view(buffer);
//   int short = data.setInt16(index, Endian.big);
//   return short;
// }

Uint8List bytesToInt16(int value) =>
    Uint8List(2)..buffer.asByteData().setUint16(0, value, Endian.big);

// int toInt24(Uint8List byteArray, int index){
//   ByteBuffer buffer = byteArray.buffer;
//   ByteData data = new ByteData.view(buffer);
//   int short = data.getInt(index, Endian.big);
//   return short;
// }


Uint8List bytesToInt32(int value) =>
    Uint8List(4)..buffer.asByteData().setUint32(0, value, Endian.big);

 double extractDouble(final List<int> value) {
var data = new ByteData.view(Uint8List.fromList(value).buffer);
return data.getFloat32(0, Endian.little);
}

// Uint8List bytesToInt24(int value) {
//   ByteData bByteD = data[value++] + (data[value++] << 8) + (data[value++] << 16);
//
//   bByteD.setInt8(0, value,);
//   bByteD.setInt8(0, value,);
//   bByteD.setInt8(0, value,);
//  // return bByteD;
//
//
// }


bytetobit32(Uint8List data, int byteOffset){
 var buffer = new Uint8List(8).buffer;
 var bdata = new ByteData.view(buffer);
 //bdata.setFloat32(byteOffset,);
 int huh = bdata.getInt32(0);
}


/// nnnnnnnnnnnnnnnnnnnnnnnnnnn
///
///
///


// bytesToBit16(List<int> elements,int index){
//  final buffer = Uint16List.fromList(elements).buffer;
//  final byteDataCreator = ByteDataCreator.view(buffer);
// }