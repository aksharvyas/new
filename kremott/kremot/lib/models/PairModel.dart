import 'package:kremot/models/Meta.dart';

class RequestPair {
  String? applicationId;
  int? id;
  String? pairedBy;
  String? homeId;
  String? roomId;
  String? updatedDateTime;
  String? updatedBy;

  RequestPair(
      {this.applicationId,
        this.id,
        this.pairedBy,
        this.homeId,
        this.roomId,
        this.updatedDateTime,
        this.updatedBy});

  RequestPair.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    id = json['id'];
    pairedBy = json['pairedBy'];
    homeId = json['homeId'];
    roomId = json['roomId'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['id'] = id;
    data['pairedBy'] = pairedBy;
    data['homeId'] = homeId;
    data['roomId'] = roomId;
    data['updatedDateTime'] = updatedDateTime;
    data['updatedBy'] = updatedBy;
    return data;
  }
}

class ResponsePair {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponsePair(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponsePair.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value']) : null;

    declaredType = json['declaredType'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  Meta? meta;

  Value({this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}