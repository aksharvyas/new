import 'package:kremot/models/Meta.dart';

class ResponseRoomList {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponseRoomList(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseRoomList.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    // if (this.formatters != null) {
    //   data['formatters'] = this.formatters!.map((v) => v.toJson()).toList();
    // }
    // if (this.contentTypes != null) {
    //   data['contentTypes'] = this.contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = this.declaredType;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Value {
  List<AppUserAccessPermissionsRoom>? appUserAccessPermissionsRoom;
  Meta? meta;

  Value({this.appUserAccessPermissionsRoom, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['appUserAccessPermissionsRoom'] != null) {
      appUserAccessPermissionsRoom = <AppUserAccessPermissionsRoom>[];
      json['appUserAccessPermissionsRoom'].forEach((v) {
        appUserAccessPermissionsRoom!
            .add( AppUserAccessPermissionsRoom.fromJson(v));
      });
    }
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (appUserAccessPermissionsRoom != null) {
      data['appUserAccessPermissionsRoom'] =
          appUserAccessPermissionsRoom!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class AppUserAccessPermissionsRoom {
  String? roomId;
  String? roomName;

  AppUserAccessPermissionsRoom({this.roomId, this.roomName});

  AppUserAccessPermissionsRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    roomName = json['roomName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomId'] = roomId;
    data['roomName'] = roomName;
    return data;
  }
}


class RequestRoomList {
  String? applicationId;
  String? appuserId;
  String? homeId;

  RequestRoomList({this.applicationId, this.appuserId, this.homeId});

  RequestRoomList.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    appuserId = json['appuserId'];
    homeId = json['homeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['appuserId'] = appuserId;
    data['homeId'] = homeId;
    return data;
  }
}
