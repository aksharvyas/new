import 'package:flutter/material.dart';

import 'widget.dart';

class DialogCheckBox extends StatefulWidget {

  double checkboxWidth;
  double checkboxHeight;
  bool checked;
  Function onItemTapped;

  DialogCheckBox(this.checkboxWidth, this.checkboxHeight, this.checked, this.onItemTapped, {Key? key}) : super(key: key);

  @override
  State<DialogCheckBox> createState() => _DialogCheckBoxState();
}

class _DialogCheckBoxState extends State<DialogCheckBox> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: (){
          if(widget.checked){
            widget.onItemTapped(false);
          } else{
            widget.onItemTapped(true);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(widget.checked ? "assets/images/checkbox_on.png" : "assets/images/checkbox_off.png",
                height: getHeight(screenHeight, widget.checkboxHeight),
                width: getWidth(screenWidth, widget.checkboxWidth),
                fit: BoxFit.cover),
            if(widget.checked) Image.asset("assets/images/tick.png",
                height: getHeight(screenHeight, 7.96),
                width: getWidth(screenWidth, 11.28),
                fit: BoxFit.fill),
          ],
        )
    );
  }
}
