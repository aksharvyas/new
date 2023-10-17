
class ResponseSignup {
  var data;
  Meta? meta;

  ResponseSignup({this.data, required this.meta});

  ResponseSignup.fromJson(Map<String, dynamic> json) {

    data = json['data'] != null ? json['data'] : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? message;
  int? code;

  Meta({this.message, this.code, });

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}















































class RequestSignUp {
  String? name;
  String? password;
  String? email;
  String? device_id;
  String? device_type;
  String? firebase_id;
  String? firebase_token;
  String? image;

  RequestSignUp({required this.name,required this.password,required this.email,required this.device_id,
    required this.device_type,required this.firebase_id,required this.firebase_token, required this.image});

  RequestSignUp.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    password = json['password'];
    email = json['email'];
    firebase_id = json['firebase_id'];
    firebase_token = json['firebase_token'];
    device_id = json['device_id'];
    device_type = json['device_type'];
    image=json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['device_id'] = this.device_id;
    data['device_type'] = this.device_type;
    data['firebase_id'] = this.firebase_id;
    data['firebase_token'] = this.firebase_token;
    data['image']=this.image;
    return data;
  }
}