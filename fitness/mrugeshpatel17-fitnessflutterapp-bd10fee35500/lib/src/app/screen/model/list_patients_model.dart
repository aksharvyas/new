class ResponseListPatients {
  List<ListPatientsData> data=[];
  Links? links;
  Meta? meta;

  ResponseListPatients({required this.data, required this.links, required this.meta});

  ResponseListPatients.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      // data = new List<ListPatientsData>();
      json['data']!.forEach((v) {
        data.add(new ListPatientsData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class ListPatientsData {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  int? gender;
  String? phone;
  String? dateOfBirth;

  ListPatientsData(
      {required this.id,
        required this.userId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.image,
        required this.gender,
        required this.phone,
        required this.dateOfBirth});

  @override
  String toString() {
    return 'ListPatientsData{id: $id, userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, image: $image, gender: $gender, phone: $phone, dateOfBirth: $dateOfBirth}';
  }

  ListPatientsData.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({required this.first, required this.last, required this.prev, required this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  String? perPage;
  int? to;
  int? total;
  String? message;
  int? code;

  Meta(
      {required this.currentPage,
        required this.from,
        required this.lastPage,
        required this.path,
        required this.perPage,
        required this.to,
        required this.total,
        required this.message,
        required this.code});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
