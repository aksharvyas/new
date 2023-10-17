import 'dart:convert';
/// applicationId : "abc"
/// homeId : "3fa85f64-5717-4562-b3fc-2c963f66afa1"
/// NetworkString : ""

AddHomeNetworkStringModel addHomeNetworkStringModelFromJson(String str) => AddHomeNetworkStringModel.fromJson(json.decode(str));
String addHomeNetworkStringModelToJson(AddHomeNetworkStringModel data) => json.encode(data.toJson());
class AddHomeNetworkStringModel {
  AddHomeNetworkStringModel({
      String? applicationId, 
      String? homeId, 
      String? networkString,}){
    _applicationId = applicationId;
    _homeId = homeId;
    _networkString = networkString;
}

  AddHomeNetworkStringModel.fromJson(dynamic json) {
    _applicationId = json['applicationId'];
    _homeId = json['homeId'];
    _networkString = json['NetworkString'];
  }
  String? _applicationId;
  String? _homeId;
  String? _networkString;
AddHomeNetworkStringModel copyWith({  String? applicationId,
  String? homeId,
  String? networkString,
}) => AddHomeNetworkStringModel(  applicationId: applicationId ?? _applicationId,
  homeId: homeId ?? _homeId,
  networkString: networkString ?? _networkString,
);
  String? get applicationId => _applicationId;
  String? get homeId => _homeId;
  String? get networkString => _networkString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationId'] = _applicationId;
    map['homeId'] = _homeId;
    map['NetworkString'] = _networkString;
    return map;
  }

}