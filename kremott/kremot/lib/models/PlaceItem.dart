import 'package:flutter/material.dart';

class PlaceItem extends ChangeNotifier {
  late String _name;
  late String _image;


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

  PlaceItem(this._name, this._image);
}