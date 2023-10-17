import 'package:flutter/material.dart';
import 'package:kremot/models/DeleteMultipleDevicesModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class DeleteMultipleDevicesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDeleteMultipleDevices> deleteMultipleDevicesData = ApiResponse.none();

  void _setDeleteMultipleDevicesResponse(ApiResponse<ResponseDeleteMultipleDevices> response) {
    Utils.printMsg("deleteMultipleDevicesResponse :: $response");
    deleteMultipleDevicesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDeleteMultipleDevices>> deleteMultipleDevices(RequestDeleteMultipleDevices requestDeleteMultipleDevices) async {
    _setDeleteMultipleDevicesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DELETE_MULTIPLE_DEVICES, requestDeleteMultipleDevices);

      Utils.printMsg("deleteMultipleDevicesResponse :: RES:-- $response");
      final jsonData = ResponseDeleteMultipleDevices.fromJson(response);
      _setDeleteMultipleDevicesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDeleteMultipleDevicesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}