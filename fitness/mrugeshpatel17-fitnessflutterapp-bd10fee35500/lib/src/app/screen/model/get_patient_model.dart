class ResponceGetPatient {
  GetPatientData? data;
  Meta? meta;

  ResponceGetPatient({this.data, this.meta});

  ResponceGetPatient.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetPatientData.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class GetPatientData {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  int? gender;
  String? phone;
  String? dateOfBirth;

  GetPatientData(
      {required this.id,
        required this.userId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.image,
        required this.gender,
        required this.phone,
        required this.dateOfBirth});

  GetPatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    return data;
  }
}

class Meta {
  String? message;
  int? code;

  Meta({this.message, this.code});

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
