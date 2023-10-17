import 'package:kremot/models/Meta.dart';

class ResponseCMACID {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponseCMACID(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseCMACID.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  Production? production;
  Meta? meta;

  Value({this.production, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    production = json['production'] != null
        ? new Production.fromJson(json['production'])
        : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.production != null) {
      data['production'] = this.production!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Production {
  int? id;
  String? cmacId;
  int? companyId;
  int? deviceTypeId;
  bool? isPaired;
  String? pairedBy;
  int? testedBy;
  Null? createdDateTime;
  Null? createdBy;
  Null? updatedDateTime;
  Null? updatedBy;
  Null? deletedDateTime;
  Null? deletedBy;
  Null? pairedByNavigation;
  Null? testedByNavigation;
  List<dynamic>? productionDetails;
  List<dynamic>? roomCmacs;

  Production(
      {this.id,
        this.cmacId,
        this.companyId,
        this.deviceTypeId,
        this.isPaired,
        this.pairedBy,
        this.testedBy,
        this.createdDateTime,
        this.createdBy,
        this.updatedDateTime,
        this.updatedBy,
        this.deletedDateTime,
        this.deletedBy,
        this.pairedByNavigation,
        this.testedByNavigation,
        this.productionDetails,
        this.roomCmacs});

  Production.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cmacId = json['cmacId'];
    companyId = json['companyId'];
    deviceTypeId = json['deviceTypeId'];
    isPaired = json['isPaired'];
    pairedBy = json['pairedBy'];
    testedBy = json['testedBy'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    deletedDateTime = json['deletedDateTime'];
    deletedBy = json['deletedBy'];
    pairedByNavigation = json['pairedByNavigation'];
    testedByNavigation = json['testedByNavigation'];
    // if (json['productionDetails'] != null) {
    //   productionDetails = <Null>[];
    //   json['productionDetails'].forEach((v) {
    //     productionDetails!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['roomCmacs'] != null) {
    //   roomCmacs = <Null>[];
    //   json['roomCmacs'].forEach((v) {
    //     roomCmacs!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cmacId'] = this.cmacId;
    data['companyId'] = this.companyId;
    data['deviceTypeId'] = this.deviceTypeId;
    data['isPaired'] = this.isPaired;
    data['pairedBy'] = this.pairedBy;
    data['testedBy'] = this.testedBy;
    data['createdDateTime'] = this.createdDateTime;
    data['createdBy'] = this.createdBy;
    data['updatedDateTime'] = this.updatedDateTime;
    data['updatedBy'] = this.updatedBy;
    data['deletedDateTime'] = this.deletedDateTime;
    data['deletedBy'] = this.deletedBy;
    data['pairedByNavigation'] = this.pairedByNavigation;
    data['testedByNavigation'] = this.testedByNavigation;
    if (this.productionDetails != null) {
      data['productionDetails'] =
          this.productionDetails!.map((v) => v.toJson()).toList();
    }
    if (this.roomCmacs != null) {
      data['roomCmacs'] = this.roomCmacs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}