import 'package:kremot/models/Meta.dart';

class ResponseRoom {
  Value? value;
  List<void>? formatters;
  List<void>? contentTypes;
  dynamic declaredType;
  int? statusCode;

  ResponseRoom(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseRoom.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
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
    if (value != null) {
      data['value'] = value!.toJson();
    }
    // if (formatters != null) {
    //   data['formatters'] = formatters!.map((v) => v.toJson()).toList();
    // }
    // if (contentTypes != null) {
    //   data['contentTypes'] = contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = declaredType;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Value {
  Room? room;
  Meta? meta;

  Value({this.room, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (room != null) {
      data['room'] = room!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Room {
  String? id;
  String? homeId;
  String? roomName;
  String? appUserId;
  String? createdDateTime;
  String? createdBy;
  List<RoomSceneViewModels>? roomSceneViewModels;

  Room(
      {this.id,
        this.homeId,
        this.roomName,
        this.appUserId,
        this.createdDateTime,
        this.createdBy,
        this.roomSceneViewModels});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    homeId = json['homeId'];
    roomName = json['roomName'];
    appUserId = json['appUserId'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    if (json['roomSceneViewModels'] != null) {
      roomSceneViewModels = <RoomSceneViewModels>[];
      json['roomSceneViewModels'].forEach((v) {
        roomSceneViewModels!.add(RoomSceneViewModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['homeId'] = homeId;
    data['roomName'] = roomName;
    data['appUserId'] = appUserId;
    data['createdDateTime'] = createdDateTime;
    data['createdBy'] = createdBy;
    if (roomSceneViewModels != null) {
      data['roomSceneViewModels'] =
          roomSceneViewModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomSceneViewModels {
  String? sceneId;
  String? sceneName;

  RoomSceneViewModels({this.sceneId, this.sceneName});

  RoomSceneViewModels.fromJson(Map<String, dynamic> json) {
    sceneId = json['sceneId'];
    sceneName = json['sceneName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sceneId'] = sceneId;
    data['sceneName'] = sceneName;
    return data;
  }
}

class RequestRoom {
  String? applicationId;
  String? homeId;
  String? roomName;
  String? appUserId;
  String? createdDateTime;
  String? createdBy;

  RequestRoom(
      {this.applicationId,
        this.homeId,
        this.roomName,
        this.appUserId,
        this.createdDateTime,
        this.createdBy});

  RequestRoom.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    homeId = json['homeId'];
    roomName = json['roomName'];
    appUserId = json['appUserId'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['homeId'] = homeId;
    data['roomName'] = roomName;
    data['appUserId'] = appUserId;
    data['createdDateTime'] = createdDateTime;
    data['createdBy'] = createdBy;
    return data;
  }
}
