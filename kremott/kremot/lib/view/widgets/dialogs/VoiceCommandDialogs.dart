import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/view/widgets/DialogButton.dart';
import 'package:kremot/view/widgets/DialogCenterButton.dart';
import 'package:kremot/view/widgets/widget.dart';
import '../../../res/AppDimensions.dart';
import '../../../utils/Utils.dart';
import '../CustomDialog.dart';
import '../DialogCloseButton.dart';
import '../DialogTitle.dart';

void createVoiceCommandDialog(BuildContext context, double height,
    double width){

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomDialog(
          290.97,
          510.93,
          Stack(
            children: [
              DialogTitle(20.57, 31.85, "LIST OF VOICE COMMAND", 12.0, "Roboto"),
              DialogCloseButton(15, 27, () {
                Navigator.pop(context);
              }),
              Positioned(
                  left: getX(width, 132),
                  top: getY(height, optionsListTopMargin),
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 18,
                      color: arrowColor,
                    ),
                  )),
              Positioned.fill(
                top: getY(height, optionsListTopMargin + dialogListItemsVerticalMargin),
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(height, 340.0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(
                            height: getHeight(height, 0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("SW 01", optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize, () { }),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("SWITCH 1", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("OPEN CURTAIN 1", optionsNextButtonWidth, optionsNextButtonHeight, 6, () { }, fontColor: const Color(0xFFDAF375),),
                              Text("=", style: TextStyle(color: textColor, fontSize: getAdaptiveTextSize(context, 7), fontFamily: 'Inter', decoration: TextDecoration.none),),
                              DialogCenterButton("", optionsNextButtonWidth, optionsNextButtonHeight, 8, () { }),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(height, dialogListItemsVerticalMarginSmall),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: getX(width, 132),
                  top: getY(height, 420),
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 18,
                      color: arrowColor,
                    ),
                  )),
            ],
          )
      ),
    );
  });

}