/// applicationId : "123"
/// isOwner : false
/// isAdditionalAdmin : false
/// isAdditionalUser : true
/// createdDateTime : "2022-12-09T12:37:00.921Z"
/// createdBy : "60318d62-51e1-44f4-a60f-05cd38346cc2"
/// appUser : [{"appUserId":"26ee5b88-bd36-4e53-aa4b-f34a994e020f"},{"appUserId":"8d18eee5-a172-4ecb-bbde-ffec6236cd44"}]
/// room : [{"roomId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a"},{"roomId":"3273a4b2-b327-4208-bc47-bc1fb1150e29"}]

class RequestShareMultipleRooms {
  String? _applicationId;
  bool? _isOwner;
  bool? _isAdditionalAdmin;
  bool? _isAdditionalUser;
  String? _createdDateTime;
  String? _createdBy;
  List<AppUserRoom>? _appUser;
  List<Room>? _room;

  String? get applicationId => _applicationId;
  bool? get isOwner => _isOwner;
  bool? get isAdditionalAdmin => _isAdditionalAdmin;
  bool? get isAdditionalUser => _isAdditionalUser;
  String? get createdDateTime => _createdDateTime;
  String? get createdBy => _createdBy;
  List<AppUserRoom>? get appUser => _appUser;
  List<Room>? get room => _room;

  RequestShareMultipleRooms({
    String? applicationId,
    bool? isOwner,
    bool? isAdditionalAdmin,
    bool? isAdditionalUser,
    String? createdDateTime,
    String? createdBy,
    List<AppUserRoom>? appUser,
    List<Room>? room}){
    _applicationId = applicationId;
    _isOwner = isOwner;
    _isAdditionalAdmin = isAdditionalAdmin;
    _isAdditionalUser = isAdditionalUser;
    _createdDateTime = createdDateTime;
    _createdBy = createdBy;
    _appUser = appUser;
    _room = room;
  }

  RequestShareMultipleRooms.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _isOwner = json["isOwner"];
    _isAdditionalAdmin = json["isAdditionalAdmin"];
    _isAdditionalUser = json["isAdditionalUser"];
    _createdDateTime = json["createdDateTime"];
    _createdBy = json["createdBy"];
    if (json["appUser"] != null) {
      _appUser = [];
      json["appUser"].forEach((v) {
        _appUser?.add(AppUserRoom.fromJson(v));
      });
    }
    if (json["room"] != null) {
      _room = [];
      json["room"].forEach((v) {
        _room?.add(Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["isOwner"] = _isOwner;
    map["isAdditionalAdmin"] = _isAdditionalAdmin;
    map["isAdditionalUser"] = _isAdditionalUser;
    map["createdDateTime"] = _createdDateTime;
    map["createdBy"] = _createdBy;
    if (_appUser != null) {
      map["appUser"] = _appUser?.map((v) => v.toJson()).toList();
    }
    if (_room != null) {
      map["room"] = _room?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// roomId : "ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a"

class Room {
  String? _roomId;

  String? get roomId => _roomId;

  Room({
    String? roomId}){
    _roomId = roomId;
  }

  Room.fromJson(dynamic json) {
    _roomId = json["roomId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["roomId"] = _roomId;
    return map;
  }

}

/// appUserId : "26ee5b88-bd36-4e53-aa4b-f34a994e020f"

class AppUserRoom {
  String? _appUserId;

  String? get appUserId => _appUserId;

  AppUserRoom({
    String? appUserId}){
    _appUserId = appUserId;
  }

  AppUserRoom.fromJson(dynamic json) {
    _appUserId = json["appUserId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["appUserId"] = _appUserId;
    return map;
  }

}

/// value : {"appUserAccessPermission":[{"id":117,"appUserId":"26ee5b88-bd36-4e53-aa4b-f34a994e020f","homeId":null,"roomId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"},{"id":118,"appUserId":"26ee5b88-bd36-4e53-aa4b-f34a994e020f","homeId":null,"roomId":"3273a4b2-b327-4208-bc47-bc1fb1150e29","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"},{"id":119,"appUserId":"8d18eee5-a172-4ecb-bbde-ffec6236cd44","homeId":null,"roomId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"},{"id":120,"appUserId":"8d18eee5-a172-4ecb-bbde-ffec6236cd44","homeId":null,"roomId":"3273a4b2-b327-4208-bc47-bc1fb1150e29","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"}],"meta":{"message":"Permission given successfully.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseShareMultipleRooms {
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

  ResponseShareMultipleRooms({
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

  ResponseShareMultipleRooms.fromJson(dynamic json) {
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

/// appUserAccessPermission : [{"id":117,"appUserId":"26ee5b88-bd36-4e53-aa4b-f34a994e020f","homeId":null,"roomId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"},{"id":118,"appUserId":"26ee5b88-bd36-4e53-aa4b-f34a994e020f","homeId":null,"roomId":"3273a4b2-b327-4208-bc47-bc1fb1150e29","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"},{"id":119,"appUserId":"8d18eee5-a172-4ecb-bbde-ffec6236cd44","homeId":null,"roomId":"ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"},{"id":120,"appUserId":"8d18eee5-a172-4ecb-bbde-ffec6236cd44","homeId":null,"roomId":"3273a4b2-b327-4208-bc47-bc1fb1150e29","isOwner":false,"isAdditionalAdmin":false,"isAdditionalUser":true,"createdDateTime":"2022-12-09T12:37:00","createdBy":"60318d62-51e1-44f4-a60f-05cd38346cc2"}]
/// meta : {"message":"Permission given successfully.","status":"success","code":1}

class Value {
  List<AppUserAccessPermission>? _appUserAccessPermission;
  Meta? _meta;

  List<AppUserAccessPermission>? get appUserAccessPermission => _appUserAccessPermission;
  Meta? get meta => _meta;

  Value({
    List<AppUserAccessPermission>? appUserAccessPermission,
    Meta? meta}){
    _appUserAccessPermission = appUserAccessPermission;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["appUserAccessPermission"] != null) {
      _appUserAccessPermission = [];
      json["appUserAccessPermission"].forEach((v) {
        _appUserAccessPermission?.add(AppUserAccessPermission.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_appUserAccessPermission != null) {
      map["appUserAccessPermission"] = _appUserAccessPermission?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "Permission given successfully."
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

/// id : 117
/// appUserId : "26ee5b88-bd36-4e53-aa4b-f34a994e020f"
/// homeId : null
/// roomId : "ad1c93ff-ce8f-4b9b-88dc-8e4b74a9017a"
/// isOwner : false
/// isAdditionalAdmin : false
/// isAdditionalUser : true
/// createdDateTime : "2022-12-09T12:37:00"
/// createdBy : "60318d62-51e1-44f4-a60f-05cd38346cc2"

class AppUserAccessPermission {
  int? _id;
  String? _appUserId;
  dynamic? _homeId;
  String? _roomId;
  bool? _isOwner;
  bool? _isAdditionalAdmin;
  bool? _isAdditionalUser;
  String? _createdDateTime;
  String? _createdBy;

  int? get id => _id;
  String? get appUserId => _appUserId;
  dynamic? get homeId => _homeId;
  String? get roomId => _roomId;
  bool? get isOwner => _isOwner;
  bool? get isAdditionalAdmin => _isAdditionalAdmin;
  bool? get isAdditionalUser => _isAdditionalUser;
  String? get createdDateTime => _createdDateTime;
  String? get createdBy => _createdBy;

  AppUserAccessPermission({
    int? id,
    String? appUserId,
    dynamic? homeId,
    String? roomId,
    bool? isOwner,
    bool? isAdditionalAdmin,
    bool? isAdditionalUser,
    String? createdDateTime,
    String? createdBy}){
    _id = id;
    _appUserId = appUserId;
    _homeId = homeId;
    _roomId = roomId;
    _isOwner = isOwner;
    _isAdditionalAdmin = isAdditionalAdmin;
    _isAdditionalUser = isAdditionalUser;
    _createdDateTime = createdDateTime;
    _createdBy = createdBy;
  }

  AppUserAccessPermission.fromJson(dynamic json) {
    _id = json["id"];
    _appUserId = json["appUserId"];
    _homeId = json["homeId"];
    _roomId = json["roomId"];
    _isOwner = json["isOwner"];
    _isAdditionalAdmin = json["isAdditionalAdmin"];
    _isAdditionalUser = json["isAdditionalUser"];
    _createdDateTime = json["createdDateTime"];
    _createdBy = json["createdBy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["appUserId"] = _appUserId;
    map["homeId"] = _homeId;
    map["roomId"] = _roomId;
    map["isOwner"] = _isOwner;
    map["isAdditionalAdmin"] = _isAdditionalAdmin;
    map["isAdditionalUser"] = _isAdditionalUser;
    map["createdDateTime"] = _createdDateTime;
    map["createdBy"] = _createdBy;
    return map;
  }

}