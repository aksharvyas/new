/// applicationId : "string"
/// roomId : "583991bd-389c-4adc-aa96-dbfea4d00064"

class RequestDevicesWithGroup {
  String? _applicationId;
  String? _roomId;

  String? get applicationId => _applicationId;
  String? get roomId => _roomId;

  RequestDevicesWithGroup({
    String? applicationId,
    String? roomId}){
    _applicationId = applicationId;
    _roomId = roomId;
  }

  RequestDevicesWithGroup.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _roomId = json["roomId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["roomId"] = _roomId;
    return map;
  }

}

/// value : {"roomDetails":[{"id":80,"deviceSwitches":[{"id":55,"switchDisplayName":"L1","switchName":"L1"},{"id":56,"switchDisplayName":"L2","switchName":"L2"},{"id":57,"switchDisplayName":"L3","switchName":"L3"},{"id":58,"switchDisplayName":"L4","switchName":"L4"}]},{"id":81,"deviceSwitches":[{"id":59,"switchDisplayName":"L5","switchName":"L5"},{"id":60,"switchDisplayName":"L6","switchName":"L6"},{"id":61,"switchDisplayName":"F1","switchName":"F1"},{"id":62,"switchDisplayName":"F2","switchName":"F2"},{"id":60,"switchDisplayName":"L6","switchName":"L6"},{"id":61,"switchDisplayName":"F1","switchName":"F1"},{"id":62,"switchDisplayName":"F2","switchName":"F2"},{"id":61,"switchDisplayName":"F1","switchName":"F1"},{"id":62,"switchDisplayName":"F2","switchName":"F2"},{"id":62,"switchDisplayName":"F2","switchName":"F2"}]}],"meta":{"message":"success","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseDevicesWithGroup {
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

  ResponseDevicesWithGroup({
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

  ResponseDevicesWithGroup.fromJson(dynamic json) {
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

/// roomDetails : [{"id":80,"deviceSwitches":[{"id":55,"switchDisplayName":"L1","switchName":"L1"},{"id":56,"switchDisplayName":"L2","switchName":"L2"},{"id":57,"switchDisplayName":"L3","switchName":"L3"},{"id":58,"switchDisplayName":"L4","switchName":"L4"}]},{"id":81,"deviceSwitches":[{"id":59,"switchDisplayName":"L5","switchName":"L5"},{"id":60,"switchDisplayName":"L6","switchName":"L6"},{"id":61,"switchDisplayName":"F1","switchName":"F1"},{"id":62,"switchDisplayName":"F2","switchName":"F2"},{"id":60,"switchDisplayName":"L6","switchName":"L6"},{"id":61,"switchDisplayName":"F1","switchName":"F1"},{"id":62,"switchDisplayName":"F2","switchName":"F2"},{"id":61,"switchDisplayName":"F1","switchName":"F1"},{"id":62,"switchDisplayName":"F2","switchName":"F2"},{"id":62,"switchDisplayName":"F2","switchName":"F2"}]}]
/// meta : {"message":"success","status":"success","code":1}

class Value {
  List<RoomDetails>? _roomDetails;
  Meta? _meta;

  List<RoomDetails>? get roomDetails => _roomDetails;
  Meta? get meta => _meta;

  Value({
    List<RoomDetails>? roomDetails,
    Meta? meta}){
    _roomDetails = roomDetails;
    _meta = meta;
  }

  Value.fromJson(dynamic json) {
    if (json["roomDetails"] != null) {
      _roomDetails = [];
      json["roomDetails"].forEach((v) {
        _roomDetails?.add(RoomDetails.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_roomDetails != null) {
      map["roomDetails"] = _roomDetails?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "success"
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

/// id : 80
/// deviceSwitches : [{"id":55,"switchDisplayName":"L1","switchName":"L1"},{"id":56,"switchDisplayName":"L2","switchName":"L2"},{"id":57,"switchDisplayName":"L3","switchName":"L3"},{"id":58,"switchDisplayName":"L4","switchName":"L4"}]

class RoomDetails {
  int? _id;
  List<DeviceSwitches>? _deviceSwitches;
  bool _isSelected = false;

  int? get id => _id;
  List<DeviceSwitches>? get deviceSwitches => _deviceSwitches;

  set isSelected(bool val) => _isSelected = val;
  bool get isSelected => _isSelected;

  RoomDetails({
    int? id,
    List<DeviceSwitches>? deviceSwitches}){
    _id = id;
    _deviceSwitches = deviceSwitches;
  }

  RoomDetails.fromJson(dynamic json) {
    _id = json["id"];
    if (json["deviceSwitches"] != null) {
      _deviceSwitches = [];
      json["deviceSwitches"].forEach((v) {
        _deviceSwitches?.add(DeviceSwitches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_deviceSwitches != null) {
      map["deviceSwitches"] = _deviceSwitches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 55
/// switchDisplayName : "L1"
/// switchName : "L1"

class DeviceSwitches {
  int? _id;
  String? _switchDisplayName;
  String? _switchName;

  int? get id => _id;
  String? get switchDisplayName => _switchDisplayName;
  String? get switchName => _switchName;

  DeviceSwitches({
    int? id,
    String? switchDisplayName,
    String? switchName}){
    _id = id;
    _switchDisplayName = switchDisplayName;
    _switchName = switchName;
  }

  DeviceSwitches.fromJson(dynamic json) {
    _id = json["id"];
    _switchDisplayName = json["switchDisplayName"];
    _switchName = json["switchName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["switchDisplayName"] = _switchDisplayName;
    map["switchName"] = _switchName;
    return map;
  }

}