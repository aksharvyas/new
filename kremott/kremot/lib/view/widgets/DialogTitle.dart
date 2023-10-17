import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';

import 'widget.dart';

class DialogTitle extends StatelessWidget {

  double xPosition;
  double yPosition;
  String title;
  double fontSize;
  String fontFamily;
  String? alignment;
  DialogTitle(this.xPosition, this.yPosition, this.title, this.fontSize, this.fontFamily, {this.alignment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Positioned.fill(
      top: getY(screenHeight, 11),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getX(screenWidth, 5.0)),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(title,
              style: TextStyle(
                color: dialogTitleColor,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
                fontStyle: FontStyle.normal,
                fontSize: getAdaptiveTextSize(context, fontSize),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center),
        ),
      ),
    );
    // Positioned.fill(
    //   left: getX(screenWidth, xPosition),
    //   top: getY(screenHeight, yPosition),
    //   child:
    //   Text(title,
    //       style: TextStyle(
    //         color: const Color(0xffffffff),
    //         fontWeight: FontWeight.w400,
    //         fontFamily: fontFamily,
    //         fontStyle: FontStyle.normal,
    //         fontSize: getAdaptiveTextSize(context, fontSize),
    //         decoration: TextDecoration.none,
    //       ),
    //       textAlign: TextAlign.justify),
    //
    // );
  }
}
