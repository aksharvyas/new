import 'dart:convert';
/// value : {"meta":{"message":"HomeNetworkString already existing.","status":"fail","code":0}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

AddHomeNetworkStringResponseModel addHomeNetworkStringResponseModelFromJson(String str) => AddHomeNetworkStringResponseModel.fromJson(json.decode(str));
String addHomeNetworkStringResponseModelToJson(AddHomeNetworkStringResponseModel data) => json.encode(data.toJson());
class AddHomeNetworkStringResponseModel {
  AddHomeNetworkStringResponseModel({
      Value? value, 
      List<dynamic>? formatters, 
      List<dynamic>? contentTypes, 
      dynamic declaredType, 
      num? statusCode,}){
    _value = value;
    _formatters = formatters;
    _contentTypes = contentTypes;
    _declaredType = declaredType;
    _statusCode = statusCode;
}

  AddHomeNetworkStringResponseModel.fromJson(dynamic json) {
    _value = json['value'] != null ? Value.fromJson(json['value']) : null;

    _declaredType = json['declaredType'];
    _statusCode = json['statusCode'];
  }
  Value? _value;
  List<dynamic>? _formatters;
  List<dynamic>? _contentTypes;
  dynamic _declaredType;
  num? _statusCode;
AddHomeNetworkStringResponseModel copyWith({  Value? value,
  List<dynamic>? formatters,
  List<dynamic>? contentTypes,
  dynamic declaredType,
  num? statusCode,
}) => AddHomeNetworkStringResponseModel(  value: value ?? _value,
  formatters: formatters ?? _formatters,
  contentTypes: contentTypes ?? _contentTypes,
  declaredType: declaredType ?? _declaredType,
  statusCode: statusCode ?? _statusCode,
);
  Value? get value => _value;
  List<dynamic>? get formatters => _formatters;
  List<dynamic>? get contentTypes => _contentTypes;
  dynamic get declaredType => _declaredType;
  num? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.toJson();
    }
    if (_formatters != null) {
      map['formatters'] = _formatters?.map((v) => v.toJson()).toList();
    }
    if (_contentTypes != null) {
      map['contentTypes'] = _contentTypes?.map((v) => v.toJson()).toList();
    }
    map['declaredType'] = _declaredType;
    map['statusCode'] = _statusCode;
    return map;
  }

}

/// meta : {"message":"HomeNetworkString already existing.","status":"fail","code":0}

Value valueFromJson(String str) => Value.fromJson(json.decode(str));
String valueToJson(Value data) => json.encode(data.toJson());
class Value {
  Value({
      Meta? meta,}){
    _meta = meta;
}

  Value.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  Meta? _meta;
Value copyWith({  Meta? meta,
}) => Value(  meta: meta ?? _meta,
);
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "HomeNetworkString already existing."
/// status : "fail"
/// code : 0

Meta metaFromJson(String str) => Meta.fromJson(json.decode(str));
String metaToJson(Meta data) => json.encode(data.toJson());
class Meta {
  Meta({
      String? message, 
      String? status, 
      num? code,}){
    _message = message;
    _status = status;
    _code = code;
}

  Meta.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _code = json['code'];
  }
  String? _message;
  String? _status;
  num? _code;
Meta copyWith({  String? message,
  String? status,
  num? code,
}) => Meta(  message: message ?? _message,
  status: status ?? _status,
  code: code ?? _code,
);
  String? get message => _message;
  String? get status => _status;
  num? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    map['code'] = _code;
    return map;
  }

}