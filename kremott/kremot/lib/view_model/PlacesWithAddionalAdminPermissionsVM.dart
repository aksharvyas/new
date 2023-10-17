import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../models/PlacesWithAdditionalAdminPermissionsModel.dart';
import '../utils/Utils.dart';

class PlacesWithAdditionalAdminPermissionsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponsePlacesWithAdditionalAdminPermissions> placesWithAdditionalAdminPermissionsData = ApiResponse.none();

  void _setPlacesWithAdditionalAdminPermissionsResponse(ApiResponse<ResponsePlacesWithAdditionalAdminPermissions> response) {
    Utils.printMsg("setPlacesWithAdditionalAdminPermissionsResponse :: $response");
    placesWithAdditionalAdminPermissionsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponsePlacesWithAdditionalAdminPermissions>> getPlacesWithAdditionalAdminPermissions(RequestPlacesWithAdditionalAdminPermissions requestPlacesWithAdditionalAdminPermissions) async {
    _setPlacesWithAdditionalAdminPermissionsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.PLACES_WITH_ADDITIONAL_ADMIN_PERMISSIONS, requestPlacesWithAdditionalAdminPermissions);

      Utils.printMsg("setPlacesWithAdditionalAdminPermissionsResponse :: RES:-- $response");
      final jsonData = ResponsePlacesWithAdditionalAdminPermissions.fromJson(response);
      _setPlacesWithAdditionalAdminPermissionsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setPlacesWithAdditionalAdminPermissionsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}