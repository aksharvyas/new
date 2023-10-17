/// applicationId : "string"
/// deletedDateTime : "2022-12-15T14:05:27.634Z"
/// deletedBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// appUser : [{"appUserId":"3fa85f64-5717-4562-b3fc-2c963f66afa6"}]

class RequestDeleteMultipleAdditionalAdmins {
  String? _applicationId;
  String? _deletedDateTime;
  String? _deletedBy;
  List<AppUser>? _appUser;

  String? get applicationId => _applicationId;
  String? get deletedDateTime => _deletedDateTime;
  String? get deletedBy => _deletedBy;
  List<AppUser>? get appUser => _appUser;

  RequestDeleteMultipleAdditionalAdmins({
    String? applicationId,
    String? deletedDateTime,
    String? deletedBy,
    List<AppUser>? appUser}){
    _applicationId = applicationId;
    _deletedDateTime = deletedDateTime;
    _deletedBy = deletedBy;
    _appUser = appUser;
  }

  RequestDeleteMultipleAdditionalAdmins.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _deletedDateTime = json["deletedDateTime"];
    _deletedBy = json["deletedBy"];
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
    map["deletedDateTime"] = _deletedDateTime;
    map["deletedBy"] = _deletedBy;
    if (_appUser != null) {
      map["appUser"] = _appUser?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// appUserId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"

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

class ResponseDeleteMultipleAdditionalAdmins {
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

  ResponseDeleteMultipleAdditionalAdmins({
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

  ResponseDeleteMultipleAdditionalAdmins.fromJson(dynamic json) {
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

class Value {
  Meta? _meta;

  Meta? get meta => _meta;

  Value({
    Meta? meta}){
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
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