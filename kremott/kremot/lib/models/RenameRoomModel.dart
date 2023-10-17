/// applicationId : "string"
/// id : "D833A266-FE42-4A2E-8CDD-F4C7E6FE2FE3"
/// room : "string"
/// appUserId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// updatedDateTime : "2022-12-02T06:20:42.758Z"
/// updatedBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"

class RequestRenameRoom {
  String? _applicationId;
  String? _id;
  String? _room;
  String? _appUserId;
  String? _updatedDateTime;
  String? _updatedBy;

  String? get applicationId => _applicationId;
  String? get id => _id;
  String? get room => _room;
  String? get appUserId => _appUserId;
  String? get updatedDateTime => _updatedDateTime;
  String? get updatedBy => _updatedBy;

  RequestRenameRoom({
    String? applicationId,
    String? id,
    String? room,
    String? appUserId,
    String? updatedDateTime,
    String? updatedBy}){
    _applicationId = applicationId;
    _id = id;
    _room = room;
    _appUserId = appUserId;
    _updatedDateTime = updatedDateTime;
    _updatedBy = updatedBy;
  }

  RequestRenameRoom.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _id = json["id"];
    _room = json["room"];
    _appUserId = json["appUserId"];
    _updatedDateTime = json["updatedDateTime"];
    _updatedBy = json["updatedBy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["id"] = _id;
    map["room"] = _room;
    map["appUserId"] = _appUserId;
    map["updatedDateTime"] = _updatedDateTime;
    map["updatedBy"] = _updatedBy;
    return map;
  }

}

class ResponseRenameRoom {
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

  ResponseRenameRoom({
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

  ResponseRenameRoom.fromJson(dynamic json) {
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