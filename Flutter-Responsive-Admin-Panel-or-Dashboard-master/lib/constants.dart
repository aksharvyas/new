import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;
const defaultLowPadding = 13.0;
const divider = Divider();
Widget get height => const SizedBox(height: 10);

class ApiConstant {
  static String baseUrl = "http://122.169.109.79:9110/api/";
  static String userEndpoints = "Switch/listswitch?ApplicationId=abc";
  static String deviceSwitch="DeviceSwitches/listdeviceswitches?ApplicationId=abc";
  static String addSwitch="Switch/addswitch";
  static String updateSwitch="Switch/updateswitch";
  static String deleteSwitch="Switch/deleteswitch";
}
