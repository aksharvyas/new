import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/utils/Constants.dart';

import 'widget.dart';

class CustomAlertDialog extends StatefulWidget {
  double dialogWidth;
  double dialogHeight;
  Widget childWidget;
  CustomAlertDialog(this.dialogWidth, this.dialogHeight, this.childWidget,{Key? key}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: const Alignment(0.5, 0.25),
      child: Container(
          width: getWidth(screenWidth, alertDialogWidth),
          height: getHeight(screenHeight, alertDialogHeight),
          // padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(14.86390495300293)),
            border: Border.all(
                color: homePageDividerColor, width: 1.0617074966430664),
            // boxShadow: const [
            //   BoxShadow(
            //       color: Color(0x40000000),
            //       offset: Offset(5.308538436889648, 5.308538436889648),
            //       blurRadius: 6.370244979858398,
            //       spreadRadius: 0)
            // ],
            //color: const Color(0xff484949)
            image: const DecorationImage(
                image: AssetImage(alertDialogBg),
                fit: BoxFit.fill
            ),
          ),
//color: Colors.white,

          child: widget.childWidget
      ),
    );
  }
}
