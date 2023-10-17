class test {
  bool? flag;

  test({this.flag});

  test.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    return data;
  }
}