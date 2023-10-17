/// mobileNo : "123"
/// contryCode : "123"
/// applicationId : "string"

class RequestGetUserByMobileNo {
  String? _mobileNo;
  String? _contryCode;
  String? _applicationId;

  String? get mobileNo => _mobileNo;
  String? get contryCode => _contryCode;
  String? get applicationId => _applicationId;

  RequestGetUserByMobileNo({
    String? mobileNo,
    String? contryCode,
    String? applicationId}){
    _mobileNo = mobileNo;
    _contryCode = contryCode;
    _applicationId = applicationId;
  }

  RequestGetUserByMobileNo.fromJson(dynamic json) {
    _mobileNo = json["mobileNo"];
    _contryCode = json["contryCode"];
    _applicationId = json["applicationId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["mobileNo"] = _mobileNo;
    map["contryCode"] = _contryCode;
    map["applicationId"] = _applicationId;
    return map;
  }

}

/// value : {"meta":{"message":"success.","status":"success","code":1},"vm":{"id":"2b458ff9-d73b-4bbe-b8ef-0d10af9898fa","firstName":"Fabc3","lastName":"Labc2","mobileNo":"123","contryCode":"123"}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseGetUserByMobileNo {
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

  ResponseGetUserByMobileNo({
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

  ResponseGetUserByMobileNo.fromJson(dynamic json) {
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

/// meta : {"message":"success.","status":"success","code":1}
/// vm : {"id":"2b458ff9-d73b-4bbe-b8ef-0d10af9898fa","firstName":"Fabc3","lastName":"Labc2","mobileNo":"123","contryCode":"123"}

class Value {
  Meta? _meta;
  Vm? _vm;

  Meta? get meta => _meta;
  Vm? get vm => _vm;

  Value({
    Meta? meta,
    Vm? vm}){
    _meta = meta;
    _vm = vm;
  }

  Value.fromJson(dynamic json) {
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
    _vm = json["vm"] != null ? Vm.fromJson(json["vm"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    if (_vm != null) {
      map["vm"] = _vm?.toJson();
    }
    return map;
  }

}

/// id : "2b458ff9-d73b-4bbe-b8ef-0d10af9898fa"
/// firstName : "Fabc3"
/// lastName : "Labc2"
/// mobileNo : "123"
/// contryCode : "123"

class Vm {
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _mobileNo;
  String? _contryCode;

  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get mobileNo => _mobileNo;
  String? get contryCode => _contryCode;

  Vm({
    String? id,
    String? firstName,
    String? lastName,
    String? mobileNo,
    String? contryCode}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _mobileNo = mobileNo;
    _contryCode = contryCode;
  }

  Vm.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _mobileNo = json["mobileNo"];
    _contryCode = json["contryCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["mobileNo"] = _mobileNo;
    map["contryCode"] = _contryCode;
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