import 'package:flutter/material.dart';
import 'package:kremot/models/LoginModel.dart';
import 'package:kremot/models/UserModel.dart';

import '../data/remote/response/ApiResponse.dart';
import '../repository/UserRepo.dart';

class UserVM extends ChangeNotifier {
  final _myRepo = UserRepo();

  ApiResponse<ResponseRegister> userModel = ApiResponse.loading();

  Future<ResponseRegister?> register(
      RequestRegister requestRegister) async {
    Future<ResponseRegister?> response = _myRepo.getUserData(requestRegister);
    return response;
  }

  Future<ResponseMobile?> verifyPhone(
      RequestMobile requestMobile) async {
    Future<ResponseMobile?> response = _myRepo.verifyPhone(requestMobile);
    return response;
  }

  Future<ResponseLogin?> login(
      RequestLogin requestLogin) async {
    Future<ResponseLogin?> response = _myRepo.login(requestLogin);
    return response;
  }

  Future<ResponseForgotPassword?> forgotpassword(
      RequestForgotPassword requestForgotPassword) async {
    Future<ResponseForgotPassword?> response = _myRepo.forgotpassword(requestForgotPassword);
    return response;
  }
}
