import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view/widgets/widget.dart';

import '../../../res/AppDimensions.dart';
import '../../../utils/Utils.dart';
import '../DialogButton.dart';
import '../DialogListButton.dart';
import '../DialogSwitchButton.dart';
import '../DialogSwitchListButton.dart';

class HomePageACRemoteButtons extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  bool isExpanded;
  HomePageACRemoteButtons(this.screenWidth, this.screenHeight, this.isExpanded, {Key? key}) : super(key: key);

  @override
  State<HomePageACRemoteButtons> createState() => _HomePageACRemoteButtonsState();
}

class _HomePageACRemoteButtonsState extends State<HomePageACRemoteButtons> {

  bool turnOFFSelected = false;
  bool increaseTempSelected = false;
  bool modeSelected = false;
  bool swingSelected = false;
  bool fanSelected = false;
  bool decreaseTempSelected = false;
  bool offSelected = false;
  bool cancelSelected = false;
  bool onSelected = false;
  bool turboSelected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: getY(widget.screenHeight, 6),
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getX(widget.screenWidth, 5.0)),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text("AC REMOTE DAIKIN 1",
                  style: TextStyle(
                    color: dialogTitleColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: getAdaptiveTextSize(context, 12.0),
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
        Positioned(
          left: getX(widget.screenWidth, 20),
          top: getY(widget.screenHeight, 26),
          child: Stack(
            children: [
              Image.asset(
                "assets/images/ac_background.png",
                height: getHeight(widget.screenHeight, 156),
                width: getWidth(widget.screenWidth, 285),
                fit: BoxFit.fill,
              ),
              Positioned(
                  left: getX(widget.screenWidth, 210),
                  top: getY(widget.screenHeight, 29),
                  child: Container(
                    width: getWidth(widget.screenWidth, 10),
                    height: getHeight(widget.screenHeight, 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  )),
              Positioned(
                  top: getY(widget.screenHeight, 33),
                  left: getX(widget.screenWidth, 50),
                  child: Text(
                    "25.5",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Digital Numbers",
                        fontSize: getAdaptiveTextSize(context, 55)),
                  )),
              Positioned(
                  top: getY(widget.screenHeight, 77),
                  left: getX(widget.screenWidth, 212),
                  child: Text(
                    "C",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Digital Numbers",
                        fontSize: getAdaptiveTextSize(context, 19)),
                    textAlign: TextAlign.center,
                  )),
              Positioned(
                  left: getX(widget.screenWidth, 112),
                  top: getY(widget.screenHeight, 133),
                  child: Text(
                    "SWING ON",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Inter SemiBold",
                        fontSize: getAdaptiveTextSize(context, 12)),
                    textAlign: TextAlign.center,
                  )),
              Positioned(
                  left: getX(widget.screenWidth, 25),
                  top: getY(widget.screenHeight, 133),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/network.png",
                        height: getHeight(widget.screenHeight, 12.94),
                        width: getWidth(widget.screenWidth, 14.6),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: getWidth(widget.screenWidth, 5),
                      ),
                      Text(
                        "AUTO",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter SemiBold",
                            fontSize: getAdaptiveTextSize(context, 9)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              Positioned(
                  top: getY(widget.screenHeight, 102),
                  left: getX(widget.screenWidth, 238),
                  child: Text(
                    "AUTO\nCOOL\nDRY\nFAN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Inter SemiBold",
                        fontSize: getAdaptiveTextSize(context, 8)),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: getHeight(widget.screenHeight, acRemoteButtonVerticalMargin),
        ),
        Positioned(
          left: 0,
          top: getY(widget.screenHeight, 211),
          child: GestureDetector(
            onTap: (){
              setState(() {
                turnOFFSelected = true;
              });
              Utils.vibrateSound();
              Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                setState(() {
                  turnOFFSelected = false;
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(turnOFFSelected ? fanSelectedImage : fanUnSelectedImage,
                    height: getHeight(widget.screenHeight, acRemoteButtonHeight),
                    width: getWidth(widget.screenWidth, 154),
                    fit: BoxFit.fill),
                Image.asset("assets/images/turnoff.png",
                    height: getHeight(widget.screenHeight, 10.41),
                    width: getWidth(widget.screenWidth, 9.62),
                    fit: BoxFit.fill),
              ],
            ),
          ),
        ),
        Positioned(
          left: getX(widget.screenWidth, 255),
          top: getY(widget.screenHeight, 211),
          child: GestureDetector(
            onTap: (){
              setState(() {
                increaseTempSelected = true;
              });
              Utils.vibrateSound();
              Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                setState(() {
                  increaseTempSelected = false;
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                DialogSwitchListButton("", acRemoteButtonWidth,
                    acRemoteButtonHeight, acRemoteButtonTextSize, () {}, selected: increaseTempSelected,),
                Column(
                  children: [
                    Text(
                      "+",
                      style: TextStyle(
                        fontSize: getAdaptiveTextSize(
                            context, acRemoteButtonTextSize),
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "TEMP",
                      style: TextStyle(
                        fontSize: getAdaptiveTextSize(
                            context, acRemoteButtonTextSize),
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: getX(widget.screenWidth, 255),
          top: getY(widget.screenHeight, 298),
          child: GestureDetector(
            onTap: (){
              setState(() {
                decreaseTempSelected = true;
              });
              Utils.vibrateSound();
              Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                setState(() {
                  decreaseTempSelected = false;
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                DialogSwitchListButton("", acRemoteButtonWidth,
                    acRemoteButtonHeight, acRemoteButtonTextSize, () {}, selected: decreaseTempSelected,),
                Column(
                  children: [
                    Text(
                      "-",
                      style: TextStyle(
                        fontSize: getAdaptiveTextSize(
                            context, acRemoteButtonTextSize),
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "TEMP",
                      style: TextStyle(
                        fontSize: getAdaptiveTextSize(
                            context, acRemoteButtonTextSize),
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        DialogSwitchButton("MODE", 0, 298, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              modeSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                modeSelected = false;
              });
            });
          },
          selected: modeSelected,),
        DialogSwitchButton("SWING", 85, 298, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              swingSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                swingSelected = false;
              });
            });
          },
          selected: swingSelected,),
        DialogSwitchButton("FAN", 170, 298, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              fanSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                fanSelected = false;
              });
            });
          },
          selected: fanSelected,),
        if(!widget.isExpanded) DialogSwitchButton("OFF", 0, 385, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              offSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                offSelected = false;
              });
            });
          },
          selected: offSelected,),
        if(!widget.isExpanded) DialogSwitchButton("CANCEL", 85, 385, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              cancelSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                cancelSelected = false;
              });
            });
          },
          selected: cancelSelected,),
        if(!widget.isExpanded) DialogSwitchButton("ON", 170, 385, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              onSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                onSelected = false;
              });
            });
          },
          selected: onSelected,),
        if(!widget.isExpanded) DialogSwitchButton("TURBO", 255, 385, acRemoteButtonWidth,
            acRemoteButtonHeight, acRemoteButtonTextSize, () {
            setState(() {
              turboSelected = true;
            });
            Utils.vibrateSound();
            Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
              setState(() {
                turboSelected = false;
              });
            });
          },
          selected: turboSelected,),
      ],
    );
  }
}
