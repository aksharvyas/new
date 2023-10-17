import 'package:kremot/models/Meta.dart';



class RequestHomeList {
  String? applicationId;
  String? appuserId;

  RequestHomeList({this.applicationId, this.appuserId});

  RequestHomeList.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    appuserId = json['appuserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['appuserId'] = appuserId;
    return data;
  }
}



class ResponseHomeList {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
 dynamic declaredType;
  int? statusCode;

  ResponseHomeList(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseHomeList.fromJson(Map<String, dynamic> json) {
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
  List<AppUserAccessPermissions>? appUserAccessPermissions;
  Meta? meta;

  Value({this.appUserAccessPermissions, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['appUserAccessPermissions'] != null) {
      appUserAccessPermissions = <AppUserAccessPermissions>[];
      json['appUserAccessPermissions'].forEach((v) {
        appUserAccessPermissions!.add( AppUserAccessPermissions.fromJson(v));
      });
    }
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (appUserAccessPermissions != null) {
      data['appUserAccessPermissions'] =
          appUserAccessPermissions!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class AppUserAccessPermissions {
  String? appUserId;
  String? homeName;
  String? homeId;
  bool? isOwner;
  bool? isAdditionalAdmin;
  bool? isAdditionalUser;
  String? createdDateTime;
  String? permissionGivenBy;

  AppUserAccessPermissions(
      {this.appUserId,
        this.homeName,
        this.homeId,
        this.isOwner,
        this.isAdditionalAdmin,
        this.isAdditionalUser,
        this.createdDateTime,
        this.permissionGivenBy});

  AppUserAccessPermissions.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    homeName = json['homeName'];
    homeId = json['homeId'];
    isOwner = json['isOwner'];
    isAdditionalAdmin = json['isAdditionalAdmin'];
    isAdditionalUser = json['isAdditionalUser'];
    createdDateTime = json['createdDateTime'];
    permissionGivenBy = json['permissionGivenBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appUserId'] = appUserId;
    data['homeName'] = homeName;
    data['homeId'] = homeId;
    data['isOwner'] = isOwner;
    data['isAdditionalAdmin'] = isAdditionalAdmin;
    data['isAdditionalUser'] = isAdditionalUser;
    data['createdDateTime'] = createdDateTime;
    data['permissionGivenBy'] = permissionGivenBy;
    return data;
  }
}
