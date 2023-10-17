
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/network/BaseApiService.dart';
import 'package:kremot/data/remote/network/NetworkApiService.dart';
import 'package:kremot/models/HomeListModel.dart';
import 'package:kremot/models/HomeModel.dart';


class HomeRepo {

  final BaseApiService _apiService = NetworkApiService();


  Future<ResponseHome?> addHome(RequestHome requestHome) async {
    try {
      dynamic response = await _apiService.postResponseWithToken(
          ApiEndPoints().ADD_HOME, requestHome);
      final jsonData = ResponseHome.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseHomeList?> homeList(RequestHomeList requestHomeList ) async {
    try {
      dynamic response = await _apiService.postResponseWithToken(
          ApiEndPoints.ACCESSPERMISSIONHOME , requestHomeList);
      final jsonData = ResponseHomeList.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }


}