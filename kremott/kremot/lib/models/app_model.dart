
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppModel with ChangeNotifier {




  String mobileNo = "";
  String isoCode = "";
  String emaiId = "";
  String firstName = "";
  String password = "";
  String spo2Lowest = "";
  String spo2Average = "";
  String spo2Highest = "";


  String get _isoCode => isoCode;
  set setisoCode(String value) => notify(() => isoCode = value);
  String get _emaiId => emaiId;
  set setemaiId(String value) => notify(() => emaiId = value);
  String get _firstName => firstName;
  set setfirstName(String value) => notify(() => firstName = value);
  String get _mobileNo => mobileNo;
  set setmobileNo(String value) => notify(() => mobileNo = value);
  String get _password => password;
  set setpassword(String value) => notify(() => password = value);



  // Touch mode, determines density of views





  // Indicates whether a user is logged in or not
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;


  void login() => notify(() => _isLoggedIn = true);
  void logout() {
    notify(() => _isLoggedIn = false);
  }


  // Helper method for single-line state changes
  void notify(VoidCallback stateChange) {
    stateChange.call();
    notifyListeners();
  }
}
