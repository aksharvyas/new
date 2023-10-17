import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../models/RoutinesModel.dart';
import '../utils/Utils.dart';

class RoutinesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseRoutines> routinesData = ApiResponse.none();

  void _setRoutinesResponse(ApiResponse<ResponseRoutines> response) {
    Utils.printMsg("setRoutinesResponse :: $response");
    routinesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseRoutines>> getRoutines(RequestRoutines requestRoutines) async {
    _setRoutinesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.ROUTINES, requestRoutines);

      Utils.printMsg("setRoutinesResponse :: RES:-- $response");
      final jsonData = ResponseRoutines.fromJson(response);
      _setRoutinesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setRoutinesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}