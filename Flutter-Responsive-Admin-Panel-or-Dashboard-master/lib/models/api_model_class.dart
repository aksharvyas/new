// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
  String applicationId;
  DateTime logDateTime;
  String mobileNo;
  String cmacId;
  String homeId;
  String roomId;
  String sourceId;
  int companyId;
  int deviceId;
  String command;
  String value1;
  String value2;
  String value3;
  String value4;
  String value5;
  String value6;
  String value7;
  String value8;
  String value9;
  String value10;
  String value11;
  String value12;
  String value13;
  String value14;
  String value15;
  String value16;
  String value17;
  String value18;
  String value19;
  String value20;
  String value21;
  String value22;
  String value23;
  String value24;
  String value25;
  String value26;
  String value27;
  String value28;
  String value29;
  String value30;
  String value31;
  String value32;

  ApiModel({
    required this.applicationId,
    required this.logDateTime,
    required this.mobileNo,
    required this.cmacId,
    required this.homeId,
    required this.roomId,
    required this.sourceId,
    required this.companyId,
    required this.deviceId,
    required this.command,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
    required this.value7,
    required this.value8,
    required this.value9,
    required this.value10,
    required this.value11,
    required this.value12,
    required this.value13,
    required this.value14,
    required this.value15,
    required this.value16,
    required this.value17,
    required this.value18,
    required this.value19,
    required this.value20,
    required this.value21,
    required this.value22,
    required this.value23,
    required this.value24,
    required this.value25,
    required this.value26,
    required this.value27,
    required this.value28,
    required this.value29,
    required this.value30,
    required this.value31,
    required this.value32,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        applicationId: json["applicationId"],
        logDateTime: DateTime.parse(json["LogDateTime"]),
        mobileNo: json["mobileNo"],
        cmacId: json["cmacId"],
        homeId: json["HomeId"],
        roomId: json["RoomId"],
        sourceId: json["sourceId"],
        companyId: json["companyId"],
        deviceId: json["deviceId"],
        command: json["command"],
        value1: json["value1"],
        value2: json["value2"],
        value3: json["value3"],
        value4: json["value4"],
        value5: json["value5"],
        value6: json["value6"],
        value7: json["value7"],
        value8: json["value8"],
        value9: json["value9"],
        value10: json["value10"],
        value11: json["value11"],
        value12: json["value12"],
        value13: json["value13"],
        value14: json["value14"],
        value15: json["value15"],
        value16: json["value16"],
        value17: json["value17"],
        value18: json["value18"],
        value19: json["value19"],
        value20: json["value20"],
        value21: json["value21"],
        value22: json["value22"],
        value23: json["value23"],
        value24: json["value24"],
        value25: json["value25"],
        value26: json["value26"],
        value27: json["value27"],
        value28: json["value28"],
        value29: json["value29"],
        value30: json["value30"],
        value31: json["value31"],
        value32: json["value32"],
      );

  Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "LogDateTime":
            "${logDateTime.year.toString().padLeft(4, '0')}-${logDateTime.month.toString().padLeft(2, '0')}-${logDateTime.day.toString().padLeft(2, '0')}",
        "mobileNo": mobileNo,
        "cmacId": cmacId,
        "HomeId": homeId,
        "RoomId": roomId,
        "sourceId": sourceId,
        "companyId": companyId,
        "deviceId": deviceId,
        "command": command,
        "value1": value1,
        "value2": value2,
        "value3": value3,
        "value4": value4,
        "value5": value5,
        "value6": value6,
        "value7": value7,
        "value8": value8,
        "value9": value9,
        "value10": value10,
        "value11": value11,
        "value12": value12,
        "value13": value13,
        "value14": value14,
        "value15": value15,
        "value16": value16,
        "value17": value17,
        "value18": value18,
        "value19": value19,
        "value20": value20,
        "value21": value21,
        "value22": value22,
        "value23": value23,
        "value24": value24,
        "value25": value25,
        "value26": value26,
        "value27": value27,
        "value28": value28,
        "value29": value29,
        "value30": value30,
        "value31": value31,
        "value32": value32,
      };
}
