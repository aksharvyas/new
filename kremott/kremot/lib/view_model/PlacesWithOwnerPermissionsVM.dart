import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class PlacesWithOwnerPermissionsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponsePlacesWithOwnerPermissions> placesWithOwnerPermissionsData = ApiResponse.none();

  void _setPlacesWithOwnerPermissionsResponse(ApiResponse<ResponsePlacesWithOwnerPermissions> response) {
    Utils.printMsg("setPlacesWithOwnerPermissionsResponse :: $response");
    placesWithOwnerPermissionsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponsePlacesWithOwnerPermissions>> getPlacesWithOwnerPermissions(RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions) async {
    _setPlacesWithOwnerPermissionsResponse(ApiResponse.loading());
    print(requestPlacesWithOwnerPermissions.toJson().toString());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.PLACES_WITH_OWNER_PERMISSIONS, requestPlacesWithOwnerPermissions);

      Utils.printMsg("setPlacesWithOwnerPermissionsResponse :: RES:-- $response");
      final jsonData = ResponsePlacesWithOwnerPermissions.fromJson(response);
      _setPlacesWithOwnerPermissionsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setPlacesWithOwnerPermissionsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}