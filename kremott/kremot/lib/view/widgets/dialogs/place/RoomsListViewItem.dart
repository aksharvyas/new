import 'package:flutter/material.dart';
import 'package:kremot/models/RoomsModel.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vibration/vibration.dart';

import '../../../../utils/Utils.dart';
import 'PlaceDialog.dart';

class RoomsListViewItem extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double buttonWidth;
  double buttonHeight;
  int index;
  List<dynamic> roomsList;
  Function onItemSelected;

  RoomsListViewItem(
      this.screenWidth, this.screenHeight, this.buttonWidth, this.buttonHeight, this.index, this.roomsList, this.onItemSelected,
      {Key? key})
      : super(key: key);

  @override
  State<RoomsListViewItem> createState() => _RoomsListViewItemState();
}

class _RoomsListViewItemState extends State<RoomsListViewItem> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
        key: ValueKey(widget.index),
        controller: controllerRoom,
        index: widget.index,
        child: GestureDetector(
          onTap: () {
            Utils.vibrateSound();
            widget.onItemSelected();
          },
          child: getRoomHorizontalItemDialog(widget.roomsList[widget.index],
              widget.buttonHeight, widget.buttonWidth),
        ));
  }

  Widget getRoomHorizontalItemDialog(
      AppUserAccessPermissionsRoom appUserAccessPermissionsRoom,
      double height,
      double width) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
                appUserAccessPermissionsRoom.isSelected!
                    ? selectedButtonImage
                    : unSelectedButtonImage,
                height: getHeight(widget.screenHeight, optionsNextButtonHeight),
                width: getWidth(widget.screenWidth, optionsNextButtonWidth),
                fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                  //alignment: Alignment.topCenter,
                  child: Text(appUserAccessPermissionsRoom.roomName!.toUpperCase(),
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: getAdaptiveTextSize(context, optionsNextButtonTextSize)),
                      textAlign: TextAlign.center)),
            ),
          ],
        ),
        SizedBox(
          height: getHeight(widget.screenHeight, 8),
        ),
      ],
    );
  }
}
