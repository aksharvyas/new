import 'package:kremot/data/remote/network/BaseApiService.dart';
import 'package:kremot/models/CMCIdVerify.dart';

import '../data/remote/network/NetworkApiService.dart';

class CMACRepo {

  final BaseApiService _apiService = NetworkApiService();


  Future<ResponseCMACID?> cmcVerify(String appid,String cmacId) async {
    try {
      dynamic response = await _apiService.getResponse(
          "Production/productiongetbycmacid?ApplicationId=$appid&CmacId=$cmacId");
      final jsonData = ResponseCMACID.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}