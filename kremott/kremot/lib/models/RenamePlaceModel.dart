class RequestRenamePlace {
  String? _id;
  String? _applicationId;
  String? _name;
  String? _appUserId;
  String? _updatedBy;
  String? _updatedDateTime;

  String? get id => _id;
  String? get applicationId => _applicationId;
  String? get name => _name;
  String? get appUserId => _appUserId;
  String? get updatedBy => _updatedBy;
  String? get updatedDateTime => _updatedDateTime;

  RequestRenamePlace({
    String? id,
    String? applicationId,
    String? name,
    String? appUserId,
    String? updatedBy,
    String? updatedDateTime}){
    _id = id;
    _applicationId = applicationId;
    _name = name;
    _appUserId = appUserId;
    _updatedBy = updatedBy;
    _updatedDateTime = updatedDateTime;
  }

  RequestRenamePlace.fromJson(dynamic json) {
    _id = json["Id"];
    _applicationId = json["applicationId"];
    _name = json["name"];
    _appUserId = json["appUserId"];
    _updatedBy = json["UpdatedBy"];
    _updatedDateTime = json["UpdatedDateTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Id"] = _id;
    map["applicationId"] = _applicationId;
    map["name"] = _name;
    map["appUserId"] = _appUserId;
    map["UpdatedBy"] = _updatedBy;
    map["UpdatedDateTime"] = _updatedDateTime;
    return map;
  }

}

class ResponseRenamePlace {
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

  ResponseRenamePlace({
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

  ResponseRenamePlace.fromJson(dynamic json) {
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