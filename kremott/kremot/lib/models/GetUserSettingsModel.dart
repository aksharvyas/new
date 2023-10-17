class RequestGetUserSettings {
  String? _applicationId;
  int? _id;

  String? get applicationId => _applicationId;
  int? get id => _id;

  RequestGetUserSettings({
    String? applicationId,
    int? id}){
    _applicationId = applicationId;
    _id = id;
  }

  RequestGetUserSettings.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["id"] = _id;
    return map;
  }

}

class ResponseGetUserSettings {
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

  ResponseGetUserSettings({
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

  ResponseGetUserSettings.fromJson(dynamic json) {
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

class Vm {
  dynamic? _applicationId;
  String? _appUserId;
  int? _themeId;
  bool? _vibration;
  bool? _notification;
  bool? _tapSound;

  dynamic? get applicationId => _applicationId;
  String? get appUserId => _appUserId;
  int? get themeId => _themeId;
  bool? get vibration => _vibration;
  bool? get notification => _notification;
  bool? get tapSound => _tapSound;

  Vm({
    dynamic? applicationId,
    String? appUserId,
    int? themeId,
    bool? vibration,
    bool? notification,
    bool? tapSound}){
    _applicationId = applicationId;
    _appUserId = appUserId;
    _themeId = themeId;
    _vibration = vibration;
    _notification = notification;
    _tapSound = tapSound;
  }

  Vm.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _appUserId = json["appUserId"];
    _themeId = json["themeId"];
    _vibration = json["vibration"];
    _notification = json["notification"];
    _tapSound = json["tapSound"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["appUserId"] = _appUserId;
    map["themeId"] = _themeId;
    map["vibration"] = _vibration;
    map["notification"] = _notification;
    map["tapSound"] = _tapSound;
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