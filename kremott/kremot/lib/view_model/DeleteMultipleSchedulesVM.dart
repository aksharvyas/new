import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/DeleteMultipleSchedulesModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class DeleteMultipleSchedulesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDeleteMultipleSchedules> deleteMultipleSchedulesData = ApiResponse.none();

  void _setDeleteMultipleSchedulesResponse(ApiResponse<ResponseDeleteMultipleSchedules> responseDeleteMultipleSchedules) {
    Utils.printMsg("setDeleteMultipleSchedulesResponse :: $responseDeleteMultipleSchedules");
    deleteMultipleSchedulesData = responseDeleteMultipleSchedules;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDeleteMultipleSchedules>> deleteMultipleSchedules(RequestDeleteMultipleSchedules requestDeleteMultipleSchedules) async {
    _setDeleteMultipleSchedulesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DELETE_MULTIPLE_SCHEDULES, requestDeleteMultipleSchedules);

      Utils.printMsg("setDeleteMultipleSchedulesResponse :: RES:-- $response");
      final jsonData = ResponseDeleteMultipleSchedules.fromJson(response);
      _setDeleteMultipleSchedulesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDeleteMultipleSchedulesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}