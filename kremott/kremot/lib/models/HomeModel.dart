import 'package:kremot/models/Meta.dart';

class ResponseHome {
  Value? value;
  List<void>? formatters;
  List<void>? contentTypes;
  dynamic declaredType;
  int? statusCode;

  ResponseHome(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseHome.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ?  Value.fromJson(json['value']) : null;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    // if (this.formatters != null) {
    //   data['formatters'] = this.formatters!.map((v) => v.toJson()).toList();
    // }
    // if (this.contentTypes != null) {
    //   data['contentTypes'] = this.contentTypes!.map((v) => v.toJson()).toList();
    // }
    data['declaredType'] = declaredType;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Value {
  Home? home;
  AppUserAccessPermission? appUserAccessPermission;
  Meta? meta;

  Value({this.home, this.appUserAccessPermission, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ?  Home.fromJson(json['home']) : null;
    appUserAccessPermission = json['appUserAccessPermission'] != null
        ?  AppUserAccessPermission.fromJson(json['appUserAccessPermission'])
        : null;
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (appUserAccessPermission != null) {
      data['appUserAccessPermission'] = appUserAccessPermission!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Home {
  String? id;
  String? name;
  String? appUserId;
  String? createdBy;
  String? createdDateTime;

  Home(
      {this.id,
        this.name,
        this.appUserId,
        this.createdBy,
        this.createdDateTime});

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    appUserId = json['appUserId'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['appUserId'] = appUserId;
    data['createdBy'] = createdBy;
    data['createdDateTime'] = createdDateTime;
    return data;
  }
}

class AppUserAccessPermission {
  int? id;
  String? appUserId;
  String? homeId;
  dynamic roomId;
  bool? isOwner;
  bool? isAdditionalAdmin;
  bool? isAdditionalUser;
  String? createdDateTime;
  String? createdBy;

  AppUserAccessPermission(
      {this.id,
        this.appUserId,
        this.homeId,
        this.roomId,
        this.isOwner,
        this.isAdditionalAdmin,
        this.isAdditionalUser,
        this.createdDateTime,
        this.createdBy});

  AppUserAccessPermission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    homeId = json['homeId'];
    roomId = json['roomId'];
    isOwner = json['isOwner'];
    isAdditionalAdmin = json['isAdditionalAdmin'];
    isAdditionalUser = json['isAdditionalUser'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appUserId'] = appUserId;
    data['homeId'] = homeId;
    data['roomId'] = roomId;
    data['isOwner'] = isOwner;
    data['isAdditionalAdmin'] = isAdditionalAdmin;
    data['isAdditionalUser'] = isAdditionalUser;
    data['createdDateTime'] = createdDateTime;
    data['createdBy'] = createdBy;
    return data;
  }
}

class RequestHome {
  String? applicationId;
  String? name;
  String? appUserId;
  String? createdBy;
  String? createdDateTime;

  RequestHome(
      {this.applicationId,
        this.name,
        this.appUserId,
        this.createdBy,
        this.createdDateTime});

  RequestHome.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    name = json['name'];
    appUserId = json['appUserId'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['name'] = name;
    data['appUserId'] = appUserId;
    data['createdBy'] = createdBy;
    data['createdDateTime'] = createdDateTime;
    return data;
  }
}

