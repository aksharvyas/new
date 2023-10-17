import 'package:flutter/material.dart';
import 'package:kremot/models/RenameRoomModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class RenameRoomVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseRenameRoom> renameRoomData = ApiResponse.none();

  void _setRenameRoomResponse(ApiResponse<ResponseRenameRoom> response) {
    Utils.printMsg("renameRoomResponse :: $response");
    renameRoomData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseRenameRoom>> renameRoom(RequestRenameRoom requestRenameRoom) async {
    _setRenameRoomResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.RENAME_ROOM, requestRenameRoom);

      Utils.printMsg("renameRoomResponse :: RES:-- $response");
      final jsonData = ResponseRenameRoom.fromJson(response);
      _setRenameRoomResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setRenameRoomResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}