import 'package:flutter/material.dart';

import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../utils/Utils.dart';
import '../DialogListButton.dart';
import '../widget.dart';

class HomePageSTBRemoteButtons extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  bool isTopExpanded;
  bool isBottomExpanded;
  HomePageSTBRemoteButtons(this.screenWidth, this.screenHeight, this.isTopExpanded, this.isBottomExpanded, {Key? key}) : super(key: key);

  @override
  State<HomePageSTBRemoteButtons> createState() => _HomePageSTBRemoteButtonsState();
}

class _HomePageSTBRemoteButtonsState extends State<HomePageSTBRemoteButtons> {
  bool turnOFFSelected = false;
  bool sourceSelected = false;
  bool soundSelected = false;
  bool increaseVolumeSelected = false;
  bool no1Selected = false;
  bool no2Selected = false;
  bool no3Selected = false;
  bool decreaseVolumeSelected = false;
  bool no4Selected = false;
  bool no5Selected = false;
  bool no6Selected = false;
  bool previousChannelSelected = false;
  bool no7Selected = false;
  bool no8Selected = false;
  bool no9Selected = false;
  bool nextChannelSelected = false;
  bool no0Selected = false;
  bool upArrowSelected = false;
  bool preChannelSelected = false;
  bool emptySelected = false;
  bool leftArrowSelected = false;
  bool okSelected = false;
  bool rightArrowSelected = false;
  bool infoSelected = false;
  bool returnSelected = false;
  bool downArrowSelected = false;
  bool exitSelected = false;
  bool toolSelected = false;

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
              child: Text("STB REMOTE TATA SKY 1",
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
          top: getY(widget.screenHeight, 26.0),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      DialogListButton(
                          "",
                          stbRemoteButtonWidth,
                          stbRemoteButtonHeight,
                          stbRemoteButtonTextSize,
                            () {
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
                        selected: turnOFFSelected,),
                      Image.asset("assets/images/turnoff.png",
                          height: getHeight(widget.screenHeight, 10.41),
                          width: getWidth(widget.screenWidth, 9.62),
                          fit: BoxFit.fill),
                    ],
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        sourceSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          sourceSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton(
                            "",
                            stbRemoteButtonWidth,
                            stbRemoteButtonHeight,
                            stbRemoteButtonTextSize,
                                () {}, selected: sourceSelected,),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "SOURCE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(context, 7),
                                color: textColor,
                                //fontFamily: "Inter",
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Positioned(
                          top: getY(widget.screenHeight, 13),
                          child: Image.asset("assets/images/remote_source.png",
                              height: getHeight(widget.screenHeight, 11.94),
                              width: getWidth(widget.screenWidth, 17.13),
                              fit: BoxFit.fill),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      DialogListButton(
                          "",
                          stbRemoteButtonWidth,
                          stbRemoteButtonHeight,
                          stbRemoteButtonTextSize,
                            () {
                          setState(() {
                            soundSelected = true;
                          });
                          Utils.vibrateSound();
                          Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                            setState(() {
                              soundSelected = false;
                            });
                          });
                        },
                        selected: soundSelected,),
                      Image.asset("assets/images/volume.png",
                          height: getHeight(widget.screenHeight, 10.41),
                          width: getWidth(widget.screenWidth, 9.62),
                          fit: BoxFit.cover),
                    ],
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        increaseVolumeSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          increaseVolumeSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        DialogListButton(
                            "",
                            stbRemoteButtonWidth,
                            stbRemoteButtonHeight,
                            stbRemoteButtonTextSize,
                                () {}, selected: increaseVolumeSelected,),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
                                color: textColor,
                                //fontFamily: "Inter",
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 12),
                            child: Text(
                              "VOL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
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
                height: getHeight(widget.screenHeight, stbRemoteButtonVerticalMargin),
              ),
              Row(
                children: [
                  DialogListButton("1", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no1Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no1Selected = false;
                        });
                      });
                    },
                    selected: no1Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("2", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no2Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no2Selected = false;
                        });
                      });
                    },
                    selected: no2Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("3", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no3Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no3Selected = false;
                        });
                      });
                    },
                    selected: no3Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        decreaseVolumeSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          decreaseVolumeSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        DialogListButton(
                            "",
                            stbRemoteButtonWidth,
                            stbRemoteButtonHeight,
                            stbRemoteButtonTextSize,
                                () {}, selected: decreaseVolumeSelected,),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
                                color: textColor,
                                //fontFamily: "Inter",
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 12),
                            child: Text(
                              "VOL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
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
                height: getHeight(widget.screenHeight, stbRemoteButtonVerticalMargin),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DialogListButton("4", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no4Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no4Selected = false;
                        });
                      });
                    },
                    selected: no4Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("5", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no5Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no5Selected = false;
                        });
                      });
                    },
                    selected: no5Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("6", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no6Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no6Selected = false;
                        });
                      });
                    },
                    selected: no6Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        nextChannelSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          nextChannelSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        DialogListButton(
                            "",
                            stbRemoteButtonWidth,
                            stbRemoteButtonHeight,
                            stbRemoteButtonTextSize,
                                () {}, selected: nextChannelSelected,),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
                                color: textColor,
                                //fontFamily: "Inter",
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 12),
                            child: Text(
                              "CH",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
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
                height: getHeight(widget.screenHeight, stbRemoteButtonVerticalMargin),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DialogListButton("7", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                        setState(() {
                          no7Selected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                          setState(() {
                            no7Selected = false;
                          });
                        });
                      }, selected: no7Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("8", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no8Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no8Selected = false;
                        });
                      });
                    },
                    selected: no8Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("9", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no9Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no9Selected = false;
                        });
                      });
                    },
                    selected: no9Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        previousChannelSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          previousChannelSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        DialogListButton(
                            "",
                            stbRemoteButtonWidth,
                            stbRemoteButtonHeight,
                            stbRemoteButtonTextSize,
                                () {}, selected: previousChannelSelected,),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
                                color: textColor,
                                //fontFamily: "Inter",
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 12),
                            child: Text(
                              "CH",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, stbRemoteButtonTextSize),
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
                height: getHeight(widget.screenHeight, stbRemoteButtonVerticalMargin),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DialogListButton("0", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        no0Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          no0Selected = false;
                        });
                      });
                    },
                    selected: no0Selected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        upArrowSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          upArrowSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton("", tvRemoteButtonWidth,
                          tvRemoteButtonHeight, tvRemoteButtonTextSize, () {
                          },
                          selected: upArrowSelected,),
                        Image.asset("assets/images/arrow_up.png",
                            height: getHeight(widget.screenHeight, 10),
                            width: getWidth(widget.screenWidth, 22.94),
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("PRE CH", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        preChannelSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          preChannelSelected = false;
                        });
                      });
                    },
                    selected: preChannelSelected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("-/--", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        emptySelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          emptySelected = false;
                        });
                      });
                    },
                    selected: emptySelected,),
                ],
              ),
              if(!widget.isBottomExpanded) SizedBox(
                height: getHeight(widget.screenHeight, stbRemoteButtonVerticalMargin),
              ),
              if(!widget.isBottomExpanded) Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        leftArrowSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          leftArrowSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                              () {

                          },
                          selected: leftArrowSelected,),
                        Image.asset("assets/images/arrow_left.png",
                            height: getHeight(widget.screenHeight, 13.24),
                            width: getWidth(widget.screenWidth, 15.9),
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("OK", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        okSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          okSelected = false;
                        });
                      });
                    },
                    selected: okSelected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        rightArrowSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          rightArrowSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                              () {

                          },
                          selected: rightArrowSelected,),
                        Image.asset("assets/images/arrow_right.png",
                            height: getHeight(widget.screenHeight, 13.24),
                            width: getWidth(widget.screenWidth, 15.9),
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("INFO", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        infoSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          infoSelected = false;
                        });
                      });
                    },
                    selected: infoSelected,),
                ],
              ),
              if(!widget.isTopExpanded && !widget.isBottomExpanded) SizedBox(
                height: getHeight(widget.screenHeight, stbRemoteButtonVerticalMargin),
              ),
              if(!widget.isTopExpanded && !widget.isBottomExpanded) Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DialogListButton("RETURN", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        returnSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          returnSelected = false;
                        });
                      });
                    },
                    selected: returnSelected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        downArrowSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          downArrowSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                              () {

                          },
                          selected: downArrowSelected,),
                        Image.asset("assets/images/arrow_down.png",
                            height: getHeight(widget.screenHeight, 10),
                            width: getWidth(widget.screenWidth, 22.94),
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("EXIT", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        exitSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          exitSelected = false;
                        });
                      });
                    },
                    selected: exitSelected,),
                  SizedBox(
                    width: getWidth(widget.screenWidth, stbRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton("TOOL", stbRemoteButtonWidth,
                      stbRemoteButtonHeight, stbRemoteButtonTextSize, () {
                      setState(() {
                        toolSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(const Duration(milliseconds: remoteButtonSelectDuration), () async {
                        setState(() {
                          toolSelected = false;
                        });
                      });
                    },
                    selected: toolSelected,),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
