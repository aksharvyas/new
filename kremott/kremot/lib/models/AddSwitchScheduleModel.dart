/// schedule : {"applicationId":"string","homeId":"3F1C3A93-4D2E-40A2-B013-07D33B3BC18D","roomId":"57E5EA2F-A985-4F09-97BD-19ED300B49AA","scheduleStartDate":"2023-01-04T07:25:58.416Z","scheduleTime":"2023-01-04T07:25:58.416Z","scheduleRepeat":0,"onEverySunday":true,"onEveryMonday":true,"onEveryTuesday":true,"onEveryWednesday":true,"onEveryThursday":true,"onEveryFriday":true,"onEverySaturday":true,"scheduleName":"11:31Schedule","sceneId":"3fa85f64-5717-4562-b3fc-2c963f66afa6","individualAction":true,"createdBy":"3fa85f64-5717-4562-b3fc-2c963f66afa6","createdDateTime":"2023-01-04T07:25:58.416Z"}
/// switches : [{"roomCmacDetailId":1,"onOffStatus":"on"}]

class RequestAddSwitchSchedule {
  AddSwitchSchedule? _schedule;
  List<AddSwitches>? _switches;

  AddSwitchSchedule? get schedule => _schedule;
  List<AddSwitches>? get switches => _switches;

  RequestAddSwitchSchedule({
    AddSwitchSchedule? schedule,
    List<AddSwitches>? switches}){
    _schedule = schedule;
    _switches = switches;
  }

  RequestAddSwitchSchedule.fromJson(dynamic json) {
    _schedule = json["schedule"] != null ? AddSwitchSchedule.fromJson(json["schedule"]) : null;
    if (json["switches"] != null) {
      _switches = [];
      json["switches"].forEach((v) {
        _switches?.add(AddSwitches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_schedule != null) {
      map["schedule"] = _schedule?.toJson();
    }
    if (_switches != null) {
      map["switches"] = _switches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// roomCmacDetailId : 1
/// onOffStatus : "on"

class AddSwitches {
  int? _roomCmacDetailId;
  String? _onOffStatus;

  int? get roomCmacDetailId => _roomCmacDetailId;
  String? get onOffStatus => _onOffStatus;

  AddSwitches({
    int? roomCmacDetailId,
    String? onOffStatus}){
    _roomCmacDetailId = roomCmacDetailId;
    _onOffStatus = onOffStatus;
  }

  AddSwitches.fromJson(dynamic json) {
    _roomCmacDetailId = json["roomCmacDetailId"];
    _onOffStatus = json["onOffStatus"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["roomCmacDetailId"] = _roomCmacDetailId;
    map["onOffStatus"] = _onOffStatus;
    return map;
  }

}

/// applicationId : "string"
/// homeId : "3F1C3A93-4D2E-40A2-B013-07D33B3BC18D"
/// roomId : "57E5EA2F-A985-4F09-97BD-19ED300B49AA"
/// scheduleStartDate : "2023-01-04T07:25:58.416Z"
/// scheduleTime : "2023-01-04T07:25:58.416Z"
/// scheduleRepeat : 0
/// onEverySunday : true
/// onEveryMonday : true
/// onEveryTuesday : true
/// onEveryWednesday : true
/// onEveryThursday : true
/// onEveryFriday : true
/// onEverySaturday : true
/// scheduleName : "11:31Schedule"
/// sceneId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// individualAction : true
/// createdBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// createdDateTime : "2023-01-04T07:25:58.416Z"

class AddSwitchSchedule {
  String? _applicationId;
  String? _homeId;
  String? _roomId;
  String? _scheduleStartDate;
  String? _scheduleTime;
  int? _scheduleRepeat;
  bool? _onEverySunday;
  bool? _onEveryMonday;
  bool? _onEveryTuesday;
  bool? _onEveryWednesday;
  bool? _onEveryThursday;
  bool? _onEveryFriday;
  bool? _onEverySaturday;
  String? _scheduleName;
  String? _sceneId;
  bool? _individualAction;
  String? _createdBy;
  String? _createdDateTime;

  String? get applicationId => _applicationId;
  String? get homeId => _homeId;
  String? get roomId => _roomId;
  String? get scheduleStartDate => _scheduleStartDate;
  String? get scheduleTime => _scheduleTime;
  int? get scheduleRepeat => _scheduleRepeat;
  bool? get onEverySunday => _onEverySunday;
  bool? get onEveryMonday => _onEveryMonday;
  bool? get onEveryTuesday => _onEveryTuesday;
  bool? get onEveryWednesday => _onEveryWednesday;
  bool? get onEveryThursday => _onEveryThursday;
  bool? get onEveryFriday => _onEveryFriday;
  bool? get onEverySaturday => _onEverySaturday;
  String? get scheduleName => _scheduleName;
  String? get sceneId => _sceneId;
  bool? get individualAction => _individualAction;
  String? get createdBy => _createdBy;
  String? get createdDateTime => _createdDateTime;

  AddSwitchSchedule({
    String? applicationId,
    String? homeId,
    String? roomId,
    String? scheduleStartDate,
    String? scheduleTime,
    int? scheduleRepeat,
    bool? onEverySunday,
    bool? onEveryMonday,
    bool? onEveryTuesday,
    bool? onEveryWednesday,
    bool? onEveryThursday,
    bool? onEveryFriday,
    bool? onEverySaturday,
    String? scheduleName,
    String? sceneId,
    bool? individualAction,
    String? createdBy,
    String? createdDateTime}){
    _applicationId = applicationId;
    _homeId = homeId;
    _roomId = roomId;
    _scheduleStartDate = scheduleStartDate;
    _scheduleTime = scheduleTime;
    _scheduleRepeat = scheduleRepeat;
    _onEverySunday = onEverySunday;
    _onEveryMonday = onEveryMonday;
    _onEveryTuesday = onEveryTuesday;
    _onEveryWednesday = onEveryWednesday;
    _onEveryThursday = onEveryThursday;
    _onEveryFriday = onEveryFriday;
    _onEverySaturday = onEverySaturday;
    _scheduleName = scheduleName;
    _sceneId = sceneId;
    _individualAction = individualAction;
    _createdBy = createdBy;
    _createdDateTime = createdDateTime;
  }

  AddSwitchSchedule.fromJson(dynamic json) {
    _applicationId = json["applicationId"];
    _homeId = json["homeId"];
    _roomId = json["roomId"];
    _scheduleStartDate = json["scheduleStartDate"];
    _scheduleTime = json["scheduleTime"];
    _scheduleRepeat = json["scheduleRepeat"];
    _onEverySunday = json["onEverySunday"];
    _onEveryMonday = json["onEveryMonday"];
    _onEveryTuesday = json["onEveryTuesday"];
    _onEveryWednesday = json["onEveryWednesday"];
    _onEveryThursday = json["onEveryThursday"];
    _onEveryFriday = json["onEveryFriday"];
    _onEverySaturday = json["onEverySaturday"];
    _scheduleName = json["scheduleName"];
    _sceneId = json["sceneId"];
    _individualAction = json["individualAction"];
    _createdBy = json["createdBy"];
    _createdDateTime = json["createdDateTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["applicationId"] = _applicationId;
    map["homeId"] = _homeId;
    map["roomId"] = _roomId;
    map["scheduleStartDate"] = _scheduleStartDate;
    map["scheduleTime"] = _scheduleTime;
    map["scheduleRepeat"] = _scheduleRepeat;
    map["onEverySunday"] = _onEverySunday;
    map["onEveryMonday"] = _onEveryMonday;
    map["onEveryTuesday"] = _onEveryTuesday;
    map["onEveryWednesday"] = _onEveryWednesday;
    map["onEveryThursday"] = _onEveryThursday;
    map["onEveryFriday"] = _onEveryFriday;
    map["onEverySaturday"] = _onEverySaturday;
    map["scheduleName"] = _scheduleName;
    map["sceneId"] = _sceneId;
    map["individualAction"] = _individualAction;
    map["createdBy"] = _createdBy;
    map["createdDateTime"] = _createdDateTime;
    return map;
  }

}

/// value : {"meta":{"message":"success.","status":"success","code":1}}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseAddSwitchSchedule {
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

  ResponseAddSwitchSchedule({
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

  ResponseAddSwitchSchedule.fromJson(dynamic json) {
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