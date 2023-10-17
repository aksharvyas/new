import 'dart:convert';

class ResponseDeviceSwitch {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponseDeviceSwitch(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseDeviceSwitch.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    declaredType = json['declaredType'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    data['declaredType'] = this.declaredType;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Value {
  List<DeviceListViewModel>? deviceListViewModel;
  Meta? meta;

  Value({this.deviceListViewModel, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['deviceListViewModel'] != null) {
      deviceListViewModel = <DeviceListViewModel>[];
      json['deviceListViewModel'].forEach((v) {
        deviceListViewModel!.add(new DeviceListViewModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deviceListViewModel != null) {
      data['deviceListViewModel'] =
          this.deviceListViewModel!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class DeviceListViewModel {
  int? id;
  String? type;
  String? image;
  int? totalCount;
  List<DeviceSwitches>? deviceSwitches;

  DeviceListViewModel(
      {this.id, this.type, this.image, this.totalCount, this.deviceSwitches});

  DeviceListViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    totalCount = json['totalCount'];
    if (json['deviceSwitches'] != null) {
      deviceSwitches = <DeviceSwitches>[];
      json['deviceSwitches'].forEach((v) {
        deviceSwitches!.add(new DeviceSwitches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['image'] = this.image;
    data['totalCount'] = this.totalCount;
    if (this.deviceSwitches != null) {
      data['deviceSwitches'] =
          this.deviceSwitches!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Map<String, dynamic> toMap(DeviceListViewModel deviceListViewModel) => {
    'id': deviceListViewModel.id,
    'type': deviceListViewModel.type,
    'image': deviceListViewModel.image,
    'totalCount': deviceListViewModel.totalCount,
    'deviceSwitches': deviceListViewModel.deviceSwitches,
  };

  static String encode(List<DeviceListViewModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => DeviceListViewModel.toMap(music))
        .toList(),
  );

  static List<DeviceListViewModel> decode(String? musics) =>
      (json.decode(musics!) as List<dynamic>)
          .map<DeviceListViewModel>((item) => DeviceListViewModel.fromJson(item))
          .toList();

}

class DeviceSwitches {
  int? id;
  int? switchId;

  DeviceSwitches({this.id, this.switchId});

  DeviceSwitches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    switchId = json['switchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['switchId'] = this.switchId;
    return data;
  }

  static Map<String, dynamic> toMap(DeviceSwitches deviceSwitches) => {
    'id': deviceSwitches.id,
    'switchId': deviceSwitches.switchId,
  };

  static String encode(List<DeviceSwitches> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => DeviceSwitches.toMap(music))
        .toList(),
  );

  static List<DeviceSwitches> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<DeviceSwitches>((item) => DeviceSwitches.fromJson(item))
          .toList();
}

class Meta {
  String? message;
  String? status;
  int? code;

  Meta({this.message, this.status, this.code});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}




class RequestDeviceSwitch {
  String? applicationId;
  String? search;
  int? pageNo;
  int? perPage;

  RequestDeviceSwitch(
      {this.applicationId, this.search, this.pageNo, this.perPage});

  RequestDeviceSwitch.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    search = json['search'];
    pageNo = json['pageNo'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['search'] = this.search;
    data['pageNo'] = this.pageNo;
    data['perPage'] = this.perPage;
    return data;
  }
}
