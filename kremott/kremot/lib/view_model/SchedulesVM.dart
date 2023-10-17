import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/SchedulesModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class SchedulesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseSchedules> schedulesData = ApiResponse.none();

  void _setSchedulesResponse(ApiResponse<ResponseSchedules> response) {
    Utils.printMsg("setSchedulesResponse :: $response");
    schedulesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseSchedules>> getSchedules(RequestSchedules requestSchedules) async {
    _setSchedulesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.SCHEDULES, requestSchedules);

      Utils.printMsg("setSchedulesResponse :: RES:-- $response");
      final jsonData = ResponseSchedules.fromJson(response);
      _setSchedulesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setSchedulesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}