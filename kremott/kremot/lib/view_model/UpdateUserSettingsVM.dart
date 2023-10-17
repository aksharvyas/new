import 'package:flutter/material.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../models/UpdateUserSettingsModel.dart';
import '../utils/Utils.dart';

class UpdateUserSettingsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseUpdateUserSettings> updateUserSettingsData = ApiResponse.none();

  void _setUpdateUserSettingsResponse(ApiResponse<ResponseUpdateUserSettings> response) {
    Utils.printMsg("setUpdateUserSettingsResponse :: $response");
    updateUserSettingsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseUpdateUserSettings>> updateUserSettings(RequestUpdateUserSettings requestUpdateUserSettingsModel) async {
    _setUpdateUserSettingsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.UPDATE_USER_SETTINGS, requestUpdateUserSettingsModel);

      Utils.printMsg("setUpdateUserSettingsResponse :: RES:-- $response");
      final jsonData = ResponseUpdateUserSettings.fromJson(response);
      _setUpdateUserSettingsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setUpdateUserSettingsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}