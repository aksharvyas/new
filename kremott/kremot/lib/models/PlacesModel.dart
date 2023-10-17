class ResponsePlaces {
  Value? value;
  List<void>? formatters;
  List<void>? contentTypes;
  dynamic declaredType;
  int? statusCode;

  ResponsePlaces(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponsePlaces.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ?  Value.fromJson(json['value']) : null;
    // if (json['formatters'] != null) {
    //   formatters = <Null>[];
    //   json['formatters'].forEach((v) {
    //     formatters!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['contentTypes'] != null) {
    //   contentTypes = <Null>[];
    //   json['contentTypes'].forEach((v) {
    //     contentTypes!.add(new Null.fromJson(v));
    //   });
    // }
    declaredType = json['declaredType'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    // if (this.formatters != null) {
    //   data['formatters'] = this.formatters!.map((v) => v.toJson()).toList();
    // }
    // if (this.contentTypes != null) {
    //   data['contentTypes'] = this.contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = declaredType;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Value {
  List<AppUserAccessPermissions>? _appUserAccessPermissions;
  Meta? _meta;

  List<AppUserAccessPermissions>? get appUserAccessPermissions => _appUserAccessPermissions;
  Meta? get meta => _meta;

  Value({
    List<AppUserAccessPermissions>? appUserAccessPermissions,
    Meta? meta}){
    _appUserAccessPermissions = appUserAccessPermissions;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["appUserAccessPermissions"] != null) {
      _appUserAccessPermissions = [];
      json["appUserAccessPermissions"].forEach((v) {
        _appUserAccessPermissions?.add(AppUserAccessPermissions.fromJson(v));
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

class AppUserAccessPermissions {
  String? _appUserId;
  String? _homeName;
  String? _homeId;
  bool? _isOwner;
  bool? _isAdditionalAdmin;
  bool? _isAdditionalUser;
  String? _createdDateTime;
  String? _permissionGivenBy;
  bool? _isSelected = false;

  String? get appUserId => _appUserId;
  String? get homeName => _homeName;
  String? get homeId => _homeId;
  bool? get isOwner => _isOwner;
  bool? get isAdditionalAdmin => _isAdditionalAdmin;
  bool? get isAdditionalUser => _isAdditionalUser;
  String? get createdDateTime => _createdDateTime;
  String? get permissionGivenBy => _permissionGivenBy;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  AppUserAccessPermissions({
    String? appUserId,
    String? homeName,
    String? homeId,
    bool? isOwner,
    bool? isAdditionalAdmin,
    bool? isAdditionalUser,
    String? createdDateTime,
    String? permissionGivenBy,
   }){
    _appUserId = appUserId;
    _homeName = homeName;
    _homeId = homeId;
    _isOwner = isOwner;
    _isAdditionalAdmin = isAdditionalAdmin;
    _isAdditionalUser = isAdditionalUser;
    _createdDateTime = createdDateTime;
    _permissionGivenBy = permissionGivenBy;
  }

  AppUserAccessPermissions.fromJson(dynamic json) {
    _appUserId = json["appUserId"];
    _homeName = json["homeName"];
    _homeId = json["homeId"];
    _isOwner = json["isOwner"];
    _isAdditionalAdmin = json["isAdditionalAdmin"];
    _isAdditionalUser = json["isAdditionalUser"];
    _createdDateTime = json["createdDateTime"];
    _permissionGivenBy = json["permissionGivenBy"];
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
    return map;
  }

}

class RequestPlaces {
  String? _applicationId;
  String? _appUserId;

  String? get applicationId => _applicationId;
  String? get appUserId => _appUserId;

  RequestPlaces({
    String? applicationId,
    String? appUserId,
    }){
    _applicationId = applicationId;
    _appUserId = appUserId;
  }

  RequestPlaces.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _appUserId = json["appUserId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["appUserId"] = _appUserId;
    return map;
  }

}

