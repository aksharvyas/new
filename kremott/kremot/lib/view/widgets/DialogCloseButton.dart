import 'package:flutter/material.dart';

import 'widget.dart';

class DialogCloseButton extends StatefulWidget {
  double xPosition;
  double yPosition;
  VoidCallback onTap;

  DialogCloseButton(this.xPosition, this.yPosition, this.onTap, {Key? key}) : super(key: key);

  @override
  State<DialogCloseButton> createState() => _DialogCloseButtonState();
}

class _DialogCloseButtonState extends State<DialogCloseButton> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
        right: getX(screenWidth, 11),
        top: getY(screenHeight, 11),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Image.asset(
            "assets/images/close.png",
            width: getWidth(screenWidth, 20),
            height: getHeight(screenHeight, 20),
            fit: BoxFit.fill,
          ),
        ));
  }
}
