import 'dart:convert';
/// applicationId : "string"
/// id : 3
/// deletedDateTime : "2023-01-19T12:30:08.995Z"
/// deletedBy : 3

DeleteSwitchModel deleteSwitchModelFromJson(String str) => DeleteSwitchModel.fromJson(json.decode(str));
String deleteSwitchModelToJson(DeleteSwitchModel data) => json.encode(data.toJson());
class DeleteSwitchModel {
  DeleteSwitchModel({
      String? applicationId, 
      int? id, 
      String? deletedDateTime, 
      int? deletedBy,}){
    _applicationId = applicationId;
    _id = id;
    _deletedDateTime = deletedDateTime;
    _deletedBy = deletedBy;
}

  DeleteSwitchModel.fromJson(dynamic json) {
    _applicationId = json['applicationId'];
    _id = json['id'];
    _deletedDateTime = json['deletedDateTime'];
    _deletedBy = json['deletedBy'];
  }
  String? _applicationId;
  int? _id;
  String? _deletedDateTime;
  int? _deletedBy;
DeleteSwitchModel copyWith({  String? applicationId,
  int? id,
  String? deletedDateTime,
  int? deletedBy,
}) => DeleteSwitchModel(  applicationId: applicationId ?? _applicationId,
  id: id ?? _id,
  deletedDateTime: deletedDateTime ?? _deletedDateTime,
  deletedBy: deletedBy ?? _deletedBy,
);
  String? get applicationId => _applicationId;
  int? get id => _id;
  String? get deletedDateTime => _deletedDateTime;
  int? get deletedBy => _deletedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationId'] = _applicationId;
    map['id'] = _id;
    map['deletedDateTime'] = _deletedDateTime;
    map['deletedBy'] = _deletedBy;
    return map;
  }

}