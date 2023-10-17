import 'dart:convert';


PublishMessage payloadFromJson(String str) => PublishMessage.fromJson(json.decode(str));

String payloadToJson1(PublishMessage data) => json.encode(data.toJson());

class PublishMessage {
  String? homeId;
  String? mobileNumber;
  String? appId;
  String? cmacId;
  String? key;
  String? function;
  String? commandCode;

  PublishMessage({ this.homeId,  this.mobileNumber, this.appId,this.cmacId,this.key,this.function,this.commandCode});

  PublishMessage.fromJson(Map<String, dynamic> json) {
    homeId = json["HOMEID"];
    mobileNumber = json["MOBILE NUMBER"];
    appId=json['APPID'];
    cmacId=json['CMACID'];
    key=json['KEY'];
    function=json['FUNCTION'];
    commandCode=json['COMMAND CODE'];

  }

  Map<String, dynamic> toJson() => {
    "HOMEID": homeId,
    "MOBILE NUMBER": mobileNumber,
    "APPID": appId,
    "CMACID": cmacId,
    "KEY": key,
    "FUNCTION": function,
    "COMMAND CODE": commandCode,
  };


}