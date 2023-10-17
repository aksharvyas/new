import 'package:kremot/global/storage.dart';
import 'package:kremot/models/Meta.dart';

class RequestLogin {
  String? password;
  String? mobileNo;
  String? contryCode;
  String? applicationId;

  RequestLogin(
      {this.password, this.mobileNo, this.contryCode, this.applicationId});

  RequestLogin.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    mobileNo = json['mobileNo'];
    contryCode = json['contryCode'];
    applicationId = json['applicationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['mobileNo'] = mobileNo;
    data['contryCode'] = contryCode;
    data['applicationId'] = applicationId;
    return data;
  }
}


class ResponseLogin {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponseLogin(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    // if (json['formatters'] != null) {
    //   formatters = <Null>[];
    //   json['formatters'].forEach((v) {
    //     formatters!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['contentTypes'] != null) {
    //   contentTypes = <Null>[];
    //   json['contentTypes'].forEach((v) {
    //     contentTypes!.add(new Null.fromJson(v));
    //   });
    // }
    declaredType = json['declaredType'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    // if (this.formatters != null) {
    //   data['formatters'] = this.formatters!.map((v) => v.toJson()).toList();
    // }
    // if (this.contentTypes != null) {
    //   data['contentTypes'] = this.contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = this.declaredType;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Value {
  Data? data;
  RefereshTokenViewModel? refereshTokenViewModel;
  Meta? meta;

  Value({this.data, this.refereshTokenViewModel, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    refereshTokenViewModel = json['refereshTokenViewModel'] != null
        ? new RefereshTokenViewModel.fromJson(json['refereshTokenViewModel'])
        : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.refereshTokenViewModel != null) {
      data['refereshTokenViewModel'] = this.refereshTokenViewModel!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? contryCode;
  dynamic password;
  String? emailId;
  String? applicationId;
  int? os;
  String? imei;
  AppUserSetting? appUserSetting;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNo,
        this.contryCode,
        this.password,
        this.emailId,
        this.applicationId,
        this.os,
        this.imei,
        this.appUserSetting});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(id!=null){
      LocalStorageService.setUserId(id!);
    }
    firstName = json['firstName'];

    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    if(mobileNo!=null){
      LocalStorageService.setMobileNumber(mobileNo!);
    }
    contryCode = json['contryCode'];
    password = json['password'];
    emailId = json['emailId'];
    applicationId = json['applicationId'];
    if(applicationId!=null){
      LocalStorageService.setAppId(applicationId!);
    }
    os = json['os'];
    imei = json['imei'];
    appUserSetting = json['appUserSetting'] != null
        ? new AppUserSetting.fromJson(json['appUserSetting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNo'] = this.mobileNo;
    data['contryCode'] = this.contryCode;
    data['password'] = this.password;
    data['emailId'] = this.emailId;
    data['applicationId'] = this.applicationId;
    data['os'] = this.os;
    data['imei'] = this.imei;
    if (this.appUserSetting != null) {
      data['appUserSetting'] = this.appUserSetting!.toJson();
    }
    return data;
  }
}

class AppUserSetting {
  int? themeId;
  bool? vibration;
  bool? notification;
  bool? tapSound;

  AppUserSetting(
      {this.themeId, this.vibration, this.notification, this.tapSound});

  AppUserSetting.fromJson(Map<String, dynamic> json) {
    themeId = json['themeId'];
    vibration = json['vibration'];
    notification = json['notification'];
    tapSound = json['tapSound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['themeId'] = this.themeId;
    data['vibration'] = this.vibration;
    data['notification'] = this.notification;
    data['tapSound'] = this.tapSound;
    return data;
  }
}

class RefereshTokenViewModel {
  String? jwtToken;
  String? jwtExpiration;
  String? refereshToken;
  String? refereshExpiration;

  RefereshTokenViewModel(
      {this.jwtToken,
        this.jwtExpiration,
        this.refereshToken,
        this.refereshExpiration});

  RefereshTokenViewModel.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwtToken'];
    jwtExpiration = json['jwtExpiration'];
    if(jwtToken!=null){
      LocalStorageService.setToken("Bearer "+jwtToken!);
    }
    jwtExpiration = json['jwtExpiration'];

    refereshToken = json['refereshToken'];
    if(refereshToken!=null){
      LocalStorageService.setRefToken(refereshToken!);
    }
    refereshExpiration = json['refereshExpiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwtToken'] = this.jwtToken;
    data['jwtExpiration'] = this.jwtExpiration;
    data['refereshToken'] = this.refereshToken;
    data['refereshExpiration'] = this.refereshExpiration;
    return data;
  }
}





class RequestForgotPassword {
  String? password;
  String? mobileNo;
  String? contryCode;
  String? applicationId;
  //String? updatedBy;
  String? updatedDateTime;

  RequestForgotPassword(
      {this.password,
        this.mobileNo,
        this.contryCode,
        this.applicationId,
        //this.updatedBy,
        this.updatedDateTime});

  RequestForgotPassword.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    mobileNo = json['mobileNo'];
    contryCode = json['contryCode'];
    applicationId = json['applicationId'];
    //updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['password'] = password;
    data['mobileNo'] = mobileNo;
    data['contryCode'] = contryCode;
    data['applicationId'] = applicationId;
    //data['updatedBy'] = updatedBy;
    data['updatedDateTime'] = updatedDateTime;
    return data;
  }
}

/// value : {"meta":{"message":"Success","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseForgotPassword {
  ForgotValue? _value;
  List<dynamic>? _formatters;
  List<dynamic>? _contentTypes;
  dynamic? _declaredType;
  int? _statusCode;

  ForgotValue? get value => _value;
  List<dynamic>? get formatters => _formatters;
  List<dynamic>? get contentTypes => _contentTypes;
  dynamic? get declaredType => _declaredType;
  int? get statusCode => _statusCode;

  ResponseForgotPassword({
    ForgotValue? value,
    List<dynamic>? formatters,
    List<dynamic>? contentTypes,
    dynamic? declaredType,
    int? statusCode}){
    _value = value;
    _formatters = formatters;
    _contentTypes = contentTypes;
    _declaredType = declaredType;
    _statusCode = statusCode;
  }

  ResponseForgotPassword.fromJson(dynamic json) {
    _value = json["value"] != null ? ForgotValue.fromJson(json["value"]) : null;
    // if (json["formatters"] != null) {
    //   _formatters = [];
    //   json["formatters"].forEach((v) {
    //     _formatters?.add(dynamic.fromJson(v));
    //   });
    // }
    // if (json["contentTypes"] != null) {
    //   _contentTypes = [];
    //   json["contentTypes"].forEach((v) {
    //     _contentTypes?.add(dynamic.fromJson(v));
    //   });
    // }
    _declaredType = json["declaredType"];
    _statusCode = json["statusCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_value != null) {
      map["value"] = _value?.toJson();
    }
    if (_formatters != null) {
      map["formatters"] = _formatters?.map((v) => v.toJson()).toList();
    }
    if (_contentTypes != null) {
      map["contentTypes"] = _contentTypes?.map((v) => v.toJson()).toList();
    }
    map["declaredType"] = _declaredType;
    map["statusCode"] = _statusCode;
    return map;
  }

}

/// meta : {"message":"Success","status":"success","code":1}

class ForgotValue {
  Meta? _meta;

  Meta? get meta => _meta;

  Value({
    Meta? meta}){
    _meta = meta;
  }

  ForgotValue.fromJson(dynamic json) {
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "Success"
/// status : "success"
/// code : 1

class Meta {
  String? _message;
  String? _status;
  int? _code;

  String? get message => _message;
  String? get status => _status;
  int? get code => _code;

  Meta({
    String? message,
    String? status,
    int? code}){
    _message = message;
    _status = status;
    _code = code;
  }

  Meta.fromJson(dynamic json) {
    _message = json["message"];
    _status = json["status"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["status"] = _status;
    map["code"] = _code;
    return map;
  }

}

