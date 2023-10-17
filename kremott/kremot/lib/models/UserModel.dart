import 'package:kremot/global/storage.dart';
import 'package:kremot/models/Meta.dart';

class RequestRegister {
  String? firstName;
  String? lastName;
  String? emaiId;
  String? password;
  String? mobileNo;
  String? contryCode;
  String? applicationId;
  int? os;
  String? imei;
  String? createdDateTime;
  int? themeId;
  bool? vibration;
  bool? notification;
  bool? tapSound;

  RequestRegister(
      {this.firstName,
        this.lastName,
        this.emaiId,
        this.password,
        this.mobileNo,
        this.contryCode,
        this.applicationId,
        this.os,
        this.imei,
        this.createdDateTime,
        this.themeId,
        this.vibration,
        this.notification,
        this.tapSound});

  RequestRegister.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emaiId = json['emaiId'];
    password = json['password'];
    mobileNo = json['mobileNo'];
    contryCode = json['contryCode'];
    applicationId = json['applicationId'];
    os = json['os'];
    imei = json['imei'];
    createdDateTime = json['createdDateTime'];
    themeId = json['themeId'];
    vibration = json['vibration'];
    notification = json['notification'];
    tapSound = json['tapSound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emaiId'] = emaiId;
    data['password'] = password;
    data['mobileNo'] = mobileNo;
    data['contryCode'] = contryCode;
    data['applicationId'] = applicationId;
    data['os'] = os;
    data['imei'] = imei;
    data['createdDateTime'] = createdDateTime;
    data['themeId'] = themeId;
    data['vibration'] = vibration;
    data['notification'] = notification;
    data['tapSound'] = tapSound;
    return data;
  }
}




class ResponseRegister {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponseRegister(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseRegister.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    // if (this.formatters != null) {
    //   data['formatters'] = this.formatters!.map((v) => v.toJson()).toList();
    // }
    // if (this.contentTypes != null) {
    //   data['contentTypes'] = this.contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = declaredType;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Value {
  Token? token;
  Data? data;
  Meta? meta;

  Value({this.token, this.data, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (token != null) {
      data['token'] = token!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Token {
  String? jwtToken;
  String? jwtExpiration;
  String? refereshToken;
  String? refereshExpiration;

  Token(
      {this.jwtToken,
        this.jwtExpiration,
        this.refereshToken,
        this.refereshExpiration});

  Token.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwtToken'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jwtToken'] = jwtToken;
    data['jwtExpiration'] = jwtExpiration;
    data['refereshToken'] = refereshToken;
    data['refereshExpiration'] = refereshExpiration;
    return data;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? emaiId;
  String? password;
  String? mobileNo;
  String? contryCode;
  String? applicationId;
  int? os;
  String? imei;
  String? createdDateTime;
  int? themeId;
  bool? vibration;
  bool? notification;
  bool? tapSound;
  String? appUserId;
  int? appUserSettingsId;

  Data(
      {this.firstName,
        this.lastName,
        this.emaiId,
        this.password,
        this.mobileNo,
        this.contryCode,
        this.applicationId,
        this.os,
        this.imei,
        this.createdDateTime,
        this.themeId,
        this.vibration,
        this.notification,
        this.tapSound,
        this.appUserId,
        this.appUserSettingsId});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emaiId = json['emaiId'];
    password = json['password'];
    mobileNo = json['mobileNo'];
    if(mobileNo!=null){
      LocalStorageService.setMobileNumber(mobileNo!);
    }
    contryCode = json['contryCode'];
    applicationId = json['applicationId'];
    if(applicationId!=null){
      LocalStorageService.setAppId(applicationId!);
    }
    os = json['os'];
    imei = json['imei'];
    createdDateTime = json['createdDateTime'];
    themeId = json['themeId'];
    vibration = json['vibration'];
    notification = json['notification'];
    tapSound = json['tapSound'];
    appUserId = json['appUserId'];
    if(appUserId!=null){
      LocalStorageService.setUserId(appUserId!);
    }
    appUserSettingsId = json['appUserSettingsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emaiId'] = emaiId;
    data['password'] = password;
    data['mobileNo'] = mobileNo;
    data['contryCode'] = contryCode;
    data['applicationId'] = applicationId;
    data['os'] = os;
    data['imei'] = imei;
    data['createdDateTime'] = createdDateTime;
    data['themeId'] = themeId;
    data['vibration'] = vibration;
    data['notification'] = notification;
    data['tapSound'] = tapSound;
    data['appUserId'] = appUserId;
    data['appUserSettingsId'] = appUserSettingsId;
    return data;
  }
}





class RequestMobile {
  String? mobileNo;
  String? contryCode;
  String? applicationId;

  RequestMobile({this.mobileNo, this.contryCode, this.applicationId});

  RequestMobile.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    contryCode = json['contryCode'];
    applicationId = json['applicationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNo'] = mobileNo;
    data['contryCode'] = contryCode;
    data['applicationId'] = applicationId;
    return data;
  }
}

class ResponseMobile {
  Value? value;
  List<void>? formatters;
  List<void>? contentTypes;
  dynamic declaredType;
  int? statusCode;

  ResponseMobile(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseMobile.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ?  Value.fromJson(json['value']) : null;
    // if (json['formatters'] != null) {
    //   formatters = <Null>[];
    //   json['formatters'].forEach((v) {
    //     formatters!.add(new dynamic.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    // if (this.formatters != null) {
    //   data['formatters'] = this.formatters!.map((v) => v.toJson()).toList();
    // }
    // if (this.contentTypes != null) {
    //   data['contentTypes'] = this.contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = declaredType;
    data['statusCode'] = statusCode;
    return data;
  }
}





