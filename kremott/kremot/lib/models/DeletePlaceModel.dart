class RequestDeletePlace {
  String? _id;
  String? _applicationId;
  String? _appUserId;
  String? _deletedBy;
  String? _deletedDateTime;

  String? get id => _id;
  String? get applicationId => _applicationId;
  String? get appUserId => _appUserId;
  String? get deletedBy => _deletedBy;
  String? get deletedDateTime => _deletedDateTime;

  RequestDeletePlace({
    String? id,
    String? applicationId,
    String? appUserId,
    String? deletedBy,
    String? deletedDateTime}){
    _id = id;
    _applicationId = applicationId;
    _appUserId = appUserId;
    _deletedBy = deletedBy;
    _deletedDateTime = deletedDateTime;
  }

  RequestDeletePlace.fromJson(dynamic json) {
    _id = json["Id"];
    _applicationId = json["applicationId"];
    _appUserId = json["appUserId"];
    _deletedBy = json["DeletedBy"];
    _deletedDateTime = json["DeletedDateTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Id"] = _id;
    map["applicationId"] = _applicationId;
    map["appUserId"] = _appUserId;
    map["DeletedBy"] = _deletedBy;
    map["DeletedDateTime"] = _deletedDateTime;
    return map;
  }

}

class ResponseDeletePlace {
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

  ResponseDeletePlace({
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

  ResponseDeletePlace.fromJson(dynamic json) {
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