/// newAppUserId : "0E158A2A-2769-42A4-8022-E55895460D97"
/// appUserId : "7e8f46f6-4e62-4250-92ad-8ceffbf91903"
/// currDateTime : "2022-12-13T08:49:52.974Z"
/// applicationId : "string"
/// homeIds : [{"homeId":"e9ed268e-0c93-4407-8ca0-2ea424b7d611"}]

class RequestChangeMultipleHomesOwnership {
  String? _newAppUserId;
  String? _appUserId;
  String? _currDateTime;
  String? _applicationId;
  List<HomeIds>? _homeIds;

  String? get newAppUserId => _newAppUserId;
  String? get appUserId => _appUserId;
  String? get currDateTime => _currDateTime;
  String? get applicationId => _applicationId;
  List<HomeIds>? get homeIds => _homeIds;

  RequestChangeMultipleHomesOwnership({
    String? newAppUserId,
    String? appUserId,
    String? currDateTime,
    String? applicationId,
    List<HomeIds>? homeIds}){
    _newAppUserId = newAppUserId;
    _appUserId = appUserId;
    _currDateTime = currDateTime;
    _applicationId = applicationId;
    _homeIds = homeIds;
  }

  RequestChangeMultipleHomesOwnership.fromJson(dynamic json) {
    _newAppUserId = json["newAppUserId"];
    _appUserId = json["appUserId"];
    _currDateTime = json["currDateTime"];
    _applicationId = json["applicationId"];
    if (json["homeIds"] != null) {
      _homeIds = [];
      json["homeIds"].forEach((v) {
        _homeIds?.add(HomeIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["newAppUserId"] = _newAppUserId;
    map["appUserId"] = _appUserId;
    map["currDateTime"] = _currDateTime;
    map["applicationId"] = _applicationId;
    if (_homeIds != null) {
      map["homeIds"] = _homeIds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// homeId : "e9ed268e-0c93-4407-8ca0-2ea424b7d611"

class HomeIds {
  String? _homeId;

  String? get homeId => _homeId;

  HomeIds({
    String? homeId}){
    _homeId = homeId;
  }

  HomeIds.fromJson(dynamic json) {
    _homeId = json["homeId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["homeId"] = _homeId;
    return map;
  }

}

/// value : {"appUserAccessPermission":[],"meta":{"message":"Ownership changed successfully.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseChangeMultipleHomesOwnership {
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

  ResponseChangeMultipleHomesOwnership({
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

  ResponseChangeMultipleHomesOwnership.fromJson(dynamic json) {
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
/// meta : {"message":"Ownership changed successfully.","status":"success","code":1}

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

/// message : "Ownership changed successfully."
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