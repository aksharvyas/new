import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/AddSwitchScheduleModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class AddSwitchScheduleVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseAddSwitchSchedule> addSwitchScheduleData = ApiResponse.none();

  void _setAddSwitchScheduleResponse(ApiResponse<ResponseAddSwitchSchedule> response) {
    Utils.printMsg("setAddSwitchScheduleResponse :: $response");
    addSwitchScheduleData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseAddSwitchSchedule>> addSwitchSchedule(RequestAddSwitchSchedule requestAddSwitchSchedule) async {
    _setAddSwitchScheduleResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.ADD_SWITCH_SCHEDULE, requestAddSwitchSchedule);

      Utils.printMsg("setAddSwitchScheduleResponse :: RES:-- $response");
      final jsonData = ResponseAddSwitchSchedule.fromJson(response);
      _setAddSwitchScheduleResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setAddSwitchScheduleResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}