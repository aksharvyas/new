import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';

import '../widget.dart';

class HomePageHomeRemoteButtonsWifiSwitchesFan extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  HomePageHomeRemoteButtonsWifiSwitchesFan(this.screenWidth, this.screenHeight, {Key? key}) : super(key: key);

  @override
  State<HomePageHomeRemoteButtonsWifiSwitchesFan> createState() => _HomePageHomeRemoteButtonsWifiSwitchesFanState();
}

class _HomePageHomeRemoteButtonsWifiSwitchesFanState extends State<HomePageHomeRemoteButtonsWifiSwitchesFan> {

  final FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: 1);
  int selectedValue = 2;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: ListWheelScrollView(
          magnification: 2.0,
          onSelectedItemChanged: (x) {
            setState(() {
              selectedValue = x;
            });
          },
          controller: scrollController,
          itemExtent: 25,
          children: List.generate(
              7,
                  (x) => RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: getHeight(widget.screenHeight, 5),
                        bottom: getHeight(widget.screenHeight, 5)),
                    child: AnimatedContainer(
                        decoration: x == selectedValue
                            ? const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/fanbackground.png'),
                                fit: BoxFit.cover,
                                scale: 1))
                            : const BoxDecoration(),
                        duration: const Duration(milliseconds: 400),
                        width: x == selectedValue
                            ? getWidth(widget.screenWidth, 60)
                            : getWidth(widget.screenWidth, 50),
                        height: x == selectedValue
                            ? getHeight(widget.screenHeight, 60)
                            : getHeight(widget.screenHeight, 50),
                        alignment: Alignment.center,
                        child: Text(
                          (x + 1).toString(),
                          style: TextStyle(
                              color: textColor,
                              fontSize: x == selectedValue
                                  ? getAdaptiveTextSize(context, 14)
                                  : getAdaptiveTextSize(context, 10)),
                        )),
                  ))),
        ));
  }
}
