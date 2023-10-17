/// applicationId : "string"
/// deleteDateTime : "2022-12-12T07:06:14.775Z"
/// deleteBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// ids : [{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6"},{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6"}]

class RequestDeleteMultipleRooms {
  String? _applicationId;
  String? _deleteDateTime;
  String? _deleteBy;
  List<Ids>? _ids;

  String? get applicationId => _applicationId;
  String? get deleteDateTime => _deleteDateTime;
  String? get deleteBy => _deleteBy;
  List<Ids>? get ids => _ids;

  RequestDeleteMultipleRooms({
    String? applicationId,
    String? deleteDateTime,
    String? deleteBy,
    List<Ids>? ids}){
    _applicationId = applicationId;
    _deleteDateTime = deleteDateTime;
    _deleteBy = deleteBy;
    _ids = ids;
  }

  RequestDeleteMultipleRooms.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _deleteDateTime = json["deleteDateTime"];
    _deleteBy = json["deleteBy"];
    if (json["ids"] != null) {
      _ids = [];
      json["ids"].forEach((v) {
        _ids?.add(Ids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["deleteDateTime"] = _deleteDateTime;
    map["deleteBy"] = _deleteBy;
    if (_ids != null) {
      map["ids"] = _ids?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"

class Ids {
  String? _id;

  String? get id => _id;

  Ids({
    String? id}){
    _id = id;
  }

  Ids.fromJson(dynamic json) {
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    return map;
  }

}

/// value : {"meta":{"message":"Rooms not deleted.","status":"fail","code":0}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseDeleteMultipleRooms {
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

  ResponseDeleteMultipleRooms({
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

  ResponseDeleteMultipleRooms.fromJson(dynamic json) {
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

/// meta : {"message":"Rooms not deleted.","status":"fail","code":0}

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

/// message : "Rooms not deleted."
/// status : "fail"
/// code : 0

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