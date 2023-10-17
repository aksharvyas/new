import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/EditSwitchScheduleModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class EditSwitchScheduleVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseEditSwitchSchedule> editSwitchScheduleData = ApiResponse.none();

  void _setEditSwitchScheduleResponse(ApiResponse<ResponseEditSwitchSchedule> responseEditSwitchSchedule) {
    Utils.printMsg("setEditSwitchScheduleResponse :: $responseEditSwitchSchedule");
    editSwitchScheduleData = responseEditSwitchSchedule;
    notifyListeners();
  }

  Future<ApiResponse<ResponseEditSwitchSchedule>> editSwitchSchedule(RequestEditSwitchSchedule requestEditSwitchSchedule) async {
    _setEditSwitchScheduleResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.EDIT_SWITCH_SCHEDULE, requestEditSwitchSchedule);

      Utils.printMsg("setEditSwitchScheduleResponse :: RES:-- $response");
      final jsonData = ResponseEditSwitchSchedule.fromJson(response);
      _setEditSwitchScheduleResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setEditSwitchScheduleResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}