import 'package:flutter/material.dart';
import 'package:kremot/models/DeletePlaceModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../utils/Utils.dart';

class DeletePlaceVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseDeletePlace> deletePlaceData = ApiResponse.none();

  void _setDeletePlaceResponse(ApiResponse<ResponseDeletePlace> response) {
    Utils.printMsg("deletePlaceResponse :: $response");
    deletePlaceData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseDeletePlace>> deletePlace(RequestDeletePlace requestDeletePlace) async {
    _setDeletePlaceResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.DELETE_HOME, requestDeletePlace);

      Utils.printMsg("deletePlaceResponse :: RES:-- $response");
      final jsonData = ResponseDeletePlace.fromJson(response);
      _setDeletePlaceResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setDeletePlaceResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}