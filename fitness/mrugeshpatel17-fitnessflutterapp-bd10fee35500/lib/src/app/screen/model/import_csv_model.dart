



class ResponseImportCsv{
  var data;
  Meta? meta;

  ResponseImportCsv({this.data, this.meta});

  ResponseImportCsv.fromJson(Map<String, dynamic> json) {
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

  Meta({this.code, this.message});

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
