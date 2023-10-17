import 'package:flutter/material.dart';

import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../DialogButton.dart';
import '../DialogCenterButton.dart';
import '../widget.dart';

class HomePageACRemote extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  HomePageACRemote(this.screenWidth, this.screenHeight, {Key? key}) : super(key: key);

  @override
  State<HomePageACRemote> createState() => _HomePageACRemoteState();
}

class _HomePageACRemoteState extends State<HomePageACRemote> {

  List<String> listCompanies = [
    "SAMSUNG",
    "SONY",
    "LG",
    "TOSHIBA",
    "ONIDA",
    "PHILLIPS",
    "MI",
    "PANASONIC"
  ];
  
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
              width: getWidth(widget.screenWidth, widget.screenWidth),
              height: getHeight(widget.screenHeight, 450),
              child: Stack(
                children: [
                  Positioned(
                    top: getY(widget.screenHeight, 20),
                    child: Stack(
                      children: [
                        Image.asset("assets/images/remote_company_bg.png",
                            height: getHeight(widget.screenHeight, 377.56),
                            width: getWidth(widget.screenWidth, 90.91),
                            fit: BoxFit.fill),
                        Positioned(
                          left: getX(widget.screenWidth, 36),
                          top: getY(widget.screenHeight, 3.58),
                          child: GestureDetector(
                            child: const Icon(
                              Icons.arrow_drop_down,
                              size: 18,
                              color: arrowColor,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          top: getY(widget.screenHeight, 24.2),
                          child: Column(
                            children: [
                              SizedBox(
                                height: getHeight(widget.screenHeight, 330),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: listCompanies.length,
                                    itemBuilder: (context, position) {
                                      return Column(
                                        children: [
                                          DialogCenterButton(
                                              listCompanies[position],
                                              remoteCompanyNameButtonWidth,
                                              remoteCompanyNameButtonHeight,
                                              remoteCompanyNameButtonTextSize,
                                                  () {}),
                                          SizedBox(
                                            height: getHeight(widget.screenHeight, 17),
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: getX(widget.screenWidth, 36),
                          top: getY(widget.screenHeight, 355.16),
                          child: GestureDetector(
                            child: const Icon(
                              Icons.arrow_drop_up,
                              size: 18,
                              color: arrowColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DialogButton(
                      "LEARNING",
                      15.81,
                      418.58,
                      remoteCompanyNameButtonWidth,
                      remoteCompanyNameButtonHeight,
                      remoteCompanyNameButtonTextSize,
                          () {}),
                  Positioned(
                      left: getX(widget.screenWidth, 115.36),
                      top: getY(widget.screenHeight, 27.75),
                      child: Text(
                        "2. SELECT AC REMOTE NO.",
                        style: TextStyle(
                            //fontFamily: "Inter",
                            fontSize: getAdaptiveTextSize(
                                context, remoteDescTextSize),
                            color: textColor),
                      )),
                  Positioned(
                    top: getY(widget.screenHeight, 60.4),
                    left: getX(widget.screenWidth, 96.45),
                    child: const Icon(
                      Icons.arrow_left,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                  Positioned(
                      left: getX(widget.screenWidth, 114.05),
                      top: getY(widget.screenHeight, 49.14),
                      child: Stack(
                        children: [
                          Image.asset("assets/images/remote_no_bg.png",
                              height: getHeight(widget.screenHeight, 39.45),
                              width: getWidth(widget.screenWidth, 218.78),
                              fit: BoxFit.fill),
                          SizedBox(
                            height: getHeight(widget.screenHeight, 39.45),
                            width: getWidth(widget.screenWidth, 218.78),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: (context, position) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: getWidth(widget.screenWidth, 10),
                                      ),
                                      DialogCenterButton(
                                        (position + 1).toString(),
                                        remoteNoButtonWidth,
                                        remoteNoButtonHeight,
                                        remoteNoButtonTextSize,
                                            () {},
                                      ),
                                      SizedBox(
                                        width: getWidth(widget.screenWidth, 7),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      )),
                  Positioned(
                    top: getY(widget.screenHeight, 60.4),
                    left: getX(widget.screenWidth, 330),
                    child: const Icon(
                      Icons.arrow_right,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                  Positioned.fill(
                      left: getX(widget.screenWidth, 115.36),
                      top: getY(widget.screenHeight, 115.01),
                      child: Text(
                        "3. POINT IR CONTROLLER TOWARDS AC THEN PRESS POWER BUTTON MAKE SURE AC RESPONDS.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            //fontFamily: "Inter",
                            fontSize: getAdaptiveTextSize(
                                context, remoteDescTextSize),
                            color: textColor),
                      )),
                  Positioned(
                      top: getY(widget.screenHeight, 150.21),
                      left: getX(widget.screenWidth, 190.28),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_left,
                            size: 20,
                            color: arrowColor,
                          ),
                          SizedBox(
                            width: getWidth(widget.screenWidth, 7),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              DialogCenterButton(
                                  "",
                                  remoteYesNoButtonWidth,
                                  remoteYesNoButtonHeight,
                                  remoteYesNoButtonTextSize,
                                      () {}),
                              Image.asset("assets/images/turnoff.png",
                                  height: getHeight(widget.screenHeight, 9.41),
                                  width: getWidth(widget.screenWidth, 9.62),
                                  fit: BoxFit.fill),
                            ],
                          ),
                          SizedBox(
                            width: getWidth(widget.screenWidth, 7),
                          ),
                          const Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: arrowColor,
                          ),
                        ],
                      )),
                  Positioned(
                      left: getX(widget.screenWidth, 115.36),
                      top: getY(widget.screenHeight, 192.31),
                      child: Text(
                        "4. DOES DEVICE TURN ON/OFF.",
                        style: TextStyle(
                            //fontFamily: "Inter",
                            fontSize: getAdaptiveTextSize(
                                context, remoteDescTextSize),
                            color: textColor),
                      )),
                  DialogButton(
                      "YES",
                      123,
                      216.86,
                      remoteYesNoButtonWidth,
                      remoteYesNoButtonHeight,
                      remoteYesNoButtonTextSize,
                          () {}),
                  Positioned(
                      left: getX(widget.screenWidth, 115.36),
                      top: getY(widget.screenHeight, 248.38),
                      child: Text(
                        "5. PAIRED REMOTE WILL BE SAVE IN AC REMOTE.",
                        style: TextStyle(
                            //fontFamily: "Inter",
                            fontSize: getAdaptiveTextSize(
                                context, remoteDescTextSize),
                            color: textColor),
                      )),
                  DialogButton(
                      "NO",
                      123,
                      275.59,
                      remoteYesNoButtonWidth,
                      remoteYesNoButtonHeight,
                      remoteYesNoButtonTextSize,
                          () {}),
                  Positioned.fill(
                      left: getX(widget.screenWidth, 115.36),
                      top: getY(widget.screenHeight, 312.08),
                      child: Text(
                        "6. IF THAN AUTOMATICALLY IT WILL SHIFT TO NEXT REMOTE OR YOU CAN SELECT ANOTHER REMOTE FROM ABOVE AC REMOTE NO. THEN TRY NEXT REMOTE",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            //fontFamily: "Inter",
                            fontSize: getAdaptiveTextSize(
                                context, remoteDescTextSize),
                            color: textColor),
                      )),
                  Positioned(
                    top: getY(widget.screenHeight, 364.81),
                    left: getX(widget.screenWidth, 96.45),
                    child: const Icon(
                      Icons.arrow_left,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                  Positioned(
                      left: getX(widget.screenWidth, 114.05),
                      top: getY(widget.screenHeight, 355.55),
                      child: Stack(
                        children: [
                          Image.asset("assets/images/remote_no_bg.png",
                              height: getHeight(widget.screenHeight, 39.45),
                              width: getWidth(widget.screenWidth, 218.78),
                              fit: BoxFit.fill),
                          SizedBox(
                            height: getHeight(widget.screenHeight, 39.45),
                            width: getWidth(widget.screenWidth, 218.78),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: (context, position) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: getWidth(widget.screenWidth, 10),
                                      ),
                                      DialogCenterButton(
                                        (position + 1).toString(),
                                        remoteNoButtonWidth,
                                        remoteNoButtonHeight,
                                        remoteNoButtonTextSize,
                                            () {},
                                      ),
                                      SizedBox(
                                        width: getWidth(widget.screenWidth, 7),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      )),
                  Positioned(
                    top: getY(widget.screenHeight, 364.81),
                    left: getX(widget.screenWidth, 330),
                    child: const Icon(
                      Icons.arrow_right,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ],
              )),
        ]);
  }
}
