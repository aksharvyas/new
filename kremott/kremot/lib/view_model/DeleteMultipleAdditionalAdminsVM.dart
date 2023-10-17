import 'package:flutter/material.dart';
import 'package:kremot/models/DeleteMultipleAdditionalAdminsModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class DeleteMultipleAdditionalAdminsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDeleteMultipleAdditionalAdmins> deleteMultipleAdditionalAdminsData = ApiResponse.none();

  void _setDeleteMultipleAdditionalAdminsResponse(ApiResponse<ResponseDeleteMultipleAdditionalAdmins> response) {
    Utils.printMsg("deleteMultipleAdditionalAdminsResponse :: $response");
    deleteMultipleAdditionalAdminsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDeleteMultipleAdditionalAdmins>> deleteMultipleAdditionalAdmins(RequestDeleteMultipleAdditionalAdmins requestDeleteMultipleAdditionalAdmins) async {
    _setDeleteMultipleAdditionalAdminsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DELETE_MULTIPLE_ADDITIONAL_ADMINS, requestDeleteMultipleAdditionalAdmins);

      Utils.printMsg("deleteMultipleAdditionalAdminsResponse :: RES:-- $response");
      final jsonData = ResponseDeleteMultipleAdditionalAdmins.fromJson(response);
      _setDeleteMultipleAdditionalAdminsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDeleteMultipleAdditionalAdminsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}