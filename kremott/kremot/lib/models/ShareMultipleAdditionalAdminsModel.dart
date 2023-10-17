/// applicationId : "string"
/// isOwner : true
/// isAdditionalAdmin : true
/// isAdditionalUser : true
/// createdDateTime : "2022-12-12T10:58:27.941Z"
/// createdBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// appUser : [{"appUserId":"26ee5b88-bd36-4e53-aa4b-f34a994e020f"}]

class RequestShareMultipleAdditionalAdmins {
  String? _applicationId;
  bool? _isOwner;
  bool? _isAdditionalAdmin;
  bool? _isAdditionalUser;
  String? _createdDateTime;
  String? _createdBy;
  List<AppUser>? _appUser;

  String? get applicationId => _applicationId;
  bool? get isOwner => _isOwner;
  bool? get isAdditionalAdmin => _isAdditionalAdmin;
  bool? get isAdditionalUser => _isAdditionalUser;
  String? get createdDateTime => _createdDateTime;
  String? get createdBy => _createdBy;
  List<AppUser>? get appUser => _appUser;

  RequestShareMultipleAdditionalAdmins({
    String? applicationId,
    bool? isOwner,
    bool? isAdditionalAdmin,
    bool? isAdditionalUser,
    String? createdDateTime,
    String? createdBy,
    List<AppUser>? appUser}){
    _applicationId = applicationId;
    _isOwner = isOwner;
    _isAdditionalAdmin = isAdditionalAdmin;
    _isAdditionalUser = isAdditionalUser;
    _createdDateTime = createdDateTime;
    _createdBy = createdBy;
    _appUser = appUser;
  }

  RequestShareMultipleAdditionalAdmins.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _isOwner = json["isOwner"];
    _isAdditionalAdmin = json["isAdditionalAdmin"];
    _isAdditionalUser = json["isAdditionalUser"];
    _createdDateTime = json["createdDateTime"];
    _createdBy = json["createdBy"];
    if (json["appUser"] != null) {
      _appUser = [];
      json["appUser"].forEach((v) {
        _appUser?.add(AppUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["isOwner"] = _isOwner;
    map["isAdditionalAdmin"] = _isAdditionalAdmin;
    map["isAdditionalUser"] = _isAdditionalUser;
    map["createdDateTime"] = _createdDateTime;
    map["createdBy"] = _createdBy;
    if (_appUser != null) {
      map["appUser"] = _appUser?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// appUserId : "26ee5b88-bd36-4e53-aa4b-f34a994e020f"

class AppUser {
  String? _appUserId;

  String? get appUserId => _appUserId;

  AppUser({
    String? appUserId}){
    _appUserId = appUserId;
  }

  AppUser.fromJson(dynamic json) {
    _appUserId = json["appUserId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["appUserId"] = _appUserId;
    return map;
  }

}

/// value : {"appUserAccessPermission":[],"meta":{"message":"Additional Admin Permission given successfully.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseShareMultipleAdditionalAdmins {
  Value? _value;
  List<dynamic>? _formatters;
  List<dynamic>? _contentTypes;
  dynamic? _declaredType;
  int? _statusCode;

  Value? get value => _value;
  List<dynamic>? get formatters => _formatters;
  List<dynamic>? get contentTypes => _contentTypes;
  dynamic? get declaredType => _declaredType;
  int? get statusCode => _statusCode;

  ResponseShareMultipleAdditionalAdmins({
    Value? value,
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

  ResponseShareMultipleAdditionalAdmins.fromJson(dynamic json) {
    _value = json["value"] != null ? Value.fromJson(json["value"]) : null;
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

/// appUserAccessPermission : []
/// meta : {"message":"Additional Admin Permission given successfully.","status":"success","code":1}

class Value {
  List<dynamic>? _appUserAccessPermission;
  Meta? _meta;

  List<dynamic>? get appUserAccessPermission => _appUserAccessPermission;
  Meta? get meta => _meta;

  Value({
    List<dynamic>? appUserAccessPermission,
    Meta? meta}){
    _appUserAccessPermission = appUserAccessPermission;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    // if (json["appUserAccessPermission"] != null) {
    //   _appUserAccessPermission = [];
    //   json["appUserAccessPermission"].forEach((v) {
    //     _appUserAccessPermission?.add(dynamic.fromJson(v));
    //   });
    // }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_appUserAccessPermission != null) {
      map["appUserAccessPermission"] = _appUserAccessPermission?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "Additional Admin Permission given successfully."
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