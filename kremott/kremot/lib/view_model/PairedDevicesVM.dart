import 'package:flutter/material.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/models/PairedDevicesModel.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../utils/Utils.dart';

class PairedDevicesVM extends ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();
  ApiResponse<ResponsePairedDevices> pairedDevicesData = ApiResponse.none();

  void _setPairedDevicesResponse(ApiResponse<ResponsePairedDevices> response) {
    Utils.printMsg("setPairedDevicesResponse :: $response");
    pairedDevicesData = response;
    notifyListeners();
  }

  Future<ApiResponse<ResponsePairedDevices>> getPairedDevices(RequestPairedDevices requestPairedDevices) async {
    _setPairedDevicesResponse(ApiResponse.loading());
    try {
      dynamic response = await _apiService.postResponse(ApiEndPoints.PAIRED_DEVICES, requestPairedDevices);

      Utils.printMsg("setPairedDevicesResponse :: RES:-- $response");
      final jsonData = ResponsePairedDevices.fromJson(response);
      _setPairedDevicesResponse(ApiResponse.completed(jsonData));

      return ApiResponse.completed(jsonData);
    } catch (e) {
      _setPairedDevicesResponse(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}