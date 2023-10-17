import 'dart:async';

import 'package:flutter/widgets.dart';

class IndicatorItem extends ChangeNotifier {
  late String _name;

  late bool _isSelected;

  late int _itemCount;
  late Timer _time;

  Timer get time => _time;

  set time(Timer value) {
    _time = value;
  }

  int get itemCount => _itemCount;

  set itemCount(int value) {
    _itemCount = value;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;

    notifyListeners();
  }

  void setSelectd(bool isSelected) {
    _isSelected = isSelected;

    notifyListeners();
  }

  bool getSelected() {
    return _isSelected;
  }

  IndicatorItem(this._name, this._isSelected, this._time, this._itemCount);
}
