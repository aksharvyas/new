import 'dart:convert';

class ResponseListSwitch {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  Null? declaredType;
  int? statusCode;

  ResponseListSwitch(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  ResponseListSwitch.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    declaredType = json['declaredType'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    data['declaredType'] = this.declaredType;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Value {
  List<SwitchViewModel>? switchViewModel;
  Meta? meta;

  Value({this.switchViewModel, this.meta});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['switchViewModel'] != null) {
      switchViewModel = <SwitchViewModel>[];
      json['switchViewModel'].forEach((v) {
        switchViewModel!.add(new SwitchViewModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.switchViewModel != null) {
      data['switchViewModel'] =
          this.switchViewModel!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class SwitchViewModel {
  int? id;
  String? prifix;
  String? switchName;
  String? buttonImage;

  SwitchViewModel({this.id, this.prifix, this.switchName, this.buttonImage});

  SwitchViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prifix = json['prifix'];
    switchName = json['switchName'];
    buttonImage = json['buttonImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prifix'] = this.prifix;
    data['switchName'] = this.switchName;
    data['buttonImage'] = this.buttonImage;
    return data;
  }


  static Map<String, dynamic> toMap(SwitchViewModel switchViewModel) => {
    'id': switchViewModel.id,
    'prifix': switchViewModel.prifix,
    'switchName': switchViewModel.switchName,
    'buttonImage': switchViewModel.buttonImage,
  };

  static String encode(List<SwitchViewModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => SwitchViewModel.toMap(music))
        .toList(),
  );

  static List<SwitchViewModel> decode(String? musics) =>
      (json.decode(musics!) as List<dynamic>)
          .map<SwitchViewModel>((item) => SwitchViewModel.fromJson(item))
          .toList();

}

class Meta {
  String? message;
  String? status;
  int? code;

  Meta({this.message, this.status, this.code});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}