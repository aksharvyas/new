import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/view/widgets/widget.dart';

import '../../res/AppDimensions.dart';

class DialogNote extends StatelessWidget {

  double xPosition;
  double yPosition;
  String note;
  DialogNote(this.xPosition, this.yPosition, this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Positioned.fill(
      left: getX(screenWidth, 23),
      right: getX(screenWidth, 23),
      top: getY(screenHeight, 439),
      child: Center(
        child: Text(note,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: getAdaptiveTextSize(context, noteTextSize),
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.justify),
      ),

    );
  }
}
