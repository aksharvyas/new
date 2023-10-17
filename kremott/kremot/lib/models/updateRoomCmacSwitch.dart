class UpdateRoomCmacSwitch {
  String? applicationId;
  int? id;
  String? switchDisplayName;
  String? updatedBy;
  String? updatedDateTime;
  String? roomCmacUpdateSwitchName;
  UpdateRoomCmacSwitch(
      {this.applicationId,
        this.id,
        this.switchDisplayName,
        this.updatedBy,
        this.updatedDateTime, this.roomCmacUpdateSwitchName});

  UpdateRoomCmacSwitch.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    id = json['id'];
    switchDisplayName = json['switchDisplayName'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    roomCmacUpdateSwitchName=json['roomCmacUpdateSwitchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['id'] = this.id;
    data['switchDisplayName'] = this.switchDisplayName;
    data['updatedBy'] = this.updatedBy;
    data['updatedDateTime'] = this.updatedDateTime;
    data['roomCmacUpdateSwitchName']=this.roomCmacUpdateSwitchName;
    return data;
  }
}