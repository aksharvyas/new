import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/utils/Constants.dart';

import '../../utils/Utils.dart';
import 'widget.dart';

class DialogListButton extends StatefulWidget {

  String buttonText;
  double buttonWidth;
  double buttonHeight;
  double fontSize;
  VoidCallback onTap;
  bool? tapped;
  bool? selected;

  DialogListButton(this.buttonText, this.buttonWidth, this.buttonHeight, this.fontSize, this.onTap, {this.tapped, this.selected, Key? key}) : super(key: key);

  @override
  State<DialogListButton> createState() => _DialogListButtonState();
}

class _DialogListButtonState extends State<DialogListButton> {

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    selected = widget.selected ?? false;
    return GestureDetector(
      onTap:(){
        Utils.vibrateSound();
        widget.onTap();
      },
      child: Stack(
        //alignment: Alignment.center,
        children: [
          Image.asset(selected ? selectedButtonImage : unSelectedButtonImage,
              height: getHeight(screenHeight, widget.buttonHeight),
              width: getWidth(screenWidth, widget.buttonWidth),
              fit: BoxFit.fill),
          SizedBox(
            height: getHeight(screenHeight, widget.buttonHeight),
            width: getWidth(screenWidth, widget.buttonWidth),
            child: Align(
              //alignment: Alignment.center,
              child: Text(widget.buttonText,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      //fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: getAdaptiveTextSize(context, widget.fontSize)),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
