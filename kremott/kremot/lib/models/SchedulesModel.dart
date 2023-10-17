/// applicationId : "123774499931415"
/// appUserId : "8eb4da5d-6e63-4947-8812-48cecaee5147"

class RequestSchedules {
  String? _applicationId;
  String? _appUserId;

  String? get applicationId => _applicationId;
  String? get appUserId => _appUserId;

  RequestSchedules({
    String? applicationId,
    String? appUserId}){
    _applicationId = applicationId;
    _appUserId = appUserId;
  }

  RequestSchedules.fromJson(dynamic json) {
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

/// value : {"meta":{"message":"success.","status":"success","code":1},"scheduleGetViewModel":[{"id":18,"homeId":"3f1c3a93-4d2e-40a2-b013-07d33b3bc18d","roomId":"a1652c50-71ae-423e-9900-19ab0dfb1647","scheduleStartDate":"2023-01-31T07:25:58","scheduleTime":"2023-01-31T07:25:58","scheduleRepeat":1,"onEverySunday":false,"onEveryMonday":false,"onEveryTuesday":false,"onEveryWednesday":false,"onEveryThursday":false,"onEveryFriday":false,"onEverySaturday":false,"scheduleName":"Schedule25","sceneId":"00000000-0000-0000-0000-000000000000","individualAction":true,"scheduleDetails":[{"id":15,"scheduleId":18,"roomCmacDetailId":67,"onOffStatus":"on"}]}]}
/// formatters : []
/// contentTypes : []
/// declaredType : null
/// statusCode : 200

class ResponseSchedules {
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

  ResponseSchedules({
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

  ResponseSchedules.fromJson(dynamic json) {
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
/// scheduleGetViewModel : [{"id":18,"homeId":"3f1c3a93-4d2e-40a2-b013-07d33b3bc18d","roomId":"a1652c50-71ae-423e-9900-19ab0dfb1647","scheduleStartDate":"2023-01-31T07:25:58","scheduleTime":"2023-01-31T07:25:58","scheduleRepeat":1,"onEverySunday":false,"onEveryMonday":false,"onEveryTuesday":false,"onEveryWednesday":false,"onEveryThursday":false,"onEveryFriday":false,"onEverySaturday":false,"scheduleName":"Schedule25","sceneId":"00000000-0000-0000-0000-000000000000","individualAction":true,"scheduleDetails":[{"id":15,"scheduleId":18,"roomCmacDetailId":67,"onOffStatus":"on"}]}]

class Value {
  Meta? _meta;
  List<ScheduleGetViewModel>? _scheduleGetViewModel;

  Meta? get meta => _meta;
  List<ScheduleGetViewModel>? get scheduleGetViewModel => _scheduleGetViewModel;

  Value({
    Meta? meta,
    List<ScheduleGetViewModel>? scheduleGetViewModel}){
    _meta = meta;
    _scheduleGetViewModel = scheduleGetViewModel;
  }

  Value.fromJson(dynamic json) {
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
    if (json["scheduleGetViewModel"] != null) {
      _scheduleGetViewModel = [];
      json["scheduleGetViewModel"].forEach((v) {
        _scheduleGetViewModel?.add(ScheduleGetViewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    if (_scheduleGetViewModel != null) {
      map["scheduleGetViewModel"] = _scheduleGetViewModel?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 18
/// homeId : "3f1c3a93-4d2e-40a2-b013-07d33b3bc18d"
/// roomId : "a1652c50-71ae-423e-9900-19ab0dfb1647"
/// scheduleStartDate : "2023-01-31T07:25:58"
/// scheduleTime : "2023-01-31T07:25:58"
/// scheduleRepeat : 1
/// onEverySunday : false
/// onEveryMonday : false
/// onEveryTuesday : false
/// onEveryWednesday : false
/// onEveryThursday : false
/// onEveryFriday : false
/// onEverySaturday : false
/// scheduleName : "Schedule25"
/// sceneId : "00000000-0000-0000-0000-000000000000"
/// individualAction : true
/// scheduleDetails : [{"id":15,"scheduleId":18,"roomCmacDetailId":67,"onOffStatus":"on"}]

class ScheduleGetViewModel {
  int? _id;
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
  List<ScheduleDetails>? _scheduleDetails;
  bool? _isSelected = false;

  int? get id => _id;
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
  List<ScheduleDetails>? get scheduleDetails => _scheduleDetails;

  set isSelected(bool? val) => _isSelected = val;
  bool? get isSelected => _isSelected;

  ScheduleGetViewModel({
    int? id,
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
    List<ScheduleDetails>? scheduleDetails}){
    _id = id;
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
    _scheduleDetails = scheduleDetails;
  }

  ScheduleGetViewModel.fromJson(dynamic json) {
    _id = json["id"];
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
    if (json["scheduleDetails"] != null) {
      _scheduleDetails = [];
      json["scheduleDetails"].forEach((v) {
        _scheduleDetails?.add(ScheduleDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
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
    if (_scheduleDetails != null) {
      map["scheduleDetails"] = _scheduleDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 15
/// scheduleId : 18
/// roomCmacDetailId : 67
/// onOffStatus : "on"

class ScheduleDetails {
  int? _id;
  int? _scheduleId;
  int? _roomCmacDetailId;
  String? _onOffStatus;

  int? get id => _id;
  int? get scheduleId => _scheduleId;
  int? get roomCmacDetailId => _roomCmacDetailId;
  String? get onOffStatus => _onOffStatus;

  ScheduleDetails({
    int? id,
    int? scheduleId,
    int? roomCmacDetailId,
    String? onOffStatus}){
    _id = id;
    _scheduleId = scheduleId;
    _roomCmacDetailId = roomCmacDetailId;
    _onOffStatus = onOffStatus;
  }

  ScheduleDetails.fromJson(dynamic json) {
    _id = json["id"];
    _scheduleId = json["scheduleId"];
    _roomCmacDetailId = json["roomCmacDetailId"];
    _onOffStatus = json["onOffStatus"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["scheduleId"] = _scheduleId;
    map["roomCmacDetailId"] = _roomCmacDetailId;
    map["onOffStatus"] = _onOffStatus;
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