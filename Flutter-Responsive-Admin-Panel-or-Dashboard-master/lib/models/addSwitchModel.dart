class AddSwitchModel {
  String? applicationId;
  String? prifix;
  String? switchName;
  String? buttonImage;
  String? createdDateTime;
  int? createdBy;

  AddSwitchModel(
      {required this.applicationId,
        required this.prifix,
        required this.switchName,
        required this.buttonImage,
        required this.createdDateTime,
        required this.createdBy});

  AddSwitchModel.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    prifix = json['prifix'];
    switchName = json['switchName'];
    buttonImage = json['buttonImage'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['prifix'] = this.prifix;
    data['switchName'] = this.switchName;
    data['buttonImage'] = this.buttonImage;
    data['createdDateTime'] = this.createdDateTime;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
