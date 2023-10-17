import 'package:flutter/material.dart';

import 'widget.dart';

class DialogRadioCheckBox extends StatefulWidget {

  double checkboxWidth;
  double checkboxHeight;
  bool isChecked;
  VoidCallback onTap;

  DialogRadioCheckBox(this.checkboxWidth, this.checkboxHeight, this.isChecked, this.onTap, {Key? key}) : super(key: key);

  @override
  State<DialogRadioCheckBox> createState() => _DialogRadioCheckBoxState();
}

class _DialogRadioCheckBoxState extends State<DialogRadioCheckBox> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        setState(() {
          widget.isChecked = !widget.isChecked;
          if(widget.isChecked){
            widget.onTap();
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(widget.isChecked ? "assets/images/checkbox_on.png" : "assets/images/checkbox_off.png",
              height: getHeight(screenHeight, widget.checkboxHeight),
              width: getWidth(screenWidth, widget.checkboxWidth),
              fit: BoxFit.cover),
          if(widget.isChecked) Image.asset("assets/images/tick.png",
              height: getHeight(screenHeight, 7.96),
              width: getWidth(screenWidth, 11.28),
              fit: BoxFit.cover),
        ],
      ),
    );
  }
}
