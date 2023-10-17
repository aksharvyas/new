import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/ChangeMultipleHomesOwnershipModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class ChangeMultipleHomesOwnershipVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponseChangeMultipleHomesOwnership> changeMultipleHomesOwnershipData = ApiResponse.none();

  void _setChangeMultipleHomesOwnershipResponse(ApiResponse<ResponseChangeMultipleHomesOwnership> response) {
    Utils.printMsg("setChangeMultipleHomesOwnershipResponse :: $response");
    changeMultipleHomesOwnershipData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponseChangeMultipleHomesOwnership>> changeMultipleHomesOwnership(RequestChangeMultipleHomesOwnership requestChangeMultipleHomesOwnership) async {
    _setChangeMultipleHomesOwnershipResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.CHANGE_MULTIPLE_HOMES_OWNERSHIP, requestChangeMultipleHomesOwnership);

      Utils.printMsg("setChangeMultipleHomesOwnershipResponse :: RES:-- $response");
      final jsonData = ResponseChangeMultipleHomesOwnership.fromJson(response);
      _setChangeMultipleHomesOwnershipResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setChangeMultipleHomesOwnershipResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}