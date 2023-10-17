import 'package:flutter/material.dart';
import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../models/DeleteMultipleRoomsModel.dart';
import '../utils/Utils.dart';

class DeleteMultipleRoomsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDeleteMultipleRooms> deleteMultipleRoomsData = ApiResponse.none();

  void _setDeleteMultipleRoomsResponse(ApiResponse<ResponseDeleteMultipleRooms> response) {
    Utils.printMsg("deleteMultipleRoomsResponse :: $response");
    deleteMultipleRoomsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDeleteMultipleRooms>> deleteMultipleRooms(RequestDeleteMultipleRooms requestDeleteMultipleRooms) async {
    _setDeleteMultipleRoomsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DELETE_MULTIPLE_ROOMS, requestDeleteMultipleRooms);

      Utils.printMsg("deleteMultipleRoomsResponse :: RES:-- $response");
      final jsonData = ResponseDeleteMultipleRooms.fromJson(response);
      _setDeleteMultipleRoomsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDeleteMultipleRoomsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}