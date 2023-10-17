import 'package:flutter/material.dart';

import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../utils/Utils.dart';
import '../DialogListButton.dart';
import '../DialogTitle.dart';
import '../widget.dart';

class HomePageTVRemoteButtons extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  bool isTopExpanded;
  bool isBottomExpanded;

  HomePageTVRemoteButtons(this.screenWidth, this.screenHeight,
      this.isTopExpanded, this.isBottomExpanded,
      {Key? key})
      : super(key: key);

  @override
  State<HomePageTVRemoteButtons> createState() =>
      _HomePageTVRemoteButtonsState();
}

class _HomePageTVRemoteButtonsState extends State<HomePageTVRemoteButtons> {
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
  bool emptySelected = false;
  bool no7Selected = false;
  bool no8Selected = false;
  bool no9Selected = false;
  bool greenSelected = false;
  bool no0Selected = false;
  bool upArrowSelected = false;
  bool preChannelSelected = false;
  bool redSelected = false;
  bool leftArrowSelected = false;
  bool okSelected = false;
  bool rightArrowSelected = false;
  bool yellowSelected = false;
  bool returnSelected = false;
  bool downArrowSelected = false;
  bool exitSelected = false;
  bool blueSelected = false;

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
              child: Text("TV REMOTE SAMSUNG 1",
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
                        tvRemoteButtonWidth,
                        tvRemoteButtonHeight,
                        tvRemoteButtonTextSize,
                        () {
                          setState(() {
                            turnOFFSelected = true;
                          });
                          Utils.vibrateSound();
                          Future.delayed(
                              const Duration(
                                  milliseconds: remoteButtonSelectDuration),
                              () async {
                            setState(() {
                              turnOFFSelected = false;
                            });
                          });
                        },
                        selected: turnOFFSelected,
                      ),
                      Image.asset("assets/images/turnoff.png",
                          height: getHeight(widget.screenHeight, 10.41),
                          width: getWidth(widget.screenWidth, 9.62),
                          fit: BoxFit.fill),
                    ],
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sourceSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
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
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                          () {},
                          selected: sourceSelected,
                        ),
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
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      DialogListButton(
                        "",
                        tvRemoteButtonWidth,
                        tvRemoteButtonHeight,
                        tvRemoteButtonTextSize,
                        () {
                          setState(() {
                            soundSelected = true;
                          });
                          Utils.vibrateSound();
                          Future.delayed(
                              const Duration(
                                  milliseconds: remoteButtonSelectDuration),
                              () async {
                            setState(() {
                              soundSelected = false;
                            });
                          });
                        },
                        selected: soundSelected,
                      ),
                      Image.asset("assets/images/volume.png",
                          height: getHeight(widget.screenHeight, 10.41),
                          width: getWidth(widget.screenWidth, 9.62),
                          fit: BoxFit.cover),
                    ],
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        increaseVolumeSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          increaseVolumeSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                          () {},
                          selected: increaseVolumeSelected,
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, tvRemoteButtonTextSize),
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
                                    context, tvRemoteButtonTextSize),
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
                height: getHeight(
                    widget.screenHeight, tvRemoteButtonVerticalMargin),
              ),
              Row(
                children: [
                  DialogListButton(
                    "1",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no1Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no1Selected = false;
                        });
                      });
                    },
                    selected: no1Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "2",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no2Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no2Selected = false;
                        });
                      });
                    },
                    selected: no2Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "3",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no3Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no3Selected = false;
                        });
                      });
                    },
                    selected: no3Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        decreaseVolumeSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          decreaseVolumeSelected = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                          () {},
                          selected: decreaseVolumeSelected,
                        ),
                        Positioned.fill(
                            top: getY(widget.screenHeight, 1),
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getAdaptiveTextSize(
                                    context, tvRemoteButtonTextSize),
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
                                    context, tvRemoteButtonTextSize),
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
                height: getHeight(
                    widget.screenHeight, tvRemoteButtonVerticalMargin),
              ),
              Row(
                children: [
                  DialogListButton(
                    "4",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no4Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no4Selected = false;
                        });
                      });
                    },
                    selected: no4Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "5",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no5Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no5Selected = false;
                        });
                      });
                    },
                    selected: no5Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "6",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no6Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no6Selected = false;
                        });
                      });
                    },
                    selected: no6Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "-/--",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        emptySelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          emptySelected = false;
                        });
                      });
                    },
                    selected: emptySelected,
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(
                    widget.screenHeight, tvRemoteButtonVerticalMargin),
              ),
              Row(
                children: [
                  DialogListButton(
                    "7",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no7Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no7Selected = false;
                        });
                      });
                    },
                    selected: no7Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "8",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no8Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no8Selected = false;
                        });
                      });
                    },
                    selected: no8Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "9",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no9Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no9Selected = false;
                        });
                      });
                    },
                    selected: no9Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      DialogListButton(
                        "",
                        tvRemoteButtonWidth,
                        tvRemoteButtonHeight,
                        tvRemoteButtonTextSize,
                        () {
                          setState(() {
                            greenSelected = true;
                          });
                          Utils.vibrateSound();
                          Future.delayed(
                              const Duration(
                                  milliseconds: remoteButtonSelectDuration),
                              () async {
                            setState(() {
                              greenSelected = false;
                            });
                          });
                        },
                        selected: greenSelected,
                      ),
                      Container(
                        height: getHeight(widget.screenHeight, 10.95),
                        width: getWidth(widget.screenWidth, 14.27),
                        color: const Color(0xFF397A06),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(
                    widget.screenHeight, tvRemoteButtonVerticalMargin),
              ),
              Row(
                children: [
                  DialogListButton(
                    "0",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        no0Selected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          no0Selected = false;
                        });
                      });
                    },
                    selected: no0Selected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        upArrowSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          upArrowSelected = false;
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
                          () {},
                          selected: upArrowSelected,
                        ),
                        Image.asset("assets/images/arrow_up.png",
                            height: getHeight(widget.screenHeight, 10),
                            width: getWidth(widget.screenWidth, 22.94),
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  DialogListButton(
                    "PRE CH",
                    tvRemoteButtonWidth,
                    tvRemoteButtonHeight,
                    tvRemoteButtonTextSize,
                    () {
                      setState(() {
                        preChannelSelected = true;
                      });
                      Utils.vibrateSound();
                      Future.delayed(
                          const Duration(
                              milliseconds: remoteButtonSelectDuration),
                          () async {
                        setState(() {
                          preChannelSelected = false;
                        });
                      });
                    },
                    selected: preChannelSelected,
                  ),
                  SizedBox(
                    width: getWidth(
                        widget.screenWidth, tvRemoteButtonHorizontalMargin),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      DialogListButton(
                        "",
                        tvRemoteButtonWidth,
                        tvRemoteButtonHeight,
                        tvRemoteButtonTextSize,
                        () {
                          setState(() {
                            redSelected = true;
                          });
                          Utils.vibrateSound();
                          Future.delayed(
                              const Duration(
                                  milliseconds: remoteButtonSelectDuration),
                              () async {
                            setState(() {
                              redSelected = false;
                            });
                          });
                        },
                        selected: redSelected,
                      ),
                      Container(
                        height: getHeight(widget.screenHeight, 10.95),
                        width: getWidth(widget.screenWidth, 14.27),
                        color: const Color(0xFFB42D0F),
                      ),
                    ],
                  ),
                ],
              ),
              if (!widget.isBottomExpanded)
                SizedBox(
                  height: getHeight(
                      widget.screenHeight, tvRemoteButtonVerticalMargin),
                ),
              if (!widget.isBottomExpanded)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          leftArrowSelected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(
                            const Duration(
                                milliseconds: remoteButtonSelectDuration),
                            () async {
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
                            () {},
                            selected: leftArrowSelected,
                          ),
                          Image.asset("assets/images/arrow_left.png",
                              height: getHeight(widget.screenHeight, 13.24),
                              width: getWidth(widget.screenWidth, 15.9),
                              fit: BoxFit.fill),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getWidth(
                          widget.screenWidth, tvRemoteButtonHorizontalMargin),
                    ),
                    DialogListButton(
                      "OK",
                      tvRemoteButtonWidth,
                      tvRemoteButtonHeight,
                      tvRemoteButtonTextSize,
                      () {
                        setState(() {
                          okSelected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(
                            const Duration(
                                milliseconds: remoteButtonSelectDuration),
                            () async {
                          setState(() {
                            okSelected = false;
                          });
                        });
                      },
                      selected: okSelected,
                    ),
                    SizedBox(
                      width: getWidth(
                          widget.screenWidth, tvRemoteButtonHorizontalMargin),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          rightArrowSelected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(
                            const Duration(
                                milliseconds: remoteButtonSelectDuration),
                            () async {
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
                            () {},
                            selected: rightArrowSelected,
                          ),
                          Image.asset("assets/images/arrow_right.png",
                              height: getHeight(widget.screenHeight, 13.24),
                              width: getWidth(widget.screenWidth, 15.9),
                              fit: BoxFit.fill),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getWidth(
                          widget.screenWidth, tvRemoteButtonHorizontalMargin),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                          () {
                            setState(() {
                              yellowSelected = true;
                            });
                            Utils.vibrateSound();
                            Future.delayed(
                                const Duration(
                                    milliseconds: remoteButtonSelectDuration),
                                () async {
                              setState(() {
                                yellowSelected = false;
                              });
                            });
                          },
                          selected: yellowSelected,
                        ),
                        Container(
                          height: getHeight(widget.screenHeight, 10.95),
                          width: getWidth(widget.screenWidth, 14.27),
                          color: const Color(0xFFD0E168),
                        ),
                      ],
                    ),
                  ],
                ),
              if (!widget.isTopExpanded && !widget.isBottomExpanded)
                SizedBox(
                  height: getHeight(
                      widget.screenHeight, tvRemoteButtonVerticalMargin),
                ),
              if (!widget.isTopExpanded && !widget.isBottomExpanded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DialogListButton(
                      "RETURN",
                      tvRemoteButtonWidth,
                      tvRemoteButtonHeight,
                      tvRemoteButtonTextSize,
                      () {
                        setState(() {
                          returnSelected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(
                            const Duration(
                                milliseconds: remoteButtonSelectDuration),
                            () async {
                          setState(() {
                            returnSelected = false;
                          });
                        });
                      },
                      selected: returnSelected,
                    ),
                    SizedBox(
                      width: getWidth(
                          widget.screenWidth, tvRemoteButtonHorizontalMargin),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          downArrowSelected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(
                            const Duration(
                                milliseconds: remoteButtonSelectDuration),
                            () async {
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
                            () {},
                            selected: downArrowSelected,
                          ),
                          Image.asset("assets/images/arrow_down.png",
                              height: getHeight(widget.screenHeight, 10),
                              width: getWidth(widget.screenWidth, 22.94),
                              fit: BoxFit.fill),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getWidth(
                          widget.screenWidth, tvRemoteButtonHorizontalMargin),
                    ),
                    DialogListButton(
                      "EXIT",
                      tvRemoteButtonWidth,
                      tvRemoteButtonHeight,
                      tvRemoteButtonTextSize,
                      () {
                        setState(() {
                          exitSelected = true;
                        });
                        Utils.vibrateSound();
                        Future.delayed(
                            const Duration(
                                milliseconds: remoteButtonSelectDuration),
                            () async {
                          setState(() {
                            exitSelected = false;
                          });
                        });
                      },
                      selected: exitSelected,
                    ),
                    SizedBox(
                      width: getWidth(
                          widget.screenWidth, tvRemoteButtonHorizontalMargin),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        DialogListButton(
                          "",
                          tvRemoteButtonWidth,
                          tvRemoteButtonHeight,
                          tvRemoteButtonTextSize,
                          () {
                            setState(() {
                              blueSelected = true;
                            });
                            Utils.vibrateSound();
                            Future.delayed(
                                const Duration(
                                    milliseconds: remoteButtonSelectDuration),
                                () async {
                              setState(() {
                                blueSelected = false;
                              });
                            });
                          },
                          selected: blueSelected,
                        ),
                        Container(
                          height: getHeight(widget.screenHeight, 10.95),
                          width: getWidth(widget.screenWidth, 14.27),
                          color: const Color(0xFF118AE2),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
