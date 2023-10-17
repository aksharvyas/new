import 'dart:convert';
/// value : {"deviceListViewModel":[{"id":1,"type":"1 SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":1,"switchId":4}]},{"id":2,"type":"1 SWITCH 2 WAY","image":"","totalCount":1,"deviceSwitches":[{"id":2,"switchId":5}]},{"id":3,"type":"BELL PUSH SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":3,"switchId":6}]},{"id":4,"type":"2 SWITCH","image":"","totalCount":2,"deviceSwitches":[{"id":4,"switchId":4},{"id":5,"switchId":4}]},{"id":5,"type":"2 SWITCH 2 WAY","image":"","totalCount":2,"deviceSwitches":[{"id":6,"switchId":5},{"id":7,"switchId":5}]},{"id":6,"type":"1 CURTAIN SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":8,"switchId":7}]},{"id":7,"type":"4 SWITCH","image":"","totalCount":4,"deviceSwitches":[{"id":9,"switchId":4},{"id":10,"switchId":4},{"id":11,"switchId":4},{"id":12,"switchId":4}]},{"id":8,"type":"1 BELL PUSH + 3 SWIT","image":"","totalCount":4,"deviceSwitches":[{"id":13,"switchId":6},{"id":14,"switchId":4},{"id":15,"switchId":4},{"id":16,"switchId":4}]},{"id":9,"type":"2 CURTAIN SWITCH","image":"","totalCount":2,"deviceSwitches":[{"id":17,"switchId":7},{"id":18,"switchId":7}]},{"id":10,"type":"30 AMP SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":19,"switchId":8}]},{"id":11,"type":"FAN REGULATOR 8 LED / 8 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":20,"switchId":9}]},{"id":12,"type":"FAN REGULATOR 4 LED / 4 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":21,"switchId":10}]},{"id":13,"type":"FAN REGULATOR 5 LED / 5 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":22,"switchId":11}]},{"id":14,"type":"LIGHT DIMMER 8 LED / 8 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":23,"switchId":12}]},{"id":15,"type":"DND SWITCH INSIDE HOTEL ROOM","image":"","totalCount":1,"deviceSwitches":[{"id":24,"switchId":13}]},{"id":16,"type":"DND SWITCH OUTSIDE HOTEL ROOM","image":"","totalCount":1,"deviceSwitches":[{"id":25,"switchId":14}]},{"id":17,"type":"4 SWITCH + 1 FAN REGULATOR 4 STEPS","image":"","totalCount":5,"deviceSwitches":[{"id":26,"switchId":4},{"id":27,"switchId":4},{"id":28,"switchId":4},{"id":29,"switchId":4},{"id":30,"switchId":10}]},{"id":18,"type":"4 SWITCH + 1 FAN REGULATOR 8 STEPS","image":"","totalCount":5,"deviceSwitches":[{"id":31,"switchId":4},{"id":32,"switchId":4},{"id":33,"switchId":4},{"id":34,"switchId":4},{"id":35,"switchId":12}]},{"id":19,"type":"8 SWITCH + 1 FAN REGULATOR 8 STEPS","image":"","totalCount":9,"deviceSwitches":[{"id":36,"switchId":4},{"id":37,"switchId":4},{"id":38,"switchId":4},{"id":39,"switchId":4},{"id":40,"switchId":4},{"id":41,"switchId":4},{"id":42,"switchId":4},{"id":43,"switchId":4},{"id":44,"switchId":9}]},{"id":20,"type":"8 SWITCH + 2 FAN REGULATOR 8 STEPS","image":"","totalCount":10,"deviceSwitches":[{"id":45,"switchId":4},{"id":46,"switchId":4},{"id":47,"switchId":4},{"id":48,"switchId":4},{"id":49,"switchId":4},{"id":50,"switchId":4},{"id":51,"switchId":4},{"id":52,"switchId":4},{"id":53,"switchId":9},{"id":54,"switchId":9}]},{"id":21,"type":"SCENE SWITCH 1-4","image":"","totalCount":4,"deviceSwitches":[{"id":55,"switchId":16},{"id":56,"switchId":16},{"id":57,"switchId":16},{"id":58,"switchId":16}]},{"id":22,"type":"SCENE SWITCH 5-8","image":"","totalCount":4,"deviceSwitches":[{"id":59,"switchId":17},{"id":60,"switchId":17},{"id":61,"switchId":17},{"id":62,"switchId":17}]},{"id":23,"type":"CAMERA","image":"","totalCount":1,"deviceSwitches":[{"id":63,"switchId":15}]},{"id":24,"type":"PIR SENSOR","image":"","totalCount":1,"deviceSwitches":[{"id":64,"switchId":18}]},{"id":25,"type":"DRAWER LOCK","image":"","totalCount":1,"deviceSwitches":[{"id":65,"switchId":19}]},{"id":26,"type":"DOOR LOCK","image":"","totalCount":1,"deviceSwitches":[{"id":66,"switchId":20}]}],"meta":{"message":"success","status":"success","code":1}}
/// statusCode : 200

DeviceSwitchesModel switchesModelFromJson(String str) => DeviceSwitchesModel.fromJson(json.decode(str));
String switchesModelToJson(DeviceSwitchesModel data) => json.encode(data.toJson());
class DeviceSwitchesModel {
  DeviceSwitchesModel({
      Value? value, 
      int? statusCode,}){
    _value = value;
    _statusCode = statusCode;
}

  DeviceSwitchesModel.fromJson(dynamic json) {
    _value = json['value'] != null ? Value.fromJson(json['value']) : null;
    _statusCode = json['statusCode'];
  }
  Value? _value;
  int? _statusCode;
DeviceSwitchesModel copyWith({  Value? value,
  int? statusCode,
}) => DeviceSwitchesModel(  value: value ?? _value,
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

/// deviceListViewModel : [{"id":1,"type":"1 SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":1,"switchId":4}]},{"id":2,"type":"1 SWITCH 2 WAY","image":"","totalCount":1,"deviceSwitches":[{"id":2,"switchId":5}]},{"id":3,"type":"BELL PUSH SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":3,"switchId":6}]},{"id":4,"type":"2 SWITCH","image":"","totalCount":2,"deviceSwitches":[{"id":4,"switchId":4},{"id":5,"switchId":4}]},{"id":5,"type":"2 SWITCH 2 WAY","image":"","totalCount":2,"deviceSwitches":[{"id":6,"switchId":5},{"id":7,"switchId":5}]},{"id":6,"type":"1 CURTAIN SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":8,"switchId":7}]},{"id":7,"type":"4 SWITCH","image":"","totalCount":4,"deviceSwitches":[{"id":9,"switchId":4},{"id":10,"switchId":4},{"id":11,"switchId":4},{"id":12,"switchId":4}]},{"id":8,"type":"1 BELL PUSH + 3 SWIT","image":"","totalCount":4,"deviceSwitches":[{"id":13,"switchId":6},{"id":14,"switchId":4},{"id":15,"switchId":4},{"id":16,"switchId":4}]},{"id":9,"type":"2 CURTAIN SWITCH","image":"","totalCount":2,"deviceSwitches":[{"id":17,"switchId":7},{"id":18,"switchId":7}]},{"id":10,"type":"30 AMP SWITCH","image":"","totalCount":1,"deviceSwitches":[{"id":19,"switchId":8}]},{"id":11,"type":"FAN REGULATOR 8 LED / 8 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":20,"switchId":9}]},{"id":12,"type":"FAN REGULATOR 4 LED / 4 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":21,"switchId":10}]},{"id":13,"type":"FAN REGULATOR 5 LED / 5 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":22,"switchId":11}]},{"id":14,"type":"LIGHT DIMMER 8 LED / 8 STEPS","image":"","totalCount":1,"deviceSwitches":[{"id":23,"switchId":12}]},{"id":15,"type":"DND SWITCH INSIDE HOTEL ROOM","image":"","totalCount":1,"deviceSwitches":[{"id":24,"switchId":13}]},{"id":16,"type":"DND SWITCH OUTSIDE HOTEL ROOM","image":"","totalCount":1,"deviceSwitches":[{"id":25,"switchId":14}]},{"id":17,"type":"4 SWITCH + 1 FAN REGULATOR 4 STEPS","image":"","totalCount":5,"deviceSwitches":[{"id":26,"switchId":4},{"id":27,"switchId":4},{"id":28,"switchId":4},{"id":29,"switchId":4},{"id":30,"switchId":10}]},{"id":18,"type":"4 SWITCH + 1 FAN REGULATOR 8 STEPS","image":"","totalCount":5,"deviceSwitches":[{"id":31,"switchId":4},{"id":32,"switchId":4},{"id":33,"switchId":4},{"id":34,"switchId":4},{"id":35,"switchId":12}]},{"id":19,"type":"8 SWITCH + 1 FAN REGULATOR 8 STEPS","image":"","totalCount":9,"deviceSwitches":[{"id":36,"switchId":4},{"id":37,"switchId":4},{"id":38,"switchId":4},{"id":39,"switchId":4},{"id":40,"switchId":4},{"id":41,"switchId":4},{"id":42,"switchId":4},{"id":43,"switchId":4},{"id":44,"switchId":9}]},{"id":20,"type":"8 SWITCH + 2 FAN REGULATOR 8 STEPS","image":"","totalCount":10,"deviceSwitches":[{"id":45,"switchId":4},{"id":46,"switchId":4},{"id":47,"switchId":4},{"id":48,"switchId":4},{"id":49,"switchId":4},{"id":50,"switchId":4},{"id":51,"switchId":4},{"id":52,"switchId":4},{"id":53,"switchId":9},{"id":54,"switchId":9}]},{"id":21,"type":"SCENE SWITCH 1-4","image":"","totalCount":4,"deviceSwitches":[{"id":55,"switchId":16},{"id":56,"switchId":16},{"id":57,"switchId":16},{"id":58,"switchId":16}]},{"id":22,"type":"SCENE SWITCH 5-8","image":"","totalCount":4,"deviceSwitches":[{"id":59,"switchId":17},{"id":60,"switchId":17},{"id":61,"switchId":17},{"id":62,"switchId":17}]},{"id":23,"type":"CAMERA","image":"","totalCount":1,"deviceSwitches":[{"id":63,"switchId":15}]},{"id":24,"type":"PIR SENSOR","image":"","totalCount":1,"deviceSwitches":[{"id":64,"switchId":18}]},{"id":25,"type":"DRAWER LOCK","image":"","totalCount":1,"deviceSwitches":[{"id":65,"switchId":19}]},{"id":26,"type":"DOOR LOCK","image":"","totalCount":1,"deviceSwitches":[{"id":66,"switchId":20}]}]
/// meta : {"message":"success","status":"success","code":1}

Value valueFromJson(String str) => Value.fromJson(json.decode(str));
String valueToJson(Value data) => json.encode(data.toJson());
class Value {
  Value({
      List<DeviceListViewModel>? deviceListViewModel, 
      Meta? meta,}){
    _deviceListViewModel = deviceListViewModel;
    _meta = meta;
}

  Value.fromJson(dynamic json) {
    if (json['deviceListViewModel'] != null) {
      _deviceListViewModel = [];
      json['deviceListViewModel'].forEach((v) {
        _deviceListViewModel?.add(DeviceListViewModel.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<DeviceListViewModel>? _deviceListViewModel;
  Meta? _meta;
Value copyWith({  List<DeviceListViewModel>? deviceListViewModel,
  Meta? meta,
}) => Value(  deviceListViewModel: deviceListViewModel ?? _deviceListViewModel,
  meta: meta ?? _meta,
);
  List<DeviceListViewModel>? get deviceListViewModel => _deviceListViewModel;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_deviceListViewModel != null) {
      map['deviceListViewModel'] = _deviceListViewModel?.map((v) => v.toJson()).toList();
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

/// id : 1
/// type : "1 SWITCH"
/// image : ""
/// totalCount : 1
/// deviceSwitches : [{"id":1,"switchId":4}]

DeviceListViewModel deviceListViewModelFromJson(String str) => DeviceListViewModel.fromJson(json.decode(str));
String deviceListViewModelToJson(DeviceListViewModel data) => json.encode(data.toJson());
class DeviceListViewModel {
  DeviceListViewModel({
      int? id, 
      String? type, 
      String? image, 
      int? totalCount, 
      List<DeviceSwitches>? deviceSwitches,}){
    _id = id;
    _type = type;
    _image = image;
    _totalCount = totalCount;
    _deviceSwitches = deviceSwitches;
}

  DeviceListViewModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _image = json['image'];
    _totalCount = json['totalCount'];
    if (json['deviceSwitches'] != null) {
      _deviceSwitches = [];
      json['deviceSwitches'].forEach((v) {
        _deviceSwitches?.add(DeviceSwitches.fromJson(v));
      });
    }
  }
  int? _id;
  String? _type;
  String? _image;
  int? _totalCount;
  List<DeviceSwitches>? _deviceSwitches;
DeviceListViewModel copyWith({  int? id,
  String? type,
  String? image,
  int? totalCount,
  List<DeviceSwitches>? deviceSwitches,
}) => DeviceListViewModel(  id: id ?? _id,
  type: type ?? _type,
  image: image ?? _image,
  totalCount: totalCount ?? _totalCount,
  deviceSwitches: deviceSwitches ?? _deviceSwitches,
);
  int? get id => _id;
  String? get type => _type;
  String? get image => _image;
  int? get totalCount => _totalCount;
  List<DeviceSwitches>? get deviceSwitches => _deviceSwitches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    map['totalCount'] = _totalCount;
    if (_deviceSwitches != null) {
      map['deviceSwitches'] = _deviceSwitches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// switchId : 4

DeviceSwitches deviceSwitchesFromJson(String str) => DeviceSwitches.fromJson(json.decode(str));
String deviceSwitchesToJson(DeviceSwitches data) => json.encode(data.toJson());
class DeviceSwitches {
  DeviceSwitches({
      int? id, 
      int? switchId,}){
    _id = id;
    _switchId = switchId;
}

  DeviceSwitches.fromJson(dynamic json) {
    _id = json['id'];
    _switchId = json['switchId'];
  }
  int? _id;
  int? _switchId;
DeviceSwitches copyWith({  int? id,
  int? switchId,
}) => DeviceSwitches(  id: id ?? _id,
  switchId: switchId ?? _switchId,
);
  int? get id => _id;
  int? get switchId => _switchId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['switchId'] = _switchId;
    return map;
  }

}