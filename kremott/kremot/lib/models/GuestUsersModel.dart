/// applicationId : "string"
/// appuserId : "08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4"

class RequestGuestUsers {
  String? _applicationId;
  String? _appuserId;

  String? get applicationId => _applicationId;
  String? get appuserId => _appuserId;

  RequestGuestUsers({
    String? applicationId,
    String? appuserId}){
    _applicationId = applicationId;
    _appuserId = appuserId;
  }

  RequestGuestUsers.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _appuserId = json["appuserId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["appuserId"] = _appuserId;
    return map;
  }

}

/// value : {"appUserAccessPermissions":[{"appUserID":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","userName":"qa 29429608653"}],"meta":{"message":"success.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseGuestUsers {
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

  ResponseGuestUsers({
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

  ResponseGuestUsers.fromJson(dynamic json) {
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

/// appUserAccessPermissions : [{"appUserID":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","userName":"qa 29429608653"}]
/// meta : {"message":"success.","status":"success","code":1}

class Value {
  List<GuestAccessPermissions>? _appUserAccessPermissions;
  Meta? _meta;

  List<GuestAccessPermissions>? get appUserAccessPermissions => _appUserAccessPermissions;
  Meta? get meta => _meta;

  Value({
    List<GuestAccessPermissions>? appUserAccessPermissions,
    Meta? meta}){
    _appUserAccessPermissions = appUserAccessPermissions;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["appUserAccessPermissions"] != null) {
      _appUserAccessPermissions = [];
      json["appUserAccessPermissions"].forEach((v) {
        _appUserAccessPermissions?.add(GuestAccessPermissions.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_appUserAccessPermissions != null) {
      map["appUserAccessPermissions"] = _appUserAccessPermissions?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "success."
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

/// appUserID : "7e8f46f6-4e62-4250-92ad-8ceffbf91903"
/// userName : "qa 29429608653"

class GuestAccessPermissions {
  String? _appUserID;
  String? _userName;
  bool? _isSelected = false;

  String? get appUserID => _appUserID;
  String? get userName => _userName;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  GuestAccessPermissions({
    String? appUserID,
    String? userName}){
    _appUserID = appUserID;
    _userName = userName;
  }

  GuestAccessPermissions.fromJson(dynamic json) {
    _appUserID = json["appUserID"];
    _userName = json["userName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["appUserID"] = _appUserID;
    map["userName"] = _userName;
    return map;
  }

}