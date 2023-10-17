import 'package:flutter/material.dart';
import 'package:kremot/models/ShareMultipleAdditionalAdminsModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class ShareMultipleAdditionalAdminsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseShareMultipleAdditionalAdmins> shareMultipleAdditionalAdminsData = ApiResponse.none();

  void _setShareMultipleAdditionalAdminsResponse(ApiResponse<ResponseShareMultipleAdditionalAdmins> response) {
    Utils.printMsg("shareMultipleAdditionalAdminsResponse :: $response");
    shareMultipleAdditionalAdminsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseShareMultipleAdditionalAdmins>> shareMultipleAdditionalAdmins(RequestShareMultipleAdditionalAdmins requestShareMultipleAdditionalAdmins) async {
    _setShareMultipleAdditionalAdminsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.SHARE_MULTIPLE_ADDITIONAL_ADMINS, requestShareMultipleAdditionalAdmins);

      Utils.printMsg("shareMultipleAdditionalAdminsResponse :: RES:-- $response");
      final jsonData = ResponseShareMultipleAdditionalAdmins.fromJson(response);
      _setShareMultipleAdditionalAdminsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setShareMultipleAdditionalAdminsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}