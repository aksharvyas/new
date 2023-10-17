import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/AdditionalAdminsModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class AdditionalAdminsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseAdditionalAdmins> additionalAdminsData = ApiResponse.none();

  void _setAdditionalAdminsResponse(ApiResponse<ResponseAdditionalAdmins> response) {
    Utils.printMsg("setAdditionalAdminsResponse :: $response");
    additionalAdminsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseAdditionalAdmins>> getAdditionalAdmins(RequestAdditionalAdmins requestAdditionalAdmins) async {
    _setAdditionalAdminsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.ADDITIONAL_ADMINS, requestAdditionalAdmins);

      Utils.printMsg("setAdditionalAdminsResponse :: RES:-- $response");
      final jsonData = ResponseAdditionalAdmins.fromJson(response);
      _setAdditionalAdminsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setAdditionalAdminsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}