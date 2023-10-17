import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryColor = Colors.lightBlueAccent;

showToastIconName(FToast fToast,IconData icon,String msg) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.lightBlueAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(msg,style: TextStyle(color: Colors.white),),
        SizedBox(
          width: 4.0,
        ),
        Expanded(child: Icon(icon,color: Colors.white,)),
      ],
    ),
  );


  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );

  // Custom Toast Position
}
showToastSuccess(msg) {
  FToast? fToast;
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.lightBlueAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(FontAwesomeIcons.solidThumbsUp,color: Colors.white,),
        SizedBox(
          width: 12.0,
        ),
        Text("$msg",style: TextStyle(color: Colors.white,fontSize: 16),),
      ],
    ),
  );

  fToast!.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );


}


showToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showToastRed(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white,
    fontSize: 18.0,
  );
}

String? getDeviceType(context){
  if(Theme.of(context).platform==TargetPlatform.iOS){
    return "2";
  }else if(Theme.of(context).platform==TargetPlatform.android){
    return "1";
  }else{
    return null;
  }
}

Future<String> getDeviceId(context) async{

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  }else if (Theme.of(context).platform == TargetPlatform.android){
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }else{
    return "";
  }
}


String? validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern.toString());
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String? validatePassword(String value) {
  print(value);
  final validCharacters = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}');
  if (!validCharacters.hasMatch(value)) {
    return 'Enter valid password';
  } else {
    return null;
  }
}