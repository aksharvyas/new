/// value : {"sceneList":[{"id":"30cd8f39-3437-4d0b-8e9b-c1027049f189","name":"Scene1","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"3bad4b9c-aed8-4e5b-b07a-4ec1beda976f","name":"Scene2","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"4d3add56-5950-4a75-9411-98362a47d902","name":"Scene3","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"90f5a762-f219-44ec-86ef-5a46414341ed","name":"Scene4","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"2403f754-1462-49d6-90e0-d00cf8c06f0e","name":"Scene5","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"0685c95e-8624-4a0e-b57d-9b4fa1c25a3a","name":"Scene6","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"b9b2f914-498e-4645-983e-fb2c7bc80d24","name":"Scene7","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"277eb72f-d146-4804-8466-32171ee746d4","name":"Scene8","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"}],"meta":{"message":"success.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseScenes {
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

  ResponseScenes({
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

  ResponseScenes.fromJson(dynamic json) {
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

/// sceneList : [{"id":"30cd8f39-3437-4d0b-8e9b-c1027049f189","name":"Scene1","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"3bad4b9c-aed8-4e5b-b07a-4ec1beda976f","name":"Scene2","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"4d3add56-5950-4a75-9411-98362a47d902","name":"Scene3","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"90f5a762-f219-44ec-86ef-5a46414341ed","name":"Scene4","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"2403f754-1462-49d6-90e0-d00cf8c06f0e","name":"Scene5","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"0685c95e-8624-4a0e-b57d-9b4fa1c25a3a","name":"Scene6","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"b9b2f914-498e-4645-983e-fb2c7bc80d24","name":"Scene7","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"},{"id":"277eb72f-d146-4804-8466-32171ee746d4","name":"Scene8","homeId":"56080536-dff5-4555-9d64-2ad518cff76e","roomId":"419f5feb-c3f2-4301-85fe-c18f9372891b","appUserId":"8eb4da5d-6e63-4947-8812-48cecaee5147"}]
/// meta : {"message":"success.","status":"success","code":1}

class Value {
  List<SceneList>? _sceneList;
  Meta? _meta;

  List<SceneList>? get sceneList => _sceneList;
  Meta? get meta => _meta;

  Value({
    List<SceneList>? sceneList,
    Meta? meta}){
    _sceneList = sceneList;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["sceneList"] != null) {
      _sceneList = [];
      json["sceneList"].forEach((v) {
        _sceneList?.add(SceneList.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_sceneList != null) {
      map["sceneList"] = _sceneList?.map((v) => v.toJson()).toList();
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

/// id : "30cd8f39-3437-4d0b-8e9b-c1027049f189"
/// name : "Scene1"
/// homeId : "56080536-dff5-4555-9d64-2ad518cff76e"
/// roomId : "419f5feb-c3f2-4301-85fe-c18f9372891b"
/// appUserId : "8eb4da5d-6e63-4947-8812-48cecaee5147"

class SceneList {
  String? _id;
  String? _name;
  String? _homeId;
  String? _roomId;
  String? _appUserId;
  bool? _isSelected = false;

  String? get id => _id;
  String? get name => _name;
  String? get homeId => _homeId;
  String? get roomId => _roomId;
  String? get appUserId => _appUserId;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  SceneList({
    String? id,
    String? name,
    String? homeId,
    String? roomId,
    String? appUserId}){
    _id = id;
    _name = name;
    _homeId = homeId;
    _roomId = roomId;
    _appUserId = appUserId;
  }

  SceneList.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _homeId = json["homeId"];
    _roomId = json["roomId"];
    _appUserId = json["appUserId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["homeId"] = _homeId;
    map["roomId"] = _roomId;
    map["appUserId"] = _appUserId;
    return map;
  }

}

/// ApplicationId : "123774499931415"
/// RoomId : "419f5feb-c3f2-4301-85fe-c18f9372891b"

class RequestScenes {
  String? _applicationId;
  String? _roomId;

  String? get applicationId => _applicationId;
  String? get roomId => _roomId;

  RequestScenes({
    String? applicationId,
    String? roomId}){
    _applicationId = applicationId;
    _roomId = roomId;
  }

  RequestScenes.fromJson(dynamic json) {
    _applicationId = json["ApplicationId"];
    _roomId = json["RoomId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ApplicationId"] = _applicationId;
    map["RoomId"] = _roomId;
    return map;
  }

}