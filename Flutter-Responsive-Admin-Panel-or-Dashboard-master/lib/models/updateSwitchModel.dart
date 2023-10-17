import 'dart:convert';
/// applicationId : "string"
/// id : 3
/// prifix : "C"
/// switchName : "Curtain"
/// buttonImage : "path"
/// updatedDateTime : "2023-01-19T12:29:06.902Z"
/// updatedBy : 2

UpdateSwitchModel updateSwitchModelFromJson(String str) => UpdateSwitchModel.fromJson(json.decode(str));
String updateSwitchModelToJson(UpdateSwitchModel data) => json.encode(data.toJson());
class UpdateSwitchModel {
  UpdateSwitchModel({
      String? applicationId, 
      int? id, 
      String? prifix, 
      String? switchName, 
      String? buttonImage, 
      String? updatedDateTime, 
      int? updatedBy,}){
    _applicationId = applicationId;
    _id = id;
    _prifix = prifix;
    _switchName = switchName;
    _buttonImage = buttonImage;
    _updatedDateTime = updatedDateTime;
    _updatedBy = updatedBy;
}

  UpdateSwitchModel.fromJson(dynamic json) {
    _applicationId = json['applicationId'];
    _id = json['id'];
    _prifix = json['prifix'];
    _switchName = json['switchName'];
    _buttonImage = json['buttonImage'];
    _updatedDateTime = json['updatedDateTime'];
    _updatedBy = json['updatedBy'];
  }
  String? _applicationId;
  int? _id;
  String? _prifix;
  String? _switchName;
  String? _buttonImage;
  String? _updatedDateTime;
  int? _updatedBy;
UpdateSwitchModel copyWith({  String? applicationId,
  int? id,
  String? prifix,
  String? switchName,
  String? buttonImage,
  String? updatedDateTime,
  int? updatedBy,
}) => UpdateSwitchModel(  applicationId: applicationId ?? _applicationId,
  id: id ?? _id,
  prifix: prifix ?? _prifix,
  switchName: switchName ?? _switchName,
  buttonImage: buttonImage ?? _buttonImage,
  updatedDateTime: updatedDateTime ?? _updatedDateTime,
  updatedBy: updatedBy ?? _updatedBy,
);
  String? get applicationId => _applicationId;
  int? get id => _id;
  String? get prifix => _prifix;
  String? get switchName => _switchName;
  String? get buttonImage => _buttonImage;
  String? get updatedDateTime => _updatedDateTime;
  int? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationId'] = _applicationId;
    map['id'] = _id;
    map['prifix'] = _prifix;
    map['switchName'] = _switchName;
    map['buttonImage'] = _buttonImage;
    map['updatedDateTime'] = _updatedDateTime;
    map['updatedBy'] = _updatedBy;
    return map;
  }

}