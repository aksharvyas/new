import 'package:flutter/material.dart';

import '../data/remote/network/ApiEndPoints.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../data/remote/response/ApiResponse.dart';
import '../models/RenamePlaceModel.dart';
import '../utils/Utils.dart';

class RenamePlaceVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseRenamePlace> renamePlaceData = ApiResponse.none();

  void _setRenamePlaceResponse(ApiResponse<ResponseRenamePlace> response) {
    Utils.printMsg("renamePlaceResponse :: $response");
    renamePlaceData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseRenamePlace>> renamePlace(RequestRenamePlace requestRenamePlace) async {
    _setRenamePlaceResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.RENAME_HOME, requestRenamePlace);

      Utils.printMsg("renamePlaceResponse :: RES:-- $response");
      final jsonData = ResponseRenamePlace.fromJson(response);
      _setRenamePlaceResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setRenamePlaceResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}