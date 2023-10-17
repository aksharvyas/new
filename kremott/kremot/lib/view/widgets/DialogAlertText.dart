import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/view/widgets/widget.dart';

import '../../res/AppDimensions.dart';

class DialogAlertText extends StatelessWidget {

  double xPosition;
  double yPosition;
  String alertText;
  DialogAlertText(this.xPosition, this.yPosition, this.alertText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Positioned.fill(
      left: getX(screenWidth, 46),
      right: getX(screenWidth, 46),
      top: getY(screenHeight, 12),
      child: Text(alertText,
          style: TextStyle(
            color: dialogTitleColor,
            fontWeight: FontWeight.bold,
            //fontFamily: "Inter",
            fontStyle: FontStyle.normal,
            fontSize: getAdaptiveTextSize(context, dialogAlertTextSize),
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center),

    );
  }
}
