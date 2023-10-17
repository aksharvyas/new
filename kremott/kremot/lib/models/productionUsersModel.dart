import 'dart:convert';
/// value : {"data":{"id":3,"firstName":"ProductionUser","lastName":"","mobileNo":"7777777777","contryCode":"IN","password":null,"emailId":"productionuser@g.com","roleId":3},"tokenViewModel":{"jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYXNlV2ViQXBpU3ViamVjdCIsImp0aSI6ImE5ZTUyMTA0LWNmZDYtNDRhNC1iYWQ1LTdjNGJjZGQyOWFjOSIsImlhdCI6IjI1LTA3LTIwMjMgMDY6MjI6MDgiLCJNb2JpbGVOdW1iZXIiOiI3Nzc3Nzc3Nzc3IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUHJvZHVjdGlvbiIsImV4cCI6MTY5MDg3MDkyOCwiaXNzIjoiVGVzdC5jb20iLCJhdWQiOiJiYXNlV2ViQXBpYUF1ZGllbmNlIn0.uZA18TN5XFRioLjDgurQosY-HVzBkQivaCgN1uQkoWw","jwtExpiration":"2023-08-01T11:52:08.0154873+05:30","refereshToken":"rNDOWqQID0lc52o+i39xsKwhPdRz1/RoUAJix7ar068=","refereshExpiration":"2023-08-09T11:52:08.0154922+05:30"},"meta":{"message":"success","status":"success","code":1}}
/// statusCode : 200

ProductionUsersModel productionUsersModelFromJson(String str) => ProductionUsersModel.fromJson(json.decode(str));
String productionUsersModelToJson(ProductionUsersModel data) => json.encode(data.toJson());
class ProductionUsersModel {
  ProductionUsersModel({
      Value? value, 
      num? statusCode,}){
    _value = value;
    _statusCode = statusCode;
}

  ProductionUsersModel.fromJson(dynamic json) {
    _value = json['value'] != null ? Value.fromJson(json['value']) : null;
    _statusCode = json['statusCode'];
  }
  Value? _value;
  num? _statusCode;
ProductionUsersModel copyWith({  Value? value,
  num? statusCode,
}) => ProductionUsersModel(  value: value ?? _value,
  statusCode: statusCode ?? _statusCode,
);
  Value? get value => _value;
  num? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.toJson();
    }
    map['statusCode'] = _statusCode;
    return map;
  }

}

/// data : {"id":3,"firstName":"ProductionUser","lastName":"","mobileNo":"7777777777","contryCode":"IN","password":null,"emailId":"productionuser@g.com","roleId":3}
/// tokenViewModel : {"jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYXNlV2ViQXBpU3ViamVjdCIsImp0aSI6ImE5ZTUyMTA0LWNmZDYtNDRhNC1iYWQ1LTdjNGJjZGQyOWFjOSIsImlhdCI6IjI1LTA3LTIwMjMgMDY6MjI6MDgiLCJNb2JpbGVOdW1iZXIiOiI3Nzc3Nzc3Nzc3IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUHJvZHVjdGlvbiIsImV4cCI6MTY5MDg3MDkyOCwiaXNzIjoiVGVzdC5jb20iLCJhdWQiOiJiYXNlV2ViQXBpYUF1ZGllbmNlIn0.uZA18TN5XFRioLjDgurQosY-HVzBkQivaCgN1uQkoWw","jwtExpiration":"2023-08-01T11:52:08.0154873+05:30","refereshToken":"rNDOWqQID0lc52o+i39xsKwhPdRz1/RoUAJix7ar068=","refereshExpiration":"2023-08-09T11:52:08.0154922+05:30"}
/// meta : {"message":"success","status":"success","code":1}

Value valueFromJson(String str) => Value.fromJson(json.decode(str));
String valueToJson(Value data) => json.encode(data.toJson());
class Value {
  Value({
      Data? data, 
      TokenViewModel? tokenViewModel, 
      Meta? meta,}){
    _data = data;
    _tokenViewModel = tokenViewModel;
    _meta = meta;
}

  Value.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _tokenViewModel = json['tokenViewModel'] != null ? TokenViewModel.fromJson(json['tokenViewModel']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  Data? _data;
  TokenViewModel? _tokenViewModel;
  Meta? _meta;
Value copyWith({  Data? data,
  TokenViewModel? tokenViewModel,
  Meta? meta,
}) => Value(  data: data ?? _data,
  tokenViewModel: tokenViewModel ?? _tokenViewModel,
  meta: meta ?? _meta,
);
  Data? get data => _data;
  TokenViewModel? get tokenViewModel => _tokenViewModel;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_tokenViewModel != null) {
      map['tokenViewModel'] = _tokenViewModel?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "success"
/// status : "success"
/// code : 1

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

/// jwtToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYXNlV2ViQXBpU3ViamVjdCIsImp0aSI6ImE5ZTUyMTA0LWNmZDYtNDRhNC1iYWQ1LTdjNGJjZGQyOWFjOSIsImlhdCI6IjI1LTA3LTIwMjMgMDY6MjI6MDgiLCJNb2JpbGVOdW1iZXIiOiI3Nzc3Nzc3Nzc3IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUHJvZHVjdGlvbiIsImV4cCI6MTY5MDg3MDkyOCwiaXNzIjoiVGVzdC5jb20iLCJhdWQiOiJiYXNlV2ViQXBpYUF1ZGllbmNlIn0.uZA18TN5XFRioLjDgurQosY-HVzBkQivaCgN1uQkoWw"
/// jwtExpiration : "2023-08-01T11:52:08.0154873+05:30"
/// refereshToken : "rNDOWqQID0lc52o+i39xsKwhPdRz1/RoUAJix7ar068="
/// refereshExpiration : "2023-08-09T11:52:08.0154922+05:30"

TokenViewModel tokenViewModelFromJson(String str) => TokenViewModel.fromJson(json.decode(str));
String tokenViewModelToJson(TokenViewModel data) => json.encode(data.toJson());
class TokenViewModel {
  TokenViewModel({
      String? jwtToken, 
      String? jwtExpiration, 
      String? refereshToken, 
      String? refereshExpiration,}){
    _jwtToken = jwtToken;
    _jwtExpiration = jwtExpiration;
    _refereshToken = refereshToken;
    _refereshExpiration = refereshExpiration;
}

  TokenViewModel.fromJson(dynamic json) {
    _jwtToken = json['jwtToken'];
    _jwtExpiration = json['jwtExpiration'];
    _refereshToken = json['refereshToken'];
    _refereshExpiration = json['refereshExpiration'];
  }
  String? _jwtToken;
  String? _jwtExpiration;
  String? _refereshToken;
  String? _refereshExpiration;
TokenViewModel copyWith({  String? jwtToken,
  String? jwtExpiration,
  String? refereshToken,
  String? refereshExpiration,
}) => TokenViewModel(  jwtToken: jwtToken ?? _jwtToken,
  jwtExpiration: jwtExpiration ?? _jwtExpiration,
  refereshToken: refereshToken ?? _refereshToken,
  refereshExpiration: refereshExpiration ?? _refereshExpiration,
);
  String? get jwtToken => _jwtToken;
  String? get jwtExpiration => _jwtExpiration;
  String? get refereshToken => _refereshToken;
  String? get refereshExpiration => _refereshExpiration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jwtToken'] = _jwtToken;
    map['jwtExpiration'] = _jwtExpiration;
    map['refereshToken'] = _refereshToken;
    map['refereshExpiration'] = _refereshExpiration;
    return map;
  }

}

/// id : 3
/// firstName : "ProductionUser"
/// lastName : ""
/// mobileNo : "7777777777"
/// contryCode : "IN"
/// password : null
/// emailId : "productionuser@g.com"
/// roleId : 3

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? mobileNo, 
      String? contryCode, 
      dynamic password, 
      String? emailId, 
      num? roleId,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _mobileNo = mobileNo;
    _contryCode = contryCode;
    _password = password;
    _emailId = emailId;
    _roleId = roleId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _mobileNo = json['mobileNo'];
    _contryCode = json['contryCode'];
    _password = json['password'];
    _emailId = json['emailId'];
    _roleId = json['roleId'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _mobileNo;
  String? _contryCode;
  dynamic _password;
  String? _emailId;
  num? _roleId;
Data copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? mobileNo,
  String? contryCode,
  dynamic password,
  String? emailId,
  num? roleId,
}) => Data(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  mobileNo: mobileNo ?? _mobileNo,
  contryCode: contryCode ?? _contryCode,
  password: password ?? _password,
  emailId: emailId ?? _emailId,
  roleId: roleId ?? _roleId,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get mobileNo => _mobileNo;
  String? get contryCode => _contryCode;
  dynamic get password => _password;
  String? get emailId => _emailId;
  num? get roleId => _roleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['mobileNo'] = _mobileNo;
    map['contryCode'] = _contryCode;
    map['password'] = _password;
    map['emailId'] = _emailId;
    map['roleId'] = _roleId;
    return map;
  }

}