import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kremot/data/remote/AppException.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/network/BaseApiService.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/utils/Utils.dart';

import '../../../models/AddProduction.dart';
import '../../../models/getProductionCmac.dart';
import '../../../models/productionUsersModel.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    String? token = await LocalStorageService.getToken();
    try {
      final response = await http.get(
          Uri.parse(
            BASE_URL + url,
          ),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": token!
          });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }

  @override
  Future postResponse(String url, dynamic request) async {
    String? token = await LocalStorageService.getToken();
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(BASE_URL + url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: jsonEncode(request),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponseWithToken(String url, request) async {
    String? token = await LocalStorageService.getToken();
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(BASE_URL + url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: jsonEncode(request),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getResponseWithoutToken(String url) async {
    // TODO: implement getResponseWithoutToken
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse(
            BASE_URL + url,
          ),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<String?> getProductionUserToken() async {
    print("getprod");
    var url = Uri.parse(BASE_URL + ApiEndPoints.PRODUCTION_USER);

    final response = await (http.post(url,
        body: jsonEncode({
          "applicationId": "string",
          "mobileNo": "7777777777",
          "contryCode": "IN",
          "password": "7777777777"
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/problem+json"
        }));

    print(response.headers);
    print(response.request);
    print(response.reasonPhrase);
    print(response.persistentConnection);
    final json = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // List<ProductionUsersModel> data = [];
      // data.add(ProductionUsersModel.fromJson(jsonDecode(response.body)));

      return await json['value']['tokenViewModel']['jwtToken'];
    } else {
      return null;
    }
  }

  Future add(String apiURL, request, Class) async {
    // List<ProductionUsersModel> a =
    //     await getProductionUserToken() as List<ProductionUsersModel>;
    // String? token = await getProductionUserToken();

    String? token = await LocalStorageService.getToken();

    // String? token = a[0].value!.tokenViewModel!.jwtToken!.toString();

    var url = Uri.parse(BASE_URL + apiURL);
    print("tokennn" + token.toString());
    final response = await http.post(url, body: jsonEncode(request), headers: {
      "Accept": "application/json",
      "content-type": "application/problem+json",
      "Authorization": "Bearer $token",
    });
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    print(response.request);

    print(response.reasonPhrase);
    print(response.persistentConnection);

    if (response.statusCode == 201 || response.statusCode == 200) {
      // print("success");

      return await jsonDecode(response.body);
    } else {
      // print("Error");
      return null;
    }
  }

  Future<bool?> checkSwitchByCmac(
      String appId, String macId, BuildContext context) async {
    // List<ProductionUsersModel> a =
    // await getProductionUserToken() as List<ProductionUsersModel>;
    String? token = await getProductionUserToken();
    // String? token = a[0].value!.tokenViewModel!.jwtToken!.toString();
    String ur =
        "${BASE_URL}${ApiEndPoints.CHECK_SWITCH_BY_ID}?ApplicationId=$appId&CmacId=$macId";
    try {
      var url = Uri.parse(ur);
      final response = (await http.get(url, headers: {
        "Authorization": "Bearer $token",
      }));
      final json = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print("successcheck" + json['value']['meta']['status']);
        if (json['value']['meta']['status'].toString() == "success") {
          // Utils.toastMessage(false, "Switch Already added", context);
          // await Future.delayed(Duration(seconds: 5));
          return true;
        } else {
          return false;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("exceptionInCheckId" + e.toString());
    }
  }
}
