
import 'package:flutter/material.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/HomeListModel.dart';
import 'package:kremot/models/HomeModel.dart';
import 'package:kremot/models/deviceModel.dart';
import 'package:kremot/repository/HomeRepo.dart';

import '../models/SwitchModel.dart';
import '../repository/DeviceRepo.dart';

class HomeVM extends ChangeNotifier {
  final _myRepo = HomeRepo();

  final _deviceRepo = DeviceRepo();

  ApiResponse<ResponseHome> homeModel = ApiResponse.loading();

  Future<ResponseHome?> addHome(RequestHome requestHome) async {
    Future<ResponseHome?> response = _myRepo.addHome(requestHome);
    return response;
  }

  Future<ResponseHomeList?> homeList(RequestHomeList requestHomeList) async {
    print(requestHomeList.toJson().toString());
    Future<ResponseHomeList?> response = _myRepo.homeList(requestHomeList);
    return response;

  }

  Future<ResponseDeviceSwitch?> deviceList() async {
    Future<ResponseDeviceSwitch?> response = _deviceRepo.getDeviceSwitch();
    return response;
  }

  Future<ResponseListSwitch?> switchListAllType() async {
    Future<ResponseListSwitch?> response = _deviceRepo.getAllSwitchType();
    return response;
  }
}