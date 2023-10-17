import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/AddSceneScheduleModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class AddSceneScheduleVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseAddSceneSchedule> addSceneScheduleData = ApiResponse.none();

  void _setAddSceneScheduleResponse(ApiResponse<ResponseAddSceneSchedule> response) {
    Utils.printMsg("setAddSceneScheduleResponse :: $response");
    addSceneScheduleData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseAddSceneSchedule>> addSceneSchedule(RequestAddSceneSchedule requestAddSceneSchedule) async {
    _setAddSceneScheduleResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.ADD_SCENE_SCHEDULE, requestAddSceneSchedule);

      Utils.printMsg("setAddSceneScheduleResponse :: RES:-- $response");
      final jsonData = ResponseAddSceneSchedule.fromJson(response);
      _setAddSceneScheduleResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setAddSceneScheduleResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}