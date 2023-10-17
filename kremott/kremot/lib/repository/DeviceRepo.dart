

import 'package:kremot/data/remote/network/NetworkApiService.dart';
import 'package:kremot/models/SwitchModel.dart';
import 'package:kremot/models/deviceModel.dart';

import '../data/remote/network/BaseApiService.dart';

class DeviceRepo {

  final BaseApiService _apiService = NetworkApiService();


  Future<ResponseDeviceSwitch?> getDeviceSwitch() async {
    try {
      dynamic response = await _apiService.getResponseWithoutToken(
          "DeviceSwitches/listdeviceswitches?ApplicationId=abc");
      final jsonData = ResponseDeviceSwitch.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseListSwitch?> getAllSwitchType() async {
    try {
      dynamic response = await _apiService.getResponseWithoutToken(
          "Switch/listswitch?ApplicationId=abc");
      final jsonData = ResponseListSwitch.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}