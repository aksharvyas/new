import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/PlacesWithGuestPermissionsModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class PlacesWithGuestPermissionsVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponsePlacesWithGuestPermissions> placesWithGuestPermissionsData = ApiResponse.none();

  void _setPlacesWithGuestPermissionsResponse(ApiResponse<ResponsePlacesWithGuestPermissions> response) {
    Utils.printMsg("setPlacesWithGuestPermissionsResponse :: $response");
    placesWithGuestPermissionsData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponsePlacesWithGuestPermissions>> getPlacesWithGuestPermissions(RequestPlacesWithGuestPermissions requestPlacesWithResponsePlacesWithGuestPermissions) async {
    _setPlacesWithGuestPermissionsResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.PLACES_WITH_GUEST_PERMISSIONS, requestPlacesWithResponsePlacesWithGuestPermissions);

      Utils.printMsg("setPlacesWithGuestPermissionsResponse :: RES:-- $response");
      final jsonData = ResponsePlacesWithGuestPermissions.fromJson(response);
      _setPlacesWithGuestPermissionsResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setPlacesWithGuestPermissionsResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}