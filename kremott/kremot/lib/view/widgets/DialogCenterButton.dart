import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/utils/Constants.dart';

import '../../utils/Utils.dart';
import 'widget.dart';

class DialogCenterButton extends StatefulWidget {
  String buttonText;
  double buttonWidth;
  double buttonHeight;
  double fontSize;
  Color? fontColor;
  Function onTap;
  bool? tapped;
  bool? selected;

  DialogCenterButton(this.buttonText, this.buttonWidth, this.buttonHeight,
      this.fontSize, this.onTap,
      {this.fontColor, this.tapped, this.selected, Key? key})
      : super(key: key);

  @override
  State<DialogCenterButton> createState() => _DialogCenterButtonState();
}

class _DialogCenterButtonState extends State<DialogCenterButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    selected = widget.selected ?? false;
    return GestureDetector(
      onTap: () {

        bool changeButton = widget.tapped ?? false;
        if (changeButton) {
          setState(() {
            selected = !selected;
          });
        }
        widget.onTap(selected);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(selected ? selectedButtonImage : unSelectedButtonImage,
              height: getHeight(screenHeight, widget.buttonHeight),
              width: getWidth(screenWidth, widget.buttonWidth),
              fit: BoxFit.fill),
          Container(
            height: getHeight(screenHeight, widget.buttonHeight),
            width: getWidth(screenWidth, widget.buttonWidth),
            padding: EdgeInsets.symmetric(horizontal: getWidth(screenWidth, 1), vertical: getHeight(screenHeight, 3)),
            child: Align(
              alignment: Alignment.center,
              child: Text(widget.buttonText,
                  style: TextStyle(
                      color: widget.fontColor ?? textColor,
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
