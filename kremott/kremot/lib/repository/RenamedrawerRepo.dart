import 'package:kremot/data/remote/network/NetworkApiService.dart';
import 'package:kremot/models/SwitchModel.dart';
import 'package:kremot/models/deviceModel.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../models/LoginModel.dart';
import '../models/RenameRoomModel.dart';


class RenamedrawerRepo
{
  final BaseApiService _apiService = NetworkApiService();

  Future<ResponseRenameRoom> login(RequestLogin requestLogin) async {
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints().USER_LOGIN,requestLogin);
      final jsonData = ResponseRenameRoom.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }


}
