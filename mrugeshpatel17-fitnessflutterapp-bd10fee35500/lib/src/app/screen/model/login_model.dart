
import 'dart:convert';
import 'dart:developer';

import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';


class ResponseLoginModel {
  late LoginUserData data;
  late Meta meta;

  ResponseLoginModel({required this.data, required this.meta});

  ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new LoginUserData.fromJson(json['data']) : null)!;
    meta = (json['meta'] != null ? new Meta.fromJson(json['meta']) : null)!;

    if(json["data"]!=null){
      LocalStorageService.setUser(json["data"]);
    }
    if(json["meta"]!=null){

      LocalStorageService.setToken("Bearer ${json["meta"]["token"]}");
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class LoginUserData {
  int? id;
  String? email;
  String? name;
  String? image;
  String? facebookId;
  String? twitterId;
  String? firebaseId;
  String? firebaseToken;
  String? deviceId;
  int? deviceType;

  LoginUserData(
      {required this.id,
        required this.email,
        required this.name,
        required this.image,
        required this.facebookId,
        required this.twitterId,
        required this.firebaseId,
        required this.firebaseToken,
        required this.deviceId,
        required this.deviceType});

  LoginUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    facebookId = json['facebook_id'];
    twitterId = json['twitter_id'];
    firebaseId = json['firebase_id'];
    firebaseToken = json['firebase_token'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['image'] = this.image;
    data['facebook_id'] = this.facebookId;
    data['twitter_id'] = this.twitterId;
    data['firebase_id'] = this.firebaseId;
    data['firebase_token'] = this.firebaseToken;
    data['device_id'] = this.deviceId;
    data['device_type'] = this.deviceType;
    return data;
  }
}

class Meta {
  String? message;
  int? code;
  String? token;

  Meta({required this.message, required this.code, required this.token});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['token'] = this.token;
    return data;
  }
}




class RequestSocialLogin {
  String? email;
  String? type;
  String? facebook_id;
  String? google_id;
  String? firebase_id;
  String? firebase_token;
  String? device_id;
  String? device_type;
  String? image;
  String? name;

  RequestSocialLogin(
      {required this.email,
        required this.type,
        required this.facebook_id,
        required this.google_id,
        required this.firebase_id,
        required this.firebase_token,
        required this.device_id,
        required this.device_type,
        required this.image,
        required this.name,
      });

  RequestSocialLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    device_id = json['device_id'];
    device_type = json['device_type'];
    firebase_id = json['firebase_id'];
    firebase_token = json['firebase_token'];
    type = json['type'];
    facebook_id = json['facebook_id'];
    google_id = json['twitter_id'];
    image = json['image'];
    name = json['name'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();

     json['email'] = email ;
     json['device_id']=device_id;
      json['device_type']=device_type;
      json['firebase_id']=firebase_id;
      json['firebase_token']=firebase_token;
     json['type']=type;
      json['facebook_id']=facebook_id;
      json['twitter_id']=google_id;
      json['image']=image;
      json['name']=name;
    return json;
  }
}