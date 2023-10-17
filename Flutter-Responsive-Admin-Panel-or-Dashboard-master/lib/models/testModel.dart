import 'dart:convert';
/// name : "Afzal Ali"
/// avatar : "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/501.jpg"
/// qualifications : [{"degree":"Master","completionData":"01-01-2025"}]

TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str));
String testModelToJson(TestModel data) => json.encode(data.toJson());
class TestModel {
  TestModel({
      String? name, 
      String? avatar, 
      List<Qualifications>? qualifications,}){
    _name = name;
    _avatar = avatar;
    _qualifications = qualifications;
}

  TestModel.fromJson(dynamic json) {
    _name = json['name'];
    _avatar = json['avatar'];
    if (json['qualifications'] != null) {
      _qualifications = [];
      json['qualifications'].forEach((v) {
        _qualifications?.add(Qualifications.fromJson(v));
      });
    }
  }
  String? _name;
  String? _avatar;
  List<Qualifications>? _qualifications;
TestModel copyWith({  String? name,
  String? avatar,
  List<Qualifications>? qualifications,
}) => TestModel(  name: name ?? _name,
  avatar: avatar ?? _avatar,
  qualifications: qualifications ?? _qualifications,
);
  String? get name => _name;
  String? get avatar => _avatar;
  List<Qualifications>? get qualifications => _qualifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['avatar'] = _avatar;
    if (_qualifications != null) {
      map['qualifications'] = _qualifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// degree : "Master"
/// completionData : "01-01-2025"

Qualifications qualificationsFromJson(String str) => Qualifications.fromJson(json.decode(str));
String qualificationsToJson(Qualifications data) => json.encode(data.toJson());
class Qualifications {
  Qualifications({
      String? degree, 
      String? completionData,}){
    _degree = degree;
    _completionData = completionData;
}

  Qualifications.fromJson(dynamic json) {
    _degree = json['degree'];
    _completionData = json['completionData'];
  }
  String? _degree;
  String? _completionData;
Qualifications copyWith({  String? degree,
  String? completionData,
}) => Qualifications(  degree: degree ?? _degree,
  completionData: completionData ?? _completionData,
);
  String? get degree => _degree;
  String? get completionData => _completionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['degree'] = _degree;
    map['completionData'] = _completionData;
    return map;
  }

}