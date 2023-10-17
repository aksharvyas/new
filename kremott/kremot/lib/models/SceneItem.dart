import 'dart:async';

import 'package:flutter/cupertino.dart';

class SceneItem extends ChangeNotifier {
  late String _name;
  late String _image;
  late String _command;
  late Timer _time;
  late int _itemCount;
  int get itemCount => _itemCount;

  set itemCount(int value) {
    _itemCount = value;
  }

  String get command => _command;

  set command(String value) {
    _command = value;
  }

  late String _commandOn;
  late String _commandSave;
  late bool _isSelected;
  Timer get time => _time;

  set time(Timer value) {
    _time = value;
  }

  void setSelectd(bool isSelected) {
    _isSelected = isSelected;

    notifyListeners();
  }

  bool getSelected() {
    return _isSelected;
  }


  String get commandSave => _commandSave;

  set commandSave(String value) {
    _commandSave = value;
  }

  late int selectedIndex; // to know active index


  String getName() {
    return _name;
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

  SceneItem(this.selectedIndex,this._name, this._image,this._command,this._commandOn,this._commandSave,this._time,this._isSelected,this._itemCount);

  SceneItem.name(this._name);

  String get commandOn => _commandOn;

  set commandOn(String value) {
    _commandOn = value;
  }
}