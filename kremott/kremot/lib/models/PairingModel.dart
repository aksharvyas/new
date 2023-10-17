class CommunicationCommand {
  String? key;
  String? commandCode;
  String? ssidOfWifiRouter;
  String? password;


  CommunicationCommand(
      {this.key,this.commandCode,this.ssidOfWifiRouter,this.password});

  CommunicationCommand.fromJson(Map<String, dynamic> json) {
    key = json['CMD'];
    commandCode = json['CODE'];
    ssidOfWifiRouter=json['SSID OF WIFI ROUTER'];
    password=json['PASSWORD'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CMD'] = key;
    data['CODE'] = commandCode;
    data['SSID OF WIFI ROUTER']=ssidOfWifiRouter;
    data['PASSWORD']=password;
    return data;
  }
}

class CommunicationCommandPairing {
  String? CMID;
  String? commandCode;


  CommunicationCommandPairing(
      {this.CMID,this.commandCode});

  CommunicationCommandPairing.fromJson(Map<String, dynamic> json) {
    CMID = json['CMID'];
    commandCode = json['CC'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CMID'] = CMID;
    data['CC'] = commandCode;
    return data;
  }
}

class CommunicationCommandDevice {
  String? key;
  String? commandCode;
  String? deviceId;
  String? companyId;
  String? cmacId;


  CommunicationCommandDevice(
      {this.key,this.commandCode,this.deviceId,this.companyId,this.cmacId});

  CommunicationCommandDevice.fromJson(Map<String, dynamic> json) {
    key = json['CMD'];
    commandCode = json['CODE'];
    deviceId = json['DEVICE ID'];
    companyId = json['COMPANY ID'];
    cmacId = json['CMACID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CMD'] = key;
    data['CODE'] = commandCode;
    data['DEVICE ID'] = deviceId;
    data['COMPANY ID'] = companyId;
    data['CMACID'] = cmacId;
    return data;
  }
}

class LedStopBlinking {
  String? key;
  String? commandCode;
  String? homeId;
  String? roomId;
  String? mobileNumber;
  String? appId;


  LedStopBlinking(
      {this.key,homeId,this.roomId,this.mobileNumber,this.appId});

  LedStopBlinking.fromJson(Map<String, dynamic> json) {
    key = json['CC'];
    homeId = json['HMID'];
    roomId = json['RMID'];
    mobileNumber = json['MN'];
    appId = json['AID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CC'] = key;
    data['HMID'] = homeId;
    data['RMID'] = roomId;
    data['MN'] = mobileNumber;
    data['AID'] = appId;
    return data;
  }
}

class HomeStatus {
  String? key;
  String? commandCode;
  String? mobileNumber;
  String? appId;
  String? roomId;


  HomeStatus(
      {this.key,this.commandCode,this.mobileNumber,this.appId,this.roomId,});

  HomeStatus.fromJson(Map<String, dynamic> json) {
    key = json['CMD'];
    commandCode = json['CODE'];
    mobileNumber = json['MOBILE NUMBER'];
    appId = json['APPID'];
    roomId = json['ROOMID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['KEY'] = key;
    data['COMMAND CODE'] = commandCode;
    data['MOBILE NUMBER'] = mobileNumber;
    data['APPID'] = appId;
    data['ROOMID'] = roomId;
    return data;
  }
}



class DataSave {
  String? key;
  String? commandCode;
  String? deviceId;
  String? companyId;
  String? cmacId;
  String? ssidOfWifiRouter;
  String? homeId;
  String? roomId;
  String? mobileNumber;
  String? appId;
  String? gpsLocation;


  DataSave(
      {this.key,this.commandCode,this.deviceId,this.companyId,this.cmacId,this.ssidOfWifiRouter,this.homeId,this.roomId,this.mobileNumber,this.appId,this.gpsLocation});

  DataSave.fromJson(Map<String, dynamic> json) {
    key = json['KEY'];
    commandCode = json['COMMAND CODE'];
    deviceId = json['DEVICE ID'];
    companyId = json['COMPANY ID'];
    cmacId = json['CMACID'];
    ssidOfWifiRouter=json['SSID OF WIFI ROUTER'];
    homeId=json['HOMEID'];
    roomId = json['ROOMID'];
    mobileNumber = json['MOBILE NUMBER'];
    appId = json['APPID'];
    gpsLocation=json['GPS LOCATION'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['KEY'] = key;
    data['COMMAND CODE'] = commandCode;
    data['DEVICE ID'] = deviceId;
    data['COMPANY ID'] = companyId;
    data['CMACID']=cmacId;
    data['SSID OF WIFI ROUTER']=ssidOfWifiRouter;
    data['HOMEID'] = homeId;
    data['ROOMID'] = roomId;
    data['MOBILE NUMBER'] = mobileNumber;
    data['APPID'] = appId;
    data['GPS LOCATION']=gpsLocation;
    return data;
  }
}

class LogSave {
  String? key;
  String? commandCode;
  String? cmacId;


  LogSave(
      {this.key,this.commandCode,this.cmacId});

  LogSave.fromJson(Map<String, dynamic> json) {
    key = json['KEY'];
    commandCode = json['COMMAND CODE'];
    cmacId = json['CMACID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['KEY'] = key;
    data['COMMAND CODE'] = commandCode;
    data['CMACID'] = cmacId;
    return data;
  }
}

class PairCommand {
  String? cc;


  PairCommand(
      {this.cc});

  PairCommand.fromJson(Map<String, dynamic> json) {
    cc = json['CC'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CC'] = cc;
    return data;
  }
}

class PairWithWifi {
  String? CMID;
  String? CC;
  String? SSID;
  String? PW;


  PairWithWifi(
      {this.CMID,this.CC,this.SSID,this.PW});

  PairWithWifi.fromJson(Map<String, dynamic> json) {
    CMID = json['CMID'];
    CC = json['CC'];
    SSID = json['SSID'];
    PW = json['PW'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CMID'] = CMID;
    data['CC'] = CC;
    data['SSID'] = SSID;
    data['PW'] = PW;

    return data;
  }
}class PairA5Command {
  String? hmid;
  String? mn;
  String? aid;
  String? cc;
  List<String>? oPR;


  PairA5Command(
      {this.hmid,this.mn,this.aid,this.oPR,this.cc});

  PairA5Command.fromJson(Map<String, dynamic> json) {
    hmid = json['HMID'];
    mn = json['MN'];
    aid = json['AID'];
    oPR = json['OPR'].cast<String>();
    cc = json['CC'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['HMID'] = hmid;
    data['MN'] = mn;
    data['AID'] = aid;
    data['OPR'] = this.oPR;
    data['CC'] = cc;

    return data;
  }
}