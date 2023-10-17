import 'dart:convert';
/// value : {"switchViewModel":[{"id":5,"prifix":"2W","switchName":"2 WAY","buttonImage":""},{"id":8,"prifix":"30M","switchName":"30 AMP ","buttonImage":""},{"id":6,"prifix":"B","switchName":"BELL PUSH SWITCH","buttonImage":""},{"id":15,"prifix":"C","switchName":"CAMERA","buttonImage":""},{"id":7,"prifix":"C","switchName":"CURTAIN ","buttonImage":""},{"id":13,"prifix":"DNDI","switchName":"DND SWITCH INSIDE HOTEL ROOM","buttonImage":""},{"id":14,"prifix":"DNDO","switchName":"DND SWITCH OUTSIDE HOTEL ROOM","buttonImage":""},{"id":20,"prifix":"DOL","switchName":"DOOR LOCK","buttonImage":""},{"id":19,"prifix":"DRL","switchName":"DRAWER LOCK","buttonImage":""},{"id":2,"prifix":"F","switchName":"Fan","buttonImage":""},{"id":10,"prifix":"FR4","switchName":"FAN REGULATOR 4 LED ","buttonImage":""},{"id":11,"prifix":"FR5","switchName":"FAN REGULATOR 5 LED ","buttonImage":""},{"id":9,"prifix":"FR8","switchName":"FAN REGULATOR 8 LED ","buttonImage":""},{"id":1,"prifix":"L","switchName":"Light","buttonImage":""},{"id":12,"prifix":"D8","switchName":"LIGHT DIMMER 8 LED","buttonImage":""},{"id":18,"prifix":"PIR","switchName":"PIR SENSOR","buttonImage":""},{"id":16,"prifix":"S14","switchName":"SCENE SWITCH 1-4","buttonImage":""},{"id":17,"prifix":"S58","switchName":"SCENE SWITCH 5-8","buttonImage":""},{"id":4,"prifix":"S","switchName":"SWITCH","buttonImage":""}],"meta":{"message":"Success.","status":"success","code":1}}
/// statusCode : 200

SwitchesModel switchesModelFromJson(String str) => SwitchesModel.fromJson(json.decode(str));
String switchesModelToJson(SwitchesModel data) => json.encode(data.toJson());
class SwitchesModel {
  SwitchesModel({
      Value? value, 
      int? statusCode,}){
    _value = value;
    _statusCode = statusCode;
}

  SwitchesModel.fromJson(dynamic json) {
    _value = json['value'] != null ? Value.fromJson(json['value']) : null;
    _statusCode = json['statusCode'];
  }
  Value? _value;
  int? _statusCode;
SwitchesModel copyWith({  Value? value,
  int? statusCode,
}) => SwitchesModel(  value: value ?? _value,
  statusCode: statusCode ?? _statusCode,
);
  Value? get value => _value;
  int? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.toJson();
    }
    map['statusCode'] = _statusCode;
    return map;
  }

}

/// switchViewModel : [{"id":5,"prifix":"2W","switchName":"2 WAY","buttonImage":""},{"id":8,"prifix":"30M","switchName":"30 AMP ","buttonImage":""},{"id":6,"prifix":"B","switchName":"BELL PUSH SWITCH","buttonImage":""},{"id":15,"prifix":"C","switchName":"CAMERA","buttonImage":""},{"id":7,"prifix":"C","switchName":"CURTAIN ","buttonImage":""},{"id":13,"prifix":"DNDI","switchName":"DND SWITCH INSIDE HOTEL ROOM","buttonImage":""},{"id":14,"prifix":"DNDO","switchName":"DND SWITCH OUTSIDE HOTEL ROOM","buttonImage":""},{"id":20,"prifix":"DOL","switchName":"DOOR LOCK","buttonImage":""},{"id":19,"prifix":"DRL","switchName":"DRAWER LOCK","buttonImage":""},{"id":2,"prifix":"F","switchName":"Fan","buttonImage":""},{"id":10,"prifix":"FR4","switchName":"FAN REGULATOR 4 LED ","buttonImage":""},{"id":11,"prifix":"FR5","switchName":"FAN REGULATOR 5 LED ","buttonImage":""},{"id":9,"prifix":"FR8","switchName":"FAN REGULATOR 8 LED ","buttonImage":""},{"id":1,"prifix":"L","switchName":"Light","buttonImage":""},{"id":12,"prifix":"D8","switchName":"LIGHT DIMMER 8 LED","buttonImage":""},{"id":18,"prifix":"PIR","switchName":"PIR SENSOR","buttonImage":""},{"id":16,"prifix":"S14","switchName":"SCENE SWITCH 1-4","buttonImage":""},{"id":17,"prifix":"S58","switchName":"SCENE SWITCH 5-8","buttonImage":""},{"id":4,"prifix":"S","switchName":"SWITCH","buttonImage":""}]
/// meta : {"message":"Success.","status":"success","code":1}

Value valueFromJson(String str) => Value.fromJson(json.decode(str));
String valueToJson(Value data) => json.encode(data.toJson());
class Value {
  Value({
      List<SwitchViewModel>? switchViewModel, 
      Meta? meta,}){
    _switchViewModel = switchViewModel;
    _meta = meta;
}

  Value.fromJson(dynamic json) {
    if (json['switchViewModel'] != null) {
      _switchViewModel = [];
      json['switchViewModel'].forEach((v) {
        _switchViewModel?.add(SwitchViewModel.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<SwitchViewModel>? _switchViewModel;
  Meta? _meta;
Value copyWith({  List<SwitchViewModel>? switchViewModel,
  Meta? meta,
}) => Value(  switchViewModel: switchViewModel ?? _switchViewModel,
  meta: meta ?? _meta,
);
  List<SwitchViewModel>? get switchViewModel => _switchViewModel;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_switchViewModel != null) {
      map['switchViewModel'] = _switchViewModel?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

/// message : "Success."
/// status : "success"
/// code : 1

Meta metaFromJson(String str) => Meta.fromJson(json.decode(str));
String metaToJson(Meta data) => json.encode(data.toJson());
class Meta {
  Meta({
      String? message, 
      String? status, 
      int? code,}){
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
  int? _code;
Meta copyWith({  String? message,
  String? status,
  int? code,
}) => Meta(  message: message ?? _message,
  status: status ?? _status,
  code: code ?? _code,
);
  String? get message => _message;
  String? get status => _status;
  int? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    map['code'] = _code;
    return map;
  }

}

/// id : 5
/// prifix : "2W"
/// switchName : "2 WAY"
/// buttonImage : ""

SwitchViewModel switchViewModelFromJson(String str) => SwitchViewModel.fromJson(json.decode(str));
String switchViewModelToJson(SwitchViewModel data) => json.encode(data.toJson());
class SwitchViewModel {
  SwitchViewModel({
      int? id, 
      String? prifix, 
      String? switchName, 
      String? buttonImage,}){
    _id = id;
    _prifix = prifix;
    _switchName = switchName;
    _buttonImage = buttonImage;
}

  SwitchViewModel.fromJson(dynamic json) {
    _id = json['id'];
    _prifix = json['prifix'];
    _switchName = json['switchName'];
    _buttonImage = json['buttonImage'];
  }
  int? _id;
  String? _prifix;
  String? _switchName;
  String? _buttonImage;
SwitchViewModel copyWith({  int? id,
  String? prifix,
  String? switchName,
  String? buttonImage,
}) => SwitchViewModel(  id: id ?? _id,
  prifix: prifix ?? _prifix,
  switchName: switchName ?? _switchName,
  buttonImage: buttonImage ?? _buttonImage,
);
  int? get id => _id;
  String? get prifix => _prifix;
  String? get switchName => _switchName;
  String? get buttonImage => _buttonImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['prifix'] = _prifix;
    map['switchName'] = _switchName;
    map['buttonImage'] = _buttonImage;
    return map;
  }

}