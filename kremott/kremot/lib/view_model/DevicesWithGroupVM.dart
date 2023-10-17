import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/DevicesWithGroupModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class DevicesWithGroupVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDevicesWithGroup> devicesWithGroupData = ApiResponse.none();

  void _setDevicesWithGroupResponse(ApiResponse<ResponseDevicesWithGroup> response) {
    Utils.printMsg("setDevicesWithGroupResponse :: $response");
    devicesWithGroupData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDevicesWithGroup>> getDevicesWithGroup(RequestDevicesWithGroup requestDevicesWithGroup) async {
    _setDevicesWithGroupResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DEVICES_WITH_GROUP, requestDevicesWithGroup);

      Utils.printMsg("setDevicesWithGroupResponse :: RES:-- $response");
      final jsonData = ResponseDevicesWithGroup.fromJson(response);
      _setDevicesWithGroupResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDevicesWithGroupResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}