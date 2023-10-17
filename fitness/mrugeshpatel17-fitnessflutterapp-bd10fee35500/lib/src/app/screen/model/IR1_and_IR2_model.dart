
class IR1AndIR2Model {
  List<Data>? data;
  Meta? meta;

  IR1AndIR2Model({required this.data, required this.meta});

  IR1AndIR2Model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      // data = new List<Data>();
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? ir1Value;
  int? ir2Value;

  Data({required this.ir1Value, required this.ir2Value});

  Data.fromJson(Map<String, dynamic> json) {
    ir1Value = json['ir1_value'];
    ir2Value = json['ir2_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ir1_value'] = this.ir1Value;
    data['ir2_value'] = this.ir2Value;
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





class RequestIR1AndIR2 {
  String? patient_id;
  List<String>? params;


  RequestIR1AndIR2(
      {required this.patient_id,
        required this.params,
      });

  RequestIR1AndIR2.fromJson(Map<String, dynamic> json) {
    patient_id = json['patient_id'];
    params = json['params'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['patient_id'] = patient_id ;
    json['params']= params;
    return json;
  }
}