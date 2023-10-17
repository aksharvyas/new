import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kremot/protocol/DeviceSwitchInfo.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';


class FanItem extends ChangeNotifier {
  late String _cmacId;

  late int _cmIndex;

  int get cmIndex => _cmIndex;

  set cmIndex(int value) {
    _cmIndex = value;
    notifyListeners();
  }

  late String _name;
  late String _image;
  late bool _isSelected;
  late bool _isEnabled;
  late bool _isRenamed;
  late int _itemCount;
  late String _roomID;

  late bool _isSelectedindicator;
  late int _itemCountProgress;
  late Timer _time;

  bool get isSelectedindicator => _isSelectedindicator;

  set isSelectedindicator(bool value) {
    _isSelectedindicator = value;
  }

  Timer get time => _time;

  set time(Timer value) {
    _time = value;
  }

  int get itemCountProgress => _itemCountProgress;

  set itemCountProgress(int value) {
    _itemCountProgress = value;
  }

  String get roomID => _roomID;

  set roomID(String value) {
    _roomID = value;
  }

  FixedExtentScrollController _scrollController1 =
  FixedExtentScrollController(initialItem: 1);

  FixedExtentScrollController get scrollController1 => _scrollController1;

  set scrollController1(FixedExtentScrollController value) {
    _scrollController1 = value;
  }

  int get itemCount => _itemCount;

  set itemCount(int value) {
    _itemCount = value;
  }

  late int _selectedIndex;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }

  late ElementData _element;
  ElementData get element => _element;

  set element(ElementData value) {
    _element = value;
  }

  late DeviceSwitchInfo _deviceSwitchInfo;
  // late BluetoothDevice _objDevice;
  //
  // BluetoothDevice get objDevice => _objDevice;
  //
  // set objDevice(BluetoothDevice value) {
  //   _objDevice = value;
  // }

  DeviceSwitchInfo get deviceSwitchInfo => _deviceSwitchInfo;

  set deviceSwitchInfo(DeviceSwitchInfo value) {
    _deviceSwitchInfo = value;
    notifyListeners();
  } // to know active index


  String getName() {
    return _name;
  }
  String get cmacId => _cmacId;

  set cmacId(String value) {
    _cmacId = value;
    notifyListeners();
  }


  void setName(String name) {
    _name = name;

    notifyListeners();
  }

  void toggleSelected(int index) {
    selectedIndex = index;

    notifyListeners(); // To rebuild the Widget
  }

  void setImage(String image) {
    _image = image;

    notifyListeners();
  }

  String getImage() {
    return _image;
  }

  void setSelectd(bool isSelected) {
    _isSelected = isSelected;

    notifyListeners();
  }

  bool getSelected() {
    return _isSelected;
  }

  void setEnabled(bool isEnabled) {
    _isEnabled = isEnabled;

    notifyListeners();
  }

  bool getEnabled() {
    return _isEnabled;
  }

  void setRenamed(bool isRenamed) {
    _isRenamed = isRenamed;

    notifyListeners();
  }


  FanItem.name(this._selectedIndex);

  bool getIsRenamed() {
    return _isRenamed;
  }



  FanItem(this._cmIndex,this._cmacId,this._name, this._image,this._isSelected, this._isEnabled, this._isRenamed,this._deviceSwitchInfo,this._itemCount,this._selectedIndex,this._scrollController1, this._roomID,this._time,this._isSelectedindicator,this._itemCountProgress, this._element);
}