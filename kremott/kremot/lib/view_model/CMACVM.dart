import 'package:flutter/cupertino.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/CMCIdVerify.dart';

import '../repository/CMACRepo.dart';

class CMACVM extends ChangeNotifier {
  final _myRepo = CMACRepo();

  ApiResponse<ResponseCMACID> cmcModel = ApiResponse.loading();

  Future<ResponseCMACID?> getCMACVerify(String appid, String macId) async {
    Future<ResponseCMACID?> response = _myRepo.cmcVerify(appid, macId);
    return response;
  }
}