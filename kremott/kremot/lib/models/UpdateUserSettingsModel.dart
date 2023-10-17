/// applicationId : "string"
/// id : 50
/// appUserId : "f4e182a3-a712-4249-a07d-1acbd9a31f38"
/// themeId : 0
/// vibration : true
/// notification : true
/// tapSound : true
/// updatedDateTime : "2022-12-02T12:19:43.024Z"
/// updatedBy : "f4e182a3-a712-4249-a07d-1acbd9a31f38"

class RequestUpdateUserSettings {
  String? _applicationId;
  int? _id;
  String? _appUserId;
  int? _themeId;
  bool? _vibration;
  bool? _notification;
  bool? _tapSound;
  String? _updatedDateTime;
  String? _updatedBy;

  String? get applicationId => _applicationId;
  int? get id => _id;
  String? get appUserId => _appUserId;
  int? get themeId => _themeId;
  bool? get vibration => _vibration;
  bool? get notification => _notification;
  bool? get tapSound => _tapSound;
  String? get updatedDateTime => _updatedDateTime;
  String? get updatedBy => _updatedBy;

  RequestUpdateUserSettings({
    String? applicationId,
    int? id,
    String? appUserId,
    int? themeId,
    bool? vibration,
    bool? notification,
    bool? tapSound,
    String? updatedDateTime,
    String? updatedBy}){
    _applicationId = applicationId;
    _id = id;
    _appUserId = appUserId;
    _themeId = themeId;
    _vibration = vibration;
    _notification = notification;
    _tapSound = tapSound;
    _updatedDateTime = updatedDateTime;
    _updatedBy = updatedBy;
  }

  RequestUpdateUserSettings.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _id = json["id"];
    _appUserId = json["appUserId"];
    _themeId = json["themeId"];
    _vibration = json["vibration"];
    _notification = json["notification"];
    _tapSound = json["tapSound"];
    _updatedDateTime = json["updatedDateTime"];
    _updatedBy = json["updatedBy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["id"] = _id;
    map["appUserId"] = _appUserId;
    map["themeId"] = _themeId;
    map["vibration"] = _vibration;
    map["notification"] = _notification;
    map["tapSound"] = _tapSound;
    map["updatedDateTime"] = _updatedDateTime;
    map["updatedBy"] = _updatedBy;
    return map;
  }

}

/// value : {"meta":{"message":"AppUser Setting Updated.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseUpdateUserSettings {
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

  ResponseUpdateUserSettings({
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

  ResponseUpdateUserSettings.fromJson(dynamic json) {
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

/// meta : {"message":"AppUser Setting Updated.","status":"success","code":1}

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

/// message : "AppUser Setting Updated."
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