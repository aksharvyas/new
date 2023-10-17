import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/GuestUsersModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class GuestUsersVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseGuestUsers> guestUsersData = ApiResponse.none();

  void _setGuestUsersResponse(ApiResponse<ResponseGuestUsers> response) {
    Utils.printMsg("setGuestUsersResponse :: $response");
    guestUsersData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseGuestUsers>> getGuestUsers(RequestGuestUsers requestGuestUsers) async {
    _setGuestUsersResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.GUEST_USERS, requestGuestUsers);

      Utils.printMsg("setGuestUsersResponse :: RES:-- $response");
      final jsonData = ResponseGuestUsers.fromJson(response);
      _setGuestUsersResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setGuestUsersResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}