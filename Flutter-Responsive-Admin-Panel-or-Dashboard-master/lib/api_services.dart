import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/DeviceSwitchesModel.dart';
import 'package:admin/models/addSwitchModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'models/SwitchesModel.dart';
import 'models/api_model_class.dart';
import 'models/deleteSwitchModel.dart';
import 'models/updateSwitchModel.dart';

class ApiServices {
  Future<List<ApiModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.userEndpoints);
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print(await http
          .read(Uri.parse(ApiConstant.baseUrl + ApiConstant.userEndpoints)));
      if (response.statusCode == 200) {
        List<ApiModel> _model =
            apiModelFromJson(response.body) as List<ApiModel>;
        print("api${_model.length}");
        return _model;
      } else {
        throw Exception("Data loading failed");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<DeviceSwitchesModel>?> getDeviceSwitches() async {
    List<DeviceSwitchesModel> _model = [];
    var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.deviceSwitch);
    var response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _model.add(DeviceSwitchesModel.fromJson(json));
      print(_model);
      return _model;
    }
    return null;
  }

  Future<List<SwitchesModel>?> getSwitches() async {
    List<SwitchesModel> _model = [];
    var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.userEndpoints);
    var response = await http.get(url);
    final json = jsonDecode(response.body);
    print("rr" + response.reasonPhrase.toString());
    if (response.statusCode == 200) {
      _model.add(SwitchesModel.fromJson(json));
      print(_model);
      return _model;
    }
    return null;
  }

  Future<AddSwitchModel?> addSwitches(request) async {
    String? token = await LocalStorageService.getToken();
    var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.addSwitch);
    final response = await http.post(url, body: jsonEncode(request), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer $token",

    });
    print(response.statusCode);
    print(response.headers);
    print(response.request);
    print(response.reasonPhrase);
    print(response.persistentConnection);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("success");
      return AddSwitchModel.fromJson(json.decode(response.body));
    } else {
      print("Error");
      return null;
    }
  }

  Future<UpdateSwitchModel?>? updateSwitch(request) async {
    String? token = await LocalStorageService.getToken();
    var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.updateSwitch);
    final response = await http.post(url, body: jsonEncode(request), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    });
    print(response.statusCode);
    print(response.headers);
    print(response.request);
    print(response.reasonPhrase);
    print(response.persistentConnection);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("success");
      return UpdateSwitchModel.fromJson(json.decode(response.body));
    } else {
      print("Error");
      return null;
    }
  }

  Future<DeleteSwitchModel?>? deleteSwitch(request) async {
    String? token = await LocalStorageService.getToken();
    var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.deleteSwitch);
    final response = await http.post(url, body: jsonEncode(request), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
       "Authorization": "bearer $token"
    });
    print(response.statusCode);
    print(response.headers);
    print(response.request);
    print(response.reasonPhrase);
    print(response.persistentConnection);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("success");
      return DeleteSwitchModel.fromJson(json.decode(response.body));
    } else {
      print("Error");
      return null;
    }
  }
}

class LocalStorageService {
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYXNlV2ViQXBpU3ViamVjdCIsImp0aSI6ImRhMmQ1NmQyLWY5NjAtNDVkOC04OWM1LTYzY2UxNmZhZWUzMCIsImlhdCI6IjEyLTA3LTIwMjMgMTE6NTk6MTgiLCJNb2JpbGVOdW1iZXIiOiI5NjI0MTcyOTYxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQXBwVXNlciIsImV4cCI6MTY4OTc2Nzk1OCwiaXNzIjoiVGVzdC5jb20iLCJhdWQiOiJiYXNlV2ViQXBpYUF1ZGllbmNlIn0.ikTCErrPrzx5UWk3jWWg_smZuFlRUEGu2mbJpFEX4qg");
    return prefs.getString("token");
  }
}
