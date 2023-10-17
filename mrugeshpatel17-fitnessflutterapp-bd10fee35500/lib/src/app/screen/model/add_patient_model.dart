class AddPatientModel {
  String firstName;
  String lastName;
  String email;
  String phone;
  var gender;
  var birthDate;

  AddPatientModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      this.gender,
      this.birthDate});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['first_name'] =firstName;
    json['last_name'] = lastName;
    json['email'] =email;
    json['phone']=phone;
    json['gender']=gender;
    json['date_of_birth']=birthDate;
    return json;
  }
}




class RequestAddPatient{

  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  var gender;
  var birthDate;
  String? image;
  RequestAddPatient(
      {required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
        this.gender,
        this.birthDate,required this.image});

  RequestAddPatient.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    birthDate = json['date_of_birth'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
     json['first_name'] =firstName;
     json['last_name'] = lastName;
     json['email'] =email;
     json['phone']=phone;
     json['gender']=gender;
     json['date_of_birth']=birthDate;
     json['image']=image;
    return json;
  }


}

class ResponseAddPatient{
  var data;
  Meta? meta;

  ResponseAddPatient({this.data, this.meta});

  ResponseAddPatient.fromJson(Map<String, dynamic> json) {
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
