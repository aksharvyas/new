import 'package:flutter/material.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../DialogListButton.dart';
import '../widget.dart';
import 'HomePageSelectPlaceList.dart';
import 'HomePageHomeRemoteButtonsWifiSwitchesFan.dart';

class HomePageHomeRemoteButtons extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  HomePageHomeRemoteButtons(this.screenWidth, this.screenHeight, {Key? key}) : super(key: key);

  @override
  State<HomePageHomeRemoteButtons> createState() => _HomePageHomeRemoteButtonsState();
}

class _HomePageHomeRemoteButtonsState extends State<HomePageHomeRemoteButtons> {

  AutoScrollController _scrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          width: getWidth(widget.screenWidth, widget.screenWidth),
          height: getHeight(widget.screenHeight, 500),
          child: Stack(
            children: [
              Positioned(
                top: getY(widget.screenHeight, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/select_options_bg.png",
                          width: getWidth(widget.screenWidth, 163.94),
                          height: getHeight(widget.screenHeight, 174.12),
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 18),
                            child: Text(
                              "TV",
                              style: TextStyle(
                                  //fontFamily: "Inter",
                                  fontSize: getAdaptiveTextSize(
                                      context, homeRemoteTypeTextSize),
                                  color: textColor),
                              textAlign: TextAlign.center,
                            )),
                        Positioned(
                          left: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 38.15),
                          child: Image.asset(
                            "assets/images/tv_image.png",
                            width: getWidth(widget.screenWidth, 33.18),
                            height: getHeight(widget.screenHeight, 33.18),
                          ),
                        ),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 41.21),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned(
                                left: getX(widget.screenWidth, 17.9),
                                top: getY(widget.screenHeight, 4.64),
                                child: Image.asset("assets/images/turnoff.png",
                                    height: getHeight(widget.screenHeight, 12.92),
                                    width: getWidth(widget.screenWidth, 11.27),
                                    fit: BoxFit.fill),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: getX(widget.screenWidth, 19.58),
                          top: getY(widget.screenHeight, 115.52),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 1),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 9),
                                  child: Text(
                                    "VAL",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 115.52),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 1),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 9),
                                  child: Text(
                                    "VAL",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getWidth(widget.screenWidth, 10),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/select_options_bg.png",
                          width: getWidth(widget.screenWidth, 163.94),
                          height: getHeight(widget.screenHeight, 174.12),
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 18),
                            child: Text(
                              "AC",
                              style: TextStyle(
                                  //fontFamily: "Inter",
                                  fontSize: getAdaptiveTextSize(
                                      context, homeRemoteTypeTextSize),
                                  color: textColor),
                              textAlign: TextAlign.center,
                            )),
                        Positioned(
                          left: getX(widget.screenWidth, 10.9),
                          top: getY(widget.screenHeight, 38.15),
                          child: Image.asset("assets/images/ac_image.png",
                              width: getWidth(widget.screenWidth, 66.02),
                              height: getHeight(widget.screenHeight, 37.49),
                              fit: BoxFit.cover),
                        ),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 41.21),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned(
                                left: getX(widget.screenWidth, 17.9),
                                top: getY(widget.screenHeight, 4.64),
                                child: Image.asset("assets/images/turnoff.png",
                                    height: getHeight(widget.screenHeight, 12.92),
                                    width: getWidth(widget.screenWidth, 11.27),
                                    fit: BoxFit.fill),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: getX(widget.screenWidth, 19.58),
                          top: getY(widget.screenHeight, 115.52),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 1),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 9),
                                  child: Text(
                                    "TEMP.",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 115.52),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 1),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 9),
                                  child: Text(
                                    "TEMP.",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: getY(widget.screenHeight, 205),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/select_options_bg.png",
                          width: getWidth(widget.screenWidth, 163.94),
                          height: getHeight(widget.screenHeight, 174.12),
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 18),
                            child: Text(
                              "Wi-Fi SWITCHES",
                              style: TextStyle(
                                  //fontFamily: "Inter",
                                  fontSize: getAdaptiveTextSize(
                                      context, homeRemoteTypeTextSize),
                                  color: textColor),
                              textAlign: TextAlign.center,
                            )),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 41.21),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned(
                                left: getX(widget.screenWidth, 17.9),
                                top: getY(widget.screenHeight, 4.64),
                                child: Image.asset("assets/images/turnoff.png",
                                    height: getHeight(widget.screenHeight, 12.92),
                                    width: getWidth(widget.screenWidth, 11.27),
                                    fit: BoxFit.fill),
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 96.55),
                            child: Text(
                              "FAN 2",
                              style: TextStyle(
                                  fontSize: getAdaptiveTextSize(context, 10),
                                  color: textColor,
                                  fontFamily: "Inter"),
                              textAlign: TextAlign.center,
                            )),
                        Positioned(
                          top: getY(widget.screenHeight, 114.46),
                          left: getX(widget.screenWidth, 28),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(fanUnSelectedImage,
                                  height: getHeight(widget.screenHeight, 30.86),
                                  width: getWidth(widget.screenWidth, 116.79),
                                  fit: BoxFit.fill),
                              Positioned.fill(
                                  left: getWidth(widget.screenWidth, 5),
                                  right: getWidth(widget.screenWidth, 5),
                                  child: HomePageHomeRemoteButtonsWifiSwitchesFan(widget.screenWidth, widget.screenHeight)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getWidth(widget.screenWidth, 10),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/select_options_bg.png",
                          width: getWidth(widget.screenWidth, 163.94),
                          height: getHeight(widget.screenHeight, 174.12),
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 18),
                            child: Text(
                              "STB",
                              style: TextStyle(
                                  //fontFamily: "Inter",
                                  fontSize: getAdaptiveTextSize(
                                      context, homeRemoteTypeTextSize),
                                  color: textColor),
                              textAlign: TextAlign.center,
                            )),
                        Positioned(
                          left: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 43.81),
                          child: Image.asset("assets/images/stb_image.png",
                              width: getWidth(widget.screenWidth, 41.47),
                              height: getHeight(widget.screenHeight, 19.24),
                              fit: BoxFit.fill),
                        ),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 41.21),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned(
                                left: getX(widget.screenWidth, 17.9),
                                top: getY(widget.screenHeight, 4.64),
                                child: Image.asset("assets/images/turnoff.png",
                                    height: getHeight(widget.screenHeight, 12.92),
                                    width: getWidth(widget.screenWidth, 11.27),
                                    fit: BoxFit.fill),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: getX(widget.screenWidth, 19.58),
                          top: getY(widget.screenHeight, 115.52),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 1),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 9),
                                  child: Text(
                                    "CH.",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                        Positioned(
                          right: getX(widget.screenWidth, 20.9),
                          top: getY(widget.screenHeight, 115.52),
                          child: Stack(
                            children: [
                              DialogListButton(
                                  "",
                                  homeRemoteButtonWidth,
                                  homeRemoteButtonHeight,
                                  homeRemoteButtonTextSize,
                                      () {}),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 1),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Positioned.fill(
                                  top: getY(widget.screenHeight, 9),
                                  child: Text(
                                    "CH.",
                                    style: TextStyle(
                                      fontSize: getAdaptiveTextSize(
                                          context, homeRemoteButtonTextSize),
                                      color: textColor,
                                      //fontFamily: "Inter",
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
