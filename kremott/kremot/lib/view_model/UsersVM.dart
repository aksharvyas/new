import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/UsersModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class UsersVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseUsers> usersData = ApiResponse.none();

  void _setUsersResponse(ApiResponse<ResponseUsers> response) {
    Utils.printMsg("setUsersResponse :: $response");
    usersData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseUsers>> getUsers(RequestUsers requestUsers) async {
    _setUsersResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.USERS, requestUsers);

      Utils.printMsg("setUsersResponse :: RES:-- $response");
      final jsonData = ResponseUsers.fromJson(response);
      _setUsersResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setUsersResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}