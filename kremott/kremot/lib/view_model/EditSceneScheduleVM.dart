import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../models/EditSceneScheduleModel.dart';
import '../utils/Utils.dart';

class EditSceneScheduleVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseEditSceneSchedule> editSceneScheduleData = ApiResponse.none();

  void _setEditSceneScheduleResponse(ApiResponse<ResponseEditSceneSchedule> responseEditSceneSchedule) {
    Utils.printMsg("setEditSceneScheduleResponse :: $responseEditSceneSchedule");
    editSceneScheduleData = responseEditSceneSchedule;
    notifyListeners();
  }

  Future<ApiResponse<ResponseEditSceneSchedule>> editSceneSchedule(RequestEditSceneSchedule requestEditSceneSchedule) async {
    _setEditSceneScheduleResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.EDIT_SCENE_SCHEDULE, requestEditSceneSchedule);

      Utils.printMsg("setEditSceneScheduleResponse :: RES:-- $response");
      final jsonData = ResponseEditSceneSchedule.fromJson(response);
      _setEditSceneScheduleResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setEditSceneScheduleResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}