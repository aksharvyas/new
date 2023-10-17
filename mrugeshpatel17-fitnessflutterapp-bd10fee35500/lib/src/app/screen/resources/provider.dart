import 'dart:async';
import 'dart:convert';
import 'dart:convert' as prefix0;
import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';
import 'package:fitness_ble_app/src/app/screen/helper/utility.dart';
import 'package:fitness_ble_app/src/app/screen/model/IR1_and_IR2_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/add_patient_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/import_csv_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/login_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/null_comman_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

const STATUS_FAIL = 0;
const STATUS_SUCCESS = 1;
const STATUS_NOT_VERIFIED_USER = 2;

class LoginType {
  static const String LOGIN_NORMAL = "1";
  static const String LOGIN_FB = "2";
  static const String LOGIN_GOOGLE = "3";
}

String tok = "";

//const BASE_URL = "http://122.169.109.79:4280/fitnessbackend/api/v1";
// const BASE_URL = "http://18.116.135.173/fitnessbackend/api/v1";
const BASE_URL = "http://52.202.116.78/fitnessbackend/api/v1";

///local ip
//const BASE_URL = "http://192.168.0.101/fitnessbackend/api/v1";

const TYPE_FORM_DATA = {"Content-Type": "application/x-www-form-urlencoded"};
const TYPE_JSON_DATA = {"Content-Type": "application/json"};
var TYPE_JSON_DATA1 = {
  "Accept": "application/json",
  "Content-Type": "application/json"
};
var TYPE_FORM_DATA_AUTH = {
  "Content-Type": "application/x-www-form-urlencoded",
  "Authorization": '$tok'
};
var TYPE_JSON_DATA_AUTH = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "Authorization": '$tok'
};

ApiProvider apiProvider = ApiProvider();

class ApiProvider {
  Client client = Client();
  final _apiKey = 'api-key';

  getToken() async {
    tok = (await LocalStorageService.getToken())!;
    log(tok);
  }

  Future<ResponseSignup?> signup(request) async {
      return await client
          .post(Uri.parse("$BASE_URL/register"),
          body: jsonEncode(request), headers: TYPE_JSON_DATA)
          .then((Response response) {

        showToast(response.statusCode.toString());
        if (handleResponseAxios(response) != null) {

          print("SIGNUP RESPONSE:" + response.body);
          ResponseSignup res =
          ResponseSignup.fromJson(json.decode(response.body));
          log(res.meta!.message!);
          print("log  ${res.meta!.message!}");
          return res;
        }
        else {
          return null;
        }
      });
  }

  Future<ResponseLoginModel?> login(request) async {
        log("login REQUEST..." + jsonEncode(request));
        return await client
            .post(Uri.parse("$BASE_URL/login"),
                body: jsonEncode(request), headers: TYPE_JSON_DATA)
            .then((Response response) {
              showToast(response.statusCode.toString());
          if (handleResponseAxios(response) != null) {
            print("login RESPONSE:" + response.body);
            ResponseLoginModel res =
                ResponseLoginModel.fromJson(json.decode(response.body));
            //log(res.meta.message);
            return res;
          } else {
            return null;
          }
        });
  }

  Future<ResponseAddPatient?> addEditPatient(request) async {
    log("add-edit-patient REQUEST..." + jsonEncode(request));
    await getToken();
    log("Token $tok");
    return await client
        .post(Uri.parse("$BASE_URL/add-edit-patient"),
        body: jsonEncode(request), headers: TYPE_JSON_DATA_AUTH)
        .then((Response response) {
      if (handleResponseAxios(response) != null) {
        log("add-edit-patient RESPONSE:" + response.body);
        ResponseAddPatient res =
        ResponseAddPatient.fromJson(json.decode(response.body));
        log(res.meta!.message!);
        return res;
      } else {
        return null;
      }
    });
  }

  Future<ResponseListPatients?> patientsList(request) async {
    log("patients REQUEST..." + jsonEncode(request));
    await getToken();
    log("Token $tok");
    return await client
        .post(Uri.parse("$BASE_URL/patients"),
        body: jsonEncode(request), headers: TYPE_JSON_DATA_AUTH)
        .then((Response response) {
      if (handleResponseAxios(response) != null) {
        log("patients RESPONSE:" + response.body);
        ResponseListPatients res =
        ResponseListPatients.fromJson(json.decode(response.body));
        log(res.meta!.message!);
        return res;
      } else {
        return null;
      }
    });
  }

  Future<NullDataCommanModel?> forgotPassWord(request) async {
    log("forgot-password REQUEST..." + jsonEncode(request));
    return await client
        .post(Uri.parse("$BASE_URL/forgot-password"),
        body: jsonEncode(request), headers: TYPE_JSON_DATA)
        .then((Response response) {
      if (handleResponseAxios(response) != null) {
        log("forgot-password RESPONSE:" + response.body);
        NullDataCommanModel res =
        NullDataCommanModel.fromJson(json.decode(response.body));
        log(res.meta!.message!);
        return res;
      } else {
        return null;
      }
    });
  }

  Future<NullDataCommanModel?> resetPassWord(request) async {
    log("reset-password REQUEST..." + jsonEncode(request));
    return await client
        .post(Uri.parse("$BASE_URL/reset-password"),
        body: jsonEncode(request), headers: TYPE_JSON_DATA)
        .then((Response response) {
      if (handleResponseAxios(response) != null) {
        log("reset-password RESPONSE:" + response.body);
        NullDataCommanModel res =
        NullDataCommanModel.fromJson(json.decode(response.body));
        //log(res.meta.message);
        return res;
      } else {
        return null;
      }
    });
  }
  // void uploadCsvOnAPI(File filename) async{
  //   var uri = Uri.parse("$BASE_URL/import-patient-data");
  //   var request = http.MultipartRequest('POST',uri);
  //   request.headers["Accept"] = "application/json";
  //   request.headers["Authorization"] = (await LocalStorageService.getToken())!;
  //   print("request headers ${request.headers}");
  //
  //   var stream = new http.ByteStream(DelegatingStream.typed(filename.openRead()));
  //   var length = await filename.length();
  //   var multipartFile = new http.MultipartFile('csv_file', stream, length,
  //       filename: basename(filename.path));
  //   print("stream ${stream} length $length");
  //   request.files.add(multipartFile);
  //   print("request ${request}");
  //   showToast("uploading csv file wait few second");
  //   var response = await request.send();
  //   print("response  $response");
  //   if (response.statusCode == 200) {
  //     print("Uploaded Success");
  //     showToast("Successfully upload csv file");
  //   } else {
  //     print("Upload Failed");
  //   }
  //   response.stream.transform(utf8.decoder).transform(json.decoder).listen((value) {
  //    ResponseImportCsv? res;
  //     print("value $value");
  //     if(response.statusCode == 200 && res!=null){
  //       res = ResponseImportCsv.fromJson(value as Map<String, dynamic>);
  //       //bleDataList_copy.clear();
  //     }
  //     if(res!.meta!.code == 1){
  //      // csvFileUpdateCounter++;
  //       print("res.meta.code  ${res.meta!.message}");
  //     //  print("csvFileUpdateCounter value $csvFileUpdateCounter");
  //     }
  //   });
  //
  // }

  Future<IR1AndIR2Model?> getpatientdata(RequestIR1AndIR2 request) async {
    log("patients REQUEST..." + jsonEncode(request));
    await getToken();
    log("Token $tok");
    return await client
        .post(Uri.parse("$BASE_URL/get-patient-data"),
        body: jsonEncode(request), headers: TYPE_JSON_DATA_AUTH)
        .then((Response response) {
      if (handleResponseAxios(response) != null) {
        log("IR1AndIR2Model RESPONSE:" + response.body);
        IR1AndIR2Model res =
        IR1AndIR2Model.fromJson(json.decode(response.body));
        log(res.meta!.message!);
        return res;
      } else {
        return null;
      }
    });
  }




  bool internetChecking() {
    bool internetVl = false;
    isConnected().then((internet){
      if (internet) {
        internetVl = internet;
        debugPrint("internet checking $internetVl");
        return internetVl;
      } else {
        showToastRed("no internet connection");
        return internetVl;
      }
    });
    return internetVl;
  }

  // method defined to check internet connectivity
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  String handleResponseAxios(Response response) {
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else if (response.statusCode == 400) {
      log("not authorised..." +
          ResponseNotOk.fromJson(json.decode(response.body)).message!);
      showToast(ResponseNotOk.fromJson(json.decode(response.body)).message);
      return  response.body;
    } else if (response.statusCode == 401) {
      showToast(ResponseNotOk.fromJson(json.decode(response.body)).message);
      return  response.body;
    } else {
      const error = 'Something went wrong, Please try again later!';
      showToast(error);
      return  response.body;
    }
  }


}

class ResponseNotOk {
  String? message;
  int? code;

  ResponseNotOk({required this.message, required this.code});

  ResponseNotOk.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
