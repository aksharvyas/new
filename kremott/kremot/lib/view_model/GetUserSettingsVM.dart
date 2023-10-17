import 'package:flutter/material.dart';
import 'package:kremot/models/GetUserSettingsModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class GetUserSettingsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseGetUserSettings> getUserSettingsData = ApiResponse.none();

  void _setGetUserSettingsResponse(ApiResponse<ResponseGetUserSettings> response) {
    Utils.printMsg("setGetUserSettingsResponse :: $response");
    getUserSettingsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseGetUserSettings>> getUserSettings(RequestGetUserSettings requestGetUserSettingsModel) async {
    _setGetUserSettingsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.GET_USER_SETTINGS, requestGetUserSettingsModel);

      Utils.printMsg("setGetUserSettingsResponse :: RES:-- $response");
      final jsonData = ResponseGetUserSettings.fromJson(response);
      _setGetUserSettingsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setGetUserSettingsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}