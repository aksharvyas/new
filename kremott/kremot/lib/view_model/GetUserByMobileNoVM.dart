import 'package:flutter/material.dart';
import 'package:kremot/models/GetUserByMobileNoModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class GetUserByMobileNoVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseGetUserByMobileNo> getUserByMobileNoData = ApiResponse.none();

  void _setGetUserByMobileNoResponse(ApiResponse<ResponseGetUserByMobileNo> response) {
    Utils.printMsg("setGetUserByMobileNoResponse :: $response");
    getUserByMobileNoData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseGetUserByMobileNo>> getUserByMobileNo(RequestGetUserByMobileNo requestGetUserByMobileNo) async {
    _setGetUserByMobileNoResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.GET_USER_BY_MOBILE_NO, requestGetUserByMobileNo);

      Utils.printMsg("setGetUserByMobileNoResponse :: RES:-- $response");
      final jsonData = ResponseGetUserByMobileNo.fromJson(response);
      _setGetUserByMobileNoResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setGetUserByMobileNoResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}