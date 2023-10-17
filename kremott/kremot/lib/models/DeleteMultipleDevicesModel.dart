/// applicationId : "string"
/// deleteBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// deleteDateTime : "2022-12-13T13:10:58.880Z"
/// ids : [{"id":0}]

class RequestDeleteMultipleDevices {
  String? _applicationId;
  String? _deleteBy;
  String? _deleteDateTime;
  List<GroupIds>? _ids;

  String? get applicationId => _applicationId;
  String? get deleteBy => _deleteBy;
  String? get deleteDateTime => _deleteDateTime;
  List<GroupIds>? get ids => _ids;

  RequestDeleteMultipleDevices({
    String? applicationId,
    String? deleteBy,
    String? deleteDateTime,
    List<GroupIds>? ids}){
    _applicationId = applicationId;
    _deleteBy = deleteBy;
    _deleteDateTime = deleteDateTime;
    _ids = ids;
  }

  RequestDeleteMultipleDevices.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _deleteBy = json["deleteBy"];
    _deleteDateTime = json["deleteDateTime"];
    if (json["ids"] != null) {
      _ids = [];
      json["ids"].forEach((v) {
        _ids?.add(GroupIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["deleteBy"] = _deleteBy;
    map["deleteDateTime"] = _deleteDateTime;
    if (_ids != null) {
      map["ids"] = _ids?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0

class GroupIds {
  int? _id;

  int? get id => _id;

  GroupIds({
    int? id}){
    _id = id;
  }

  GroupIds.fromJson(dynamic json) {
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    return map;
  }

}

class ResponseDeleteMultipleDevices {
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

  ResponseDeleteMultipleDevices({
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

  ResponseDeleteMultipleDevices.fromJson(dynamic json) {
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