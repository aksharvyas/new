import 'package:flutter/material.dart';
import 'package:kremot/models/ShareMultipleRoomsModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class ShareMultipleRoomsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseShareMultipleRooms> shareMultipleRoomsData = ApiResponse.none();

  void _setShareMultipleRoomsResponse(ApiResponse<ResponseShareMultipleRooms> response) {
    Utils.printMsg("shareMultipleRoomsResponse :: $response");
    shareMultipleRoomsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseShareMultipleRooms>> shareMultipleRooms(RequestShareMultipleRooms requestShareMultipleRooms) async {
    _setShareMultipleRoomsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.SHARE_MULTIPLE_ROOMS, requestShareMultipleRooms);

      Utils.printMsg("shareMultipleRoomsResponse :: RES:-- $response");
      final jsonData = ResponseShareMultipleRooms.fromJson(response);
      _setShareMultipleRoomsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setShareMultipleRoomsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}