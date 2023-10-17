class RequestCMID {
  String? hMID;
  String? mN;
  String? aID;
  List<String>? oPR;
  String? cC;
  String? total;

  RequestCMID({this.hMID, this.mN, this.aID, this.oPR, this.cC, this.total});

  RequestCMID.fromJson(Map<String, dynamic> json) {
    hMID = json['HMID'];
    mN = json['MN'];
    aID = json['AID'];
    oPR = json['OPR'].cast<String>();
    cC = json['CC'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HMID'] = this.hMID;
    data['MN'] = this.mN;
    data['AID'] = this.aID;
    data['OPR'] = this.oPR;
    data['CC'] = this.cC;
    data['Total'] = this.total;
    return data;
  }
}


class ResponseCMID {
  String? cMID;
  String? cC;
  String? mN;

  ResponseCMID({this.cMID, this.cC, this.mN});

  ResponseCMID.fromJson(Map<String, dynamic> json) {
    cMID = json['CMID'];
    cC = json['CC'];
    mN = json['MN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CMID'] = this.cMID;
    data['CC'] = this.cC;
    data['MN'] = this.mN;
    return data;
  }
}


class RequestJsonCMD {
  int? addr;
  int? cmds;

  RequestJsonCMD({this.addr, this.cmds});

  RequestJsonCMD.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    cmds = json['cmds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr'] = this.addr;
    data['cmds'] = this.cmds;
    return data;
  }
}

class ResponseJsonCMID {
  int? addr;
  int? cmds;

  ResponseJsonCMID({this.addr, this.cmds});

  ResponseJsonCMID.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    cmds = json['cmds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr'] = this.addr;
    data['cmds'] = this.cmds;
    return data;
  }
}