
import 'package:flutter/material.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/HomeModel.dart';
import 'package:kremot/models/RoomListModel.dart';
import 'package:kremot/models/RoomModel.dart';
import 'package:kremot/repository/HomeRepo.dart';
import 'package:kremot/repository/RoomRepo.dart';

class RoomVM extends ChangeNotifier {
  final _myRepo = RoomRepo();
  ApiResponse<ResponseRoom> roomModel = ApiResponse.loading();

  Future<ResponseRoom?> addRoom(RequestRoom requestRoom) async {
    Future<ResponseRoom?> response = _myRepo.addRoom(requestRoom);
    return response;
  }

  Future<ResponseRoomList?> roomList(RequestRoomList requestRoomList) async {
    Future<ResponseRoomList?> response = _myRepo.roomList(requestRoomList);
    return response;
  }
}