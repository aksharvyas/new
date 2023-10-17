import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/view/widgets/CustomDialog.dart';
import 'package:kremot/view/widgets/DialogCloseButton.dart';
import 'package:kremot/view/widgets/DialogTitle.dart';

import '../../../res/AppDimensions.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../DialogNote.dart';
import '../widget.dart';

void createEditDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomDialog(
        265.51,
        359.5,
        Stack(
          children: [
            DialogTitle(33.75, 21, "EDIT", 12.0, "Roboto"),
            DialogCloseButton(15, 18, () {
              Navigator.pop(context);
            }),
            Positioned(
                left: getX(width, 91.55),
                top: getY(height, 55.48),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(unSelectedButtonImage,
                        height: getHeight(height, optionsNextButtonHeight),
                        width: getWidth(width, optionsButtonWidth),
                        fit: BoxFit.fill),
                    Positioned.fill(
                      child: Align(
//alignment: Alignment.topCenter,
                          child: Text("RENAME KEYS",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: getAdaptiveTextSize(context, optionsButtonTextSize)),
                              textAlign: TextAlign.center)),
                    ),
                  ],
                )),
            Positioned(
              left: getX(width, 40.38),
              top: getY(height, 100.26),
              child: Container(
                  height: getHeight(height, 160.35),
                  width: getWidth(width, 180.4),
                  padding: EdgeInsets.only(
                      top: getHeight(height, 3), bottom: getHeight(height, 3), left: getWidth(width, 5), right: getWidth(width, 5)),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5.86390495300293)),
                      border: Border.all(
                          color: const Color(0xffeceded),
                          width: 0.3380129933357239),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(
                                1.6900649070739746, 1.6900649070739746),
                            blurRadius: 2.028078079223633,
                            spreadRadius: 0)
                      ],
                      image: const DecorationImage(
                        image: AssetImage(alertDialogBg),
                        fit: BoxFit.fill,
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("NOTE:",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: getAdaptiveTextSize(context, 6.4),
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.left),
                      ),
                      SizedBox(
                        height: getHeight(height, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "1. RENAME OF KEY BE DONE BY DOUBLE TAP KEYS FROM INDIVIDUAL KEYS ON HOME PAGE.",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize:
                                getAdaptiveTextSize(context, 7.5)),
                            textAlign: TextAlign.left),
                      ),
                      SizedBox(
                        height: getHeight(height, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "2. SHARED PERSON CANNOT RENAME ANY KEY.",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: getAdaptiveTextSize(context, 7.5),
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.left),
                      ),
                      SizedBox(
                        height: getHeight(height, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "3. RENAME CAN BE DONE WITH MAXIMUM 10 CHARACTERS IN ONE LINE CAN BE DONE IN MAXIMUM 2 LINE\n(TOTAL 10 X 2 = 20 CHARACTERS).",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize:
                                getAdaptiveTextSize(context, 7.5)),
                            textAlign: TextAlign.left),
                      ),
                      SizedBox(
                        height: getHeight(height, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "4. THE KEYS RENAMED WILL BE REFLECTED IN THE LIST OF VOICE COMMAND.",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize:
                                getAdaptiveTextSize(context, 7.5)),
                            textAlign: TextAlign.left),
                      )
                    ],
                  )),
            ),
            DialogNote(46.38, 321.75, "NOTE: SELECT 1 PLACE & MULTIPLE ROOM AT A TIME"),
          ],
        ),
      ),
    );
  });

}