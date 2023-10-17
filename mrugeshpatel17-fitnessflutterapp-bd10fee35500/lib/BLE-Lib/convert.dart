/*
import 'dart:typed_data';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

// references https://github.com/PointyCastle/pointycastle/blob/master/lib/src/utils.dart
BigInt _decodeBigInt(List<int> bytes) {
  BigInt result = new BigInt.from(0);
  for (int i = 0; i < bytes.length; i++) {
    result += new BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
  }
  return result;
}

var _byteMask = new BigInt.from(0xff);

/// Encode a BigInt into bytes using big-endian encoding.
Uint8List _encodeBigInt(BigInt number) {
  // Not handling negative numbers. Decide how you want to do that.
  int size = (number.bitLength + 7) >> 3;
  var result = new Uint8List(size);
  for (int i = 0; i < size; i++) {
    result[size - i - 1] = (number & _byteMask).toInt();
    number = number >> 8;
  }
  return result;
}

var int8Max = 127;
var int8Min = -128;

var int16Max = 32767;
var int16Min = -32768;

var int24Max= 8388607;
var int24Min= -8388608;

var int32Max = 2147483647;
var int32Min = -2147483648;

var int64Max = 9223372036854775807;
var int64Min = -9223372036854775808;

class Convert {
  static Uint8List hexStrToBytes(String str) {
    return Uint8List.fromList(hex.decode(str));
  }

  static String bytesToHexStr(Uint8List bytes) {
    return hex.encode(bytes.toList());
  }

  static BigInt hexStrToBigInt(String str, {bool bigEndian = false}) {
    var bytes = hexStrToBytes(str);
    if (!bigEndian) bytes = Uint8List.fromList(bytes.reversed.toList());
    return _decodeBigInt(bytes.toList());
  }

  static BigInt bytesToBigInt(Uint8List bytes, {bool bigEndian = false}) {
    if (!bigEndian) bytes = Uint8List.fromList(bytes.reversed.toList());
    return BigInt.parse(bytesToHexStr(bytes), radix: 16);
  }

  static Uint8List bigIntToBytes({BigInt v, bool bigEndian = true}) {
    Buffer buf = Buffer();
    if (v >= BigInt.from(int8Min) && v <= BigInt.from(int8Max)) {
      buf.addInt8(v.toInt());
      return buf.bytes;
    }
    if (v >= BigInt.from(int16Min) && v <= BigInt.from(int16Max)) {
      buf.addInt16(v: v.toInt(), bigEndian: bigEndian);
      return buf.bytes;
    }
    if (v >= BigInt.from(int32Min) && v <= BigInt.from(int32Max)) {
      buf.addInt32(v: v.toInt(), bigEndian: bigEndian);
      return buf.bytes;
    }
    if (v >= BigInt.from(int64Min) && v <= BigInt.from(int64Max)) {
      buf.addInt64(v: v.toInt(), bigEndian: bigEndian);
      return buf.bytes;
    }

    assert(
    v >= BigInt.from(0),
    'BigInt whose size is larger then int64 must be a positive number: ' +
        v.toRadixString(10));

    var bytes = _encodeBigInt(v);
    return bigEndian ? bytes : Uint16List.fromList(bytes.reversed.toList());
  }

  static Uint8List base64ToBytes(String b64) {
    return Base64Codec().decode(b64);
  }

  static String bytesToBase64(Uint8List bytes) {
    return Base64Encoder().convert(bytes.toList());
  }

  static Uint8List strToBytes(String str) {
    return Uint8List.fromList(Utf8Encoder().convert(str));
  }

  static String bytesToStr(Uint8List bytes) {
    return Utf8Decoder().convert(bytes.toList());
  }

  static String hexStrToStr(String hex) {
    var bytes = hexStrToBytes(hex);
    return bytesToStr(bytes);
  }
}


class Buffer {
  Uint8List _buf;
  int _writePos = 0;
  ByteData _view;

  Uint8List get bytes {
    return _buf.sublist(0, _writePos);
  }

  _init(size) {
    _buf = Uint8List(size);
    _view = ByteData.view(_buf.buffer);
  }

  Buffer({int size = 32}) {
    _init(32);
  }

  Buffer.fromBytes(Uint8List bytes) {
    _init(32);
    bytes.forEach((b) => addUint8(b));
  }

  Buffer.fromHexStr(String str) {
    _init(32);
    Convert.hexStrToBytes(str).forEach((b) => addUint8(b));
  }

  grow() {
    if (_writePos == _buf.length - 1) {
      var newBuf = Uint8List(_buf.length * 2);
      _buf.asMap().forEach((k, v) => newBuf[k] = v);
      _buf = newBuf;
      _view = ByteData.view(_buf.buffer);
    }
  }

  addUint8(int v) {
    grow();
    _view.setUint8(_writePos, v);
    _writePos += 1;
  }

  addUint16({int v, bool bigEndian = true}) {
    grow();
    _view.setUint16(_writePos, v, bigEndian ? Endian.big : Endian.little);
    _writePos += 2;
  }

  addUint32({int v, bool bigEndian = true}) {
    grow();
    _view.setUint32(_writePos, v, bigEndian ? Endian.big : Endian.little);
    _writePos += 4;
  }

  addUint64({int v, bool bigEndian = true}) {
    grow();
    _view.setUint64(_writePos, v, bigEndian ? Endian.big : Endian.little);
    _writePos += 8;
  }

  addInt8(int v) {
    grow();
    _view.setInt8(_writePos, v);
    _writePos += 1;
  }

  addInt16({int v, bool bigEndian = true}) {
    grow();
    _view.setInt16(_writePos, v, bigEndian ? Endian.big : Endian.little);
    _writePos += 2;
  }

  addInt32({int v, bool bigEndian = true}) {
    grow();
    _view.setInt32(_writePos, v, bigEndian ? Endian.big : Endian.little);
    _writePos += 4;
  }

  addInt64({int v, bool bigEndian = true}) {
    grow();
    _view.setInt64(_writePos, v, bigEndian ? Endian.big : Endian.little);
    _writePos += 8;
  }

  appendBytes(Uint8List bytes) {
    bytes.forEach((b) => addUint8(b));
  }

  int readUint8(int ofst) {
    return _view.getUint8(ofst);
  }

  int readUint16({int ofst, bool bigEndian = true}) {
    return _view.getUint16(ofst, bigEndian ? Endian.big : Endian.little);
  }

  int readUint32({int ofst, bool bigEndian = true}) {
    return _view.getUint32(ofst, bigEndian ? Endian.big : Endian.little);
  }

  int readUint64({int ofst, bool bigEndian = true}) {
    return _view.getUint64(ofst, bigEndian ? Endian.big : Endian.little);
  }

  String get utf8string {
    if (_writePos == 0) return null;
    return Utf8Decoder().convert(_buf.sublist(0, _writePos));
  }

  // static Future<Buffer> random(int count) async {
  //   //var bytes = await invokeCommon('buffer.random', [count]);
  //   return Buffer.fromBytes(bytes);
  // }
}

class BufferReader {
  Buffer buf;
  int ofst;

  BufferReader(Buffer buf, {int ofst = 0})
      : buf = buf,
        ofst = ofst;

  BufferReader.fromBytes({@required Uint8List bytes, int ofst = 0})
      : buf = Buffer.fromBytes(bytes),
        ofst = ofst;

  int readUint8() {
    int v = buf.readUint8(ofst);
    ofst += 1;
    return v;
  }

  int readUint16LE() {
    int v = buf.readUint16(ofst: ofst, bigEndian: false);
    ofst += 2;
    return v;
  }

  int readUint32LE() {
    int v = buf.readUint32(ofst: ofst, bigEndian: false);
    ofst += 4;
    return v;
  }

  int readUint64LE() {
    int v = buf.readUint64(ofst: ofst, bigEndian: false);
    ofst += 8;
    return v;
  }

  Uint8List forward(int cnt) {
    Uint8List sub = buf._buf.sublist(ofst, ofst + cnt);
    ofst += cnt;
    return sub;
  }

  advance(int cnt) {
    ofst += cnt;
  }

  BufferReader branch(int ofst) {
    return BufferReader(buf, ofst: ofst);
  }

  bool get isEnd {
    assert(ofst <= buf._buf.lengthInBytes);
    return ofst == buf._buf.lengthInBytes;
  }
}*/
