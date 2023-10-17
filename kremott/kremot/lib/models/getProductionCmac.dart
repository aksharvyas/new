class GetProductionCmac {
  GetProductionCmac({
    required this.value,
    required this.formatters,
    required this.contentTypes,
    this.declaredType,
    required this.statusCode,
  });
  late final Value value;
  late final List<dynamic> formatters;
  late final List<dynamic> contentTypes;
  late final Null declaredType;
  late final int statusCode;

  GetProductionCmac.fromJson(Map<String, dynamic> json){
    value = Value.fromJson(json['value']);
    formatters = List.castFrom<dynamic, dynamic>(json['formatters']);
    contentTypes = List.castFrom<dynamic, dynamic>(json['contentTypes']);
    declaredType = null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value.toJson();
    _data['formatters'] = formatters;
    _data['contentTypes'] = contentTypes;
    _data['declaredType'] = declaredType;
    _data['statusCode'] = statusCode;
    return _data;
  }
}

class Value {
  Value({
    required this.production,
    required this.meta,
  });
  late final Production production;
  late final Meta meta;

  Value.fromJson(Map<String, dynamic> json){
    production = Production.fromJson(json['production']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['production'] = production.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Production {
  Production({
    required this.id,
    required this.cmacId,
    required this.companyId,
    required this.deviceTypeId,
    required this.isPaired,
    this.pairedBy,
    required this.testedBy,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deletedDateTime,
    this.deletedBy,
    this.pairedByNavigation,
    this.testedByNavigation,
    required this.productionDetails,
    required this.roomCmacs,
  });
  late final int id;
  late final String cmacId;
  late final int companyId;
  late final int deviceTypeId;
  late final bool isPaired;
  late final Null pairedBy;
  late final int testedBy;
  late final Null createdDateTime;
  late final Null createdBy;
  late final Null updatedDateTime;
  late final Null updatedBy;
  late final Null deletedDateTime;
  late final Null deletedBy;
  late final Null pairedByNavigation;
  late final Null testedByNavigation;
  late final List<dynamic> productionDetails;
  late final List<dynamic> roomCmacs;

  Production.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cmacId = json['cmacId'];
    companyId = json['companyId'];
    deviceTypeId = json['deviceTypeId'];
    isPaired = json['isPaired'];
    pairedBy = null;
    testedBy = json['testedBy'];
    createdDateTime = null;
    createdBy = null;
    updatedDateTime = null;
    updatedBy = null;
    deletedDateTime = null;
    deletedBy = null;
    pairedByNavigation = null;
    testedByNavigation = null;
    productionDetails = List.castFrom<dynamic, dynamic>(json['productionDetails']);
    roomCmacs = List.castFrom<dynamic, dynamic>(json['roomCmacs']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cmacId'] = cmacId;
    _data['companyId'] = companyId;
    _data['deviceTypeId'] = deviceTypeId;
    _data['isPaired'] = isPaired;
    _data['pairedBy'] = pairedBy;
    _data['testedBy'] = testedBy;
    _data['createdDateTime'] = createdDateTime;
    _data['createdBy'] = createdBy;
    _data['updatedDateTime'] = updatedDateTime;
    _data['updatedBy'] = updatedBy;
    _data['deletedDateTime'] = deletedDateTime;
    _data['deletedBy'] = deletedBy;
    _data['pairedByNavigation'] = pairedByNavigation;
    _data['testedByNavigation'] = testedByNavigation;
    _data['productionDetails'] = productionDetails;
    _data['roomCmacs'] = roomCmacs;
    return _data;
  }
}

class Meta {
  Meta({
    required this.message,
    required this.status,
    required this.code,
  });
  late final String message;
  late final String status;
  late final int code;

  Meta.fromJson(Map<String, dynamic> json){
    message = json['message'];
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['code'] = code;
    return _data;
  }
}