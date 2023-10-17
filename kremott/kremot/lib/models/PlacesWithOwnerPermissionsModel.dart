/// applicationId : "string"
/// appuserId : "7e8f46f6-4e62-4250-92ad-8ceffbf91903"

class RequestPlacesWithOwnerPermissions {
  String? _applicationId;
  String? _appuserId;

  String? get applicationId => _applicationId;
  String? get appuserId => _appuserId;

  RequestPlacesWithOwnerPermissions({
    String? applicationId,
    String? appuserId}){
    _applicationId = applicationId;
    _appuserId = appuserId;
  }

  RequestPlacesWithOwnerPermissions.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _appuserId = json["appuserId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["appuserId"] = _appuserId;
    return map;
  }

}

/// value : {"appUserAccessPermissions":[{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e9ed268e-0c93-4407-8ca0-2ea424b7d611","isOwner":true,"isAdditionalAdmin":false,"isAdditionalUser":false,"createdDateTime":"2022-12-07T13:51:24","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":104}],"meta":{"message":"success.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponsePlacesWithOwnerPermissions {
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

  ResponsePlacesWithOwnerPermissions({
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

  ResponsePlacesWithOwnerPermissions.fromJson(dynamic json) {
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

/// appUserAccessPermissions : [{"appUserId":"7e8f46f6-4e62-4250-92ad-8ceffbf91903","homeName":"Home1","homeId":"e9ed268e-0c93-4407-8ca0-2ea424b7d611","isOwner":true,"isAdditionalAdmin":false,"isAdditionalUser":false,"createdDateTime":"2022-12-07T13:51:24","permissionGivenBy":"08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4","permissionId":104}]
/// meta : {"message":"success.","status":"success","code":1}

class Value {
  List<AppUserAccessOwnerPermissions>? _appUserAccessPermissions;
  Meta? _meta;

  List<AppUserAccessOwnerPermissions>? get appUserAccessPermissions => _appUserAccessPermissions;
  Meta? get meta => _meta;

  Value({
    List<AppUserAccessOwnerPermissions>? appUserAccessPermissions,
    Meta? meta}){
    _appUserAccessPermissions = appUserAccessPermissions;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["appUserAccessPermissions"] != null) {
      _appUserAccessPermissions = [];
      json["appUserAccessPermissions"].forEach((v) {
        _appUserAccessPermissions?.add(AppUserAccessOwnerPermissions.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_appUserAccessPermissions != null) {
      map["appUserAccessPermissions"] = _appUserAccessPermissions?.map((v) => v.toJson()).toList();
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

/// appUserId : "7e8f46f6-4e62-4250-92ad-8ceffbf91903"
/// homeName : "Home1"
/// homeId : "e9ed268e-0c93-4407-8ca0-2ea424b7d611"
/// isOwner : true
/// isAdditionalAdmin : false
/// isAdditionalUser : false
/// createdDateTime : "2022-12-07T13:51:24"
/// permissionGivenBy : "08a6bde6-2fc4-47c7-a141-d76dbcb4c4b4"
/// permissionId : 104

class AppUserAccessOwnerPermissions {
  String? _appUserId;
  String? _homeName;
  String? _homeId;
  bool? _isOwner;
  bool? _isAdditionalAdmin;
  bool? _isAdditionalUser;
  String? _createdDateTime;
  String? _permissionGivenBy;
  int? _permissionId;
  bool? _isSelected = false;

  String? get appUserId => _appUserId;
  String? get homeName => _homeName;
  String? get homeId => _homeId;
  bool? get isOwner => _isOwner;
  bool? get isAdditionalAdmin => _isAdditionalAdmin;
  bool? get isAdditionalUser => _isAdditionalUser;
  String? get createdDateTime => _createdDateTime;
  String? get permissionGivenBy => _permissionGivenBy;
  int? get permissionId => _permissionId;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  AppUserAccessOwnerPermissions({
    String? appUserId,
    String? homeName,
    String? homeId,
    bool? isOwner,
    bool? isAdditionalAdmin,
    bool? isAdditionalUser,
    String? createdDateTime,
    String? permissionGivenBy,
    int? permissionId}){
    _appUserId = appUserId;
    _homeName = homeName;
    _homeId = homeId;
    _isOwner = isOwner;
    _isAdditionalAdmin = isAdditionalAdmin;
    _isAdditionalUser = isAdditionalUser;
    _createdDateTime = createdDateTime;
    _permissionGivenBy = permissionGivenBy;
    _permissionId = permissionId;
  }

  AppUserAccessOwnerPermissions.fromJson(dynamic json) {
    _appUserId = json["appUserId"];
    _homeName = json["homeName"];
    _homeId = json["homeId"];
    _isOwner = json["isOwner"];
    _isAdditionalAdmin = json["isAdditionalAdmin"];
    _isAdditionalUser = json["isAdditionalUser"];
    _createdDateTime = json["createdDateTime"];
    _permissionGivenBy = json["permissionGivenBy"];
    _permissionId = json["permissionId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["appUserId"] = _appUserId;
    map["homeName"] = _homeName;
    map["homeId"] = _homeId;
    map["isOwner"] = _isOwner;
    map["isAdditionalAdmin"] = _isAdditionalAdmin;
    map["isAdditionalUser"] = _isAdditionalUser;
    map["createdDateTime"] = _createdDateTime;
    map["permissionGivenBy"] = _permissionGivenBy;
    map["permissionId"] = _permissionId;
    return map;
  }

}