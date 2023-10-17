import 'dart:convert';
/// applicationId : "123"
/// id : 10
/// pairedBy : "3053BC82-A9C5-441B-A7D7-9B690AC0148A"
/// homeId : "4A34F702-DF15-4328-B1AA-6A0C64A14ED6"
/// roomId : "CA7B028E-E75F-470E-BF20-9CF9B71410A0"
/// updatedDateTime : "2022-11-15T06:33:13.390Z"
/// updatedBy : "3053BC82-A9C5-441B-A7D7-9B690AC0148A"

PairProduction pairProductionFromJson(String str) => PairProduction.fromJson(json.decode(str));
String pairProductionToJson(PairProduction data) => json.encode(data.toJson());
class PairProduction {
  PairProduction({
      String? applicationId, 
      num? id, 
      String? pairedBy, 
      String? homeId, 
      String? roomId, 
      String? updatedDateTime, 
      String? updatedBy,}){
    _applicationId = applicationId;
    _id = id;
    _pairedBy = pairedBy;
    _homeId = homeId;
    _roomId = roomId;
    _updatedDateTime = updatedDateTime;
    _updatedBy = updatedBy;
}

  PairProduction.fromJson(dynamic json) {
    _applicationId = json['applicationId'];
    _id = json['id'];
    _pairedBy = json['pairedBy'];
    _homeId = json['homeId'];
    _roomId = json['roomId'];
    _updatedDateTime = json['updatedDateTime'];
    _updatedBy = json['updatedBy'];
  }
  String? _applicationId;
  num? _id;
  String? _pairedBy;
  String? _homeId;
  String? _roomId;
  String? _updatedDateTime;
  String? _updatedBy;
PairProduction copyWith({  String? applicationId,
  num? id,
  String? pairedBy,
  String? homeId,
  String? roomId,
  String? updatedDateTime,
  String? updatedBy,
}) => PairProduction(  applicationId: applicationId ?? _applicationId,
  id: id ?? _id,
  pairedBy: pairedBy ?? _pairedBy,
  homeId: homeId ?? _homeId,
  roomId: roomId ?? _roomId,
  updatedDateTime: updatedDateTime ?? _updatedDateTime,
  updatedBy: updatedBy ?? _updatedBy,
);
  String? get applicationId => _applicationId;
  num? get id => _id;
  String? get pairedBy => _pairedBy;
  String? get homeId => _homeId;
  String? get roomId => _roomId;
  String? get updatedDateTime => _updatedDateTime;
  String? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationId'] = _applicationId;
    map['id'] = _id;
    map['pairedBy'] = _pairedBy;
    map['homeId'] = _homeId;
    map['roomId'] = _roomId;
    map['updatedDateTime'] = _updatedDateTime;
    map['updatedBy'] = _updatedBy;
    return map;
  }

}