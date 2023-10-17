import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/PlacesModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class PlacesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponsePlaces> placesData = ApiResponse.none();

  void _setPlacesResponse(ApiResponse<ResponsePlaces> response) {
    Utils.printMsg("setPlacesResponse :: $response");
    placesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponsePlaces>> getAllPlaces(RequestPlaces requestPlaces) async {
    _setPlacesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.ALL_PLACES, requestPlaces);

      Utils.printMsg("setPlacesResponse :: RES:-- $response");
      final jsonData = ResponsePlaces.fromJson(response);
      _setPlacesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setPlacesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}