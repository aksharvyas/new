import 'dart:convert';
/// applicationId : "string"
/// cmacID : "eae74350-104f-45c5-904f-bcc1704fefc3"
/// companyId : 1
/// deviceTypeId : 20
/// createdDateTime : "2022-11-15T06:02:18.183Z"
/// createdBy : "3fa85f64-5717-4562-b3fc-2c963f66afa6"

AddProduction addProductionFromJson(String str) => AddProduction.fromJson(json.decode(str));
String addProductionToJson(AddProduction data) => json.encode(data.toJson());
class AddProduction {
  AddProduction({
      String? applicationId, 
      String? cmacID, 
      num? companyId, 
      num? deviceTypeId, 
      String? createdDateTime, 
      String? createdBy,}){
    _applicationId = applicationId;
    _cmacID = cmacID;
    _companyId = companyId;
    _deviceTypeId = deviceTypeId;
    _createdDateTime = createdDateTime;
    _createdBy = createdBy;
}

  AddProduction.fromJson(dynamic json) {
    _applicationId = json['applicationId'];
    _cmacID = json['cmacID'];
    _companyId = json['companyId'];
    _deviceTypeId = json['deviceTypeId'];
    _createdDateTime = json['createdDateTime'];
    _createdBy = json['createdBy'];
  }
  String? _applicationId;
  String? _cmacID;
  num? _companyId;
  num? _deviceTypeId;
  String? _createdDateTime;
  String? _createdBy;
AddProduction copyWith({  String? applicationId,
  String? cmacID,
  num? companyId,
  num? deviceTypeId,
  String? createdDateTime,
  String? createdBy,
}) => AddProduction(  applicationId: applicationId ?? _applicationId,
  cmacID: cmacID ?? _cmacID,
  companyId: companyId ?? _companyId,
  deviceTypeId: deviceTypeId ?? _deviceTypeId,
  createdDateTime: createdDateTime ?? _createdDateTime,
  createdBy: createdBy ?? _createdBy,
);
  String? get applicationId => _applicationId;
  String? get cmacID => _cmacID;
  num? get companyId => _companyId;
  num? get deviceTypeId => _deviceTypeId;
  String? get createdDateTime => _createdDateTime;
  String? get createdBy => _createdBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationId'] = _applicationId;
    map['cmacID'] = _cmacID;
    map['companyId'] = _companyId;
    map['deviceTypeId'] = _deviceTypeId;
    map['createdDateTime'] = _createdDateTime;
    map['createdBy'] = _createdBy;
    return map;
  }

}