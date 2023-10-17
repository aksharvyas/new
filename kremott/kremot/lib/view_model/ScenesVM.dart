import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/ScenesModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class ScenesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseScenes> scenesData = ApiResponse.none();

  void _setScenesResponse(ApiResponse<ResponseScenes> response) {
    Utils.printMsg("setScenesResponse :: $response");
    scenesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseScenes>> getScenes(RequestScenes requestScenes) async {
    _setScenesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.SCENES, requestScenes);

      Utils.printMsg("setScenesResponse :: RES:-- $response");
      final jsonData = ResponseScenes.fromJson(response);
      _setScenesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setScenesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}