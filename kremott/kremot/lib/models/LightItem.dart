import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import '../protocol/DeviceSwitchInfo.dart';

class LightItem extends ChangeNotifier {
  late   bool isOn;
  late String _cmacId;



  late int _cmIndex;

  int get cmIndex => _cmIndex;

  set cmIndex(int value) {
    _cmIndex = value;
    notifyListeners();
  }

  late String _name;
  late String _image;
  late bool _isEditable;
  late bool _isSelected;
  late bool _isEnabled;
  late bool _isRenamed;
  late bool _isDragging;
  late bool _isSelectedindicator;
  late bool _isDraggable;
  late int _itemCount;
  late Timer _time;
  late ElementData _element;
  late FocusNode _focusNode;

  bool get isSelectedindicator => _isSelectedindicator;

  set isSelectedindicator(bool value) {
    _isSelectedindicator = value;
  }

  Timer get time => _time;

  set time(Timer value) {
    _time = value;
  }

  ElementData get element => _element;

  set element(ElementData value) {
    _element = value;
  }

  int get itemCount => _itemCount;

  set itemCount(int value) {
    _itemCount = value;
  }

  late int selectedIndex=0;
  late DeviceSwitchInfo _deviceSwitchInfo;
  // late BluetoothDevice _objDevice;
  late String _roomID;

  String get roomID => _roomID;

  set roomID(String value) {
    _roomID = value;
  }
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
  void setDragging(bool isDragging) {
    _isDragging = isDragging;

    notifyListeners();
  }
  bool getIsDraggable() {
    return _isDraggable;
  }

  bool getIsDragging() {
    return _isDragging;
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
  void setEditable(bool isEditable) {
    _isEditable = isEditable;

    notifyListeners();
  }


  FocusNode getFocusNode() {
    return _focusNode;
  }

  bool getEditable() {
    return _isEditable;
  }




  bool getIsRenamed() {
    return _isRenamed;
  }


  LightItem.name(this.selectedIndex);

  LightItem(this._cmIndex,this._cmacId,this._name, this._image,this._isSelected,this._isEditable, this._isEnabled, this._isRenamed,this._deviceSwitchInfo, this._roomID,this._time,this._isSelectedindicator,this._itemCount, this._element,this._focusNode,
      this._isDragging,);
}