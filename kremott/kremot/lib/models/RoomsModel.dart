class ResponseRooms {
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

  ResponseRooms({
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

  ResponseRooms.fromJson(dynamic json) {
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
    // if (_formatters != null) {
    //   map["formatters"] = _formatters?.map((v) => v.toJson()).toList();
    // }
    // if (_contentTypes != null) {
    //   map["contentTypes"] = _contentTypes?.map((v) => v.toJson()).toList();
    // }
    map["declaredType"] = _declaredType;
    map["statusCode"] = _statusCode;
    return map;
  }

}

class Value {
  List<AppUserAccessPermissionsRoom>? _appUserAccessPermissionsRoom;
  Meta? _meta;

  List<AppUserAccessPermissionsRoom>? get appUserAccessPermissionsRoom => _appUserAccessPermissionsRoom;
  Meta? get meta => _meta;

  Value({
    List<AppUserAccessPermissionsRoom>? appUserAccessPermissionsRoom,
    Meta? meta}){
    _appUserAccessPermissionsRoom = appUserAccessPermissionsRoom;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["appUserAccessPermissionsRoom"] != null) {
      _appUserAccessPermissionsRoom = [];
      json["appUserAccessPermissionsRoom"].forEach((v) {
        _appUserAccessPermissionsRoom?.add(AppUserAccessPermissionsRoom.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_appUserAccessPermissionsRoom != null) {
      map["appUserAccessPermissionsRoom"] = _appUserAccessPermissionsRoom?.map((v) => v.toJson()).toList();
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

class AppUserAccessPermissionsRoom {
  String? _roomId;
  String? _roomName;
  bool? _isSelected = false;

  String? get roomId => _roomId;
  String? get roomName => _roomName;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  AppUserAccessPermissionsRoom({
    String? roomId,
    String? roomName}){
    _roomId = roomId;
    _roomName = roomName;
  }

  AppUserAccessPermissionsRoom.fromJson(dynamic json) {
    _roomId = json["roomId"];
    _roomName = json["roomName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["roomId"] = _roomId;
    map["roomName"] = _roomName;
    return map;
  }

}

class RequestRooms {
  String? _applicationId;
  String? _appuserId;
  String? _homeId;

  String? get applicationId => _applicationId;
  String? get appuserId => _appuserId;
  String? get homeId => _homeId;

  RequestRooms({
    String? applicationId,
    String? appuserId,
    String? homeId}){
    _applicationId = applicationId;
    _appuserId = appuserId;
    _homeId = homeId;
  }

  RequestRooms.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _appuserId = json["appuserId"];
    _homeId = json["HomeId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["appuserId"] = _appuserId;
    map["HomeId"] = _homeId;
    return map;
  }

}