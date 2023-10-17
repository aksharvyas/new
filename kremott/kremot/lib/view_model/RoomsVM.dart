import 'package:flutter/material.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../models/RoomsModel.dart';
import '../utils/Utils.dart';

class RoomsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseRooms> roomsData = ApiResponse.none();

  void _setRoomsResponse(ApiResponse<ResponseRooms> response) {
    Utils.printMsg("setRoomsResponse :: $response");
    roomsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseRooms>> getAllRooms(RequestRooms requestRooms) async {
    _setRoomsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.ALL_ROOMS, requestRooms);

      Utils.printMsg("setRoomsResponse :: RES:-- $response");
      final jsonData = ResponseRooms.fromJson(response);
      _setRoomsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setRoomsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}