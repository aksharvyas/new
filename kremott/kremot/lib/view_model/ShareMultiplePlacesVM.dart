import 'package:flutter/material.dart';
import 'package:kremot/models/ShareMultiplePlacesModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class ShareMultiplePlacesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseShareMultiplePlaces> shareMultiplePlacesData = ApiResponse.none();

  void _setShareMultiplePlacesResponse(ApiResponse<ResponseShareMultiplePlaces> response) {
    Utils.printMsg("shareMultiplePlacesResponse :: $response");
    shareMultiplePlacesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseShareMultiplePlaces>> shareMultiplePlaces(RequestShareMultiplePlaces requestShareMultiplePlaces) async {
    _setShareMultiplePlacesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.SHARE_MULTIPLE_PLACES, requestShareMultiplePlaces);

      Utils.printMsg("shareMultiplePlacesResponse :: RES:-- $response");
      final jsonData = ResponseShareMultiplePlaces.fromJson(response);
      _setShareMultiplePlacesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setShareMultiplePlacesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}