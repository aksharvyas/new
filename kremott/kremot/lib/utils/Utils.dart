import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import 'Constants.dart';
import 'Countries.dart';

class Utils {
  static void showDialog(BuildContext context, RoutePageBuilder pageBuilder) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: animatedDuration),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: pageBuilder,
    );
  }

  static Future<void> delayShowDialog() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  static printMsg(dynamic msg) {
    if (kDebugMode) {
      print(msg);
    }
  }

  static showSnackBar(BuildContext context, dynamic msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void changeSystemStatusColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color, //i like transaparent :-)
      systemNavigationBarColor: color, // navigation bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  static void changeSystemStatusColorTransparent(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //i like transaparent :-)
      systemNavigationBarColor: color, // navigation bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Brightness.light,//navigation bar icons' color
    ));
  }

  static void toastMessage(bool success, String message, BuildContext context) {
    ScaffoldMessenger.of(context!)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(duration: Duration(seconds: 5),
          content: Container(
            color: success ? Colors.green : Colors.red,
            padding: const EdgeInsets.all(10),
            child: Text(
              message,
            ),
          ),
        ),
      );
  }

  static showUtilDialog(BuildContext context, dynamic value) {
    /*showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return value;
        }).then((value) => value);*/

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: value,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return value;
        });
  }

  static void vibrateSound() {
    Vibration.vibrate(duration: 100);
  }

  static double setAverageRating(List<int> ratings) {
    var avgRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      avgRating = avgRating + ratings[i];
    }
    return double.parse((avgRating / ratings.length).toStringAsFixed(1));
  }

  static Map<String, String>? separatePhoneAndDialCode(
      String phoneWithDialCode) {
    Map<String, String> foundedCountry = {};
    for (var country in Countries.allCountries) {
      String dialCode = country["dial_code"].toString();
      if (phoneWithDialCode.contains(dialCode)) {
        foundedCountry = country;
      }
    }
    print("PHONE: " + foundedCountry.toString());
    if (foundedCountry.isNotEmpty) {
      var dialCode = phoneWithDialCode.substring(
        0,
        foundedCountry["dial_code"]!.length,
      );
      var phoneNumberWithoutDialCode = phoneWithDialCode.substring(
        foundedCountry["dial_code"]!.length,
      );

      foundedCountry["phone"] = phoneNumberWithoutDialCode;
      print({dialCode, phoneNumberWithoutDialCode});
    }

    return foundedCountry;
  }
}
