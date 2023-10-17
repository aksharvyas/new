import 'dart:convert';

import 'dart:io';
import 'package:csv/csv.dart';
import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';
import 'package:fitness_ble_app/src/app/screen/model/login_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/login_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/patient_list_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/screen/pages/ble_listing_page.dart';
import 'app/screen/pages/rest_datepicker_page.dart';

class FitnessApp extends StatefulWidget {
  @override
  _FitnessAppState createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  LoginUserData? loginUser;

  Future<void> getUser() async {
    loginUser = (await LocalStorageService.getUser());
    print("It's login user $loginUser");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
  }



  @override
  Widget build(BuildContext context) {
    //return FitnessBLEApp();
    // return loginUser!=null ? PatientListPage() : LoginPage();
    //return AddPatientPage();
    //return GoogleMapPage();
    //return RestDatePickerPage();

    return FutureBuilder(
      future: getFutureData(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        debugPrint("Future snapshot ${snapshot.hasData}   ${snapshot.data}");
        return loginUser == null ? LoginPage() : PatientListPage();
        //snapshot.data;
      },
    );
  }

  late Widget rootWidget;
  Future<Widget> getFutureData() async {
    var name = await LocalStorageService.getLastScreen();
    print("fuu  $name");
    if (name == '/PatientListPage') {
      rootWidget = PatientListPage();
    } else if (name == '/LoginPage') {
      rootWidget = LoginPage();
    } else if (name == null) {
      rootWidget = LoginPage();
    }
    return rootWidget;
  }
}
