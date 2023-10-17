import 'package:flutter/material.dart';
import 'package:kremot/models/DeleteRoomModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class DeleteRoomVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDeleteRoom> deleteRoomData = ApiResponse.none();

  void _setDeleteRoomResponse(ApiResponse<ResponseDeleteRoom> response) {
    Utils.printMsg("deleteRoomResponse :: $response");
    deleteRoomData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDeleteRoom>> deleteRoom(RequestDeleteRoom requestDeleteRoom) async {
    _setDeleteRoomResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DELETE_ROOM, requestDeleteRoom);

      Utils.printMsg("deleteRoomResponse :: RES:-- $response");
      final jsonData = ResponseDeleteRoom.fromJson(response);
      _setDeleteRoomResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDeleteRoomResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}