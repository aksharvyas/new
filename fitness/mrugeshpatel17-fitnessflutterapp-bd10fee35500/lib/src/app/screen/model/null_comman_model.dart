
class NullDataCommanModel {
  String? data;
  Meta? meta;

  NullDataCommanModel({required this.data, required this.meta});

  NullDataCommanModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  int? code;
  String? message;

  Meta({required this.code, required this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}