import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/network/BaseApiService.dart';
import 'package:kremot/data/remote/network/NetworkApiService.dart';
import 'package:kremot/models/RoomListModel.dart';

import '../models/RoomModel.dart';

class RoomRepo {

  final BaseApiService _apiService = NetworkApiService();


  Future<ResponseRoom?> addRoom(RequestRoom requestRoom) async {
    try {
      dynamic response = await _apiService.postResponseWithToken(
          ApiEndPoints().ADD_ROOM, requestRoom);
      final jsonData = ResponseRoom.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseRoomList?> roomList(RequestRoomList requestRoomList) async {
    try {
      dynamic response = await _apiService.postResponseWithToken(
          ApiEndPoints.ACCESSPERMISSIONROOM, requestRoomList);
      final jsonData = ResponseRoomList.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

}