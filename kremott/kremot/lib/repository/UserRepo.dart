import 'package:kremot/models/LoginModel.dart';
import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../models/UserModel.dart';

class UserRepo {

  final BaseApiService _apiService = NetworkApiService();

  Future<ResponseRegister?> getUserData(RequestRegister requestRegister) async {
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints().USER_REGISTER,requestRegister);
      final jsonData = ResponseRegister.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }


  Future<ResponseMobile?> verifyPhone(RequestMobile requestMobile) async {
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints().VERIFY_MOBILEPHONE,requestMobile);
      final jsonData = ResponseMobile.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseLogin?> login(RequestLogin requestLogin) async {
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints().USER_LOGIN,requestLogin);
      final jsonData = ResponseLogin.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseForgotPassword?> forgotpassword(RequestForgotPassword requestForgotPassword) async {
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints().USER_FORGOTPASSWORD,requestForgotPassword);
      final jsonData = ResponseForgotPassword.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

}
