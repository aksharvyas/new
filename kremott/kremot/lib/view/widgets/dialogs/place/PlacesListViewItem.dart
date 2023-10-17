import 'package:flutter/widgets.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view_model/RoomsVM.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vibration/vibration.dart';

import '../../../../models/PlacesModel.dart';
import '../../../../models/RoomsModel.dart';
import '../../../../res/AppColors.dart';
import '../../../../utils/Utils.dart';
import '../../widget.dart';
import 'PlaceDialog.dart';

class PlacesListViewItem extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double buttonWidth;
  double buttonHeight;
  int index;
  dynamic place;
  RoomsVM roomsVM;
  VoidCallback onItemSelected;

  PlacesListViewItem(this.screenWidth, this.screenHeight, this.buttonWidth, this.buttonHeight, this.index, this.place, this.roomsVM, this.onItemSelected, {Key? key}) : super(key: key);

  @override
  State<PlacesListViewItem> createState() => _PlacesListViewItemState();
}

class _PlacesListViewItemState extends State<PlacesListViewItem> {

  dynamic place;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    place = widget.place;
  }

  @override
  Widget build(BuildContext context) {

    return AutoScrollTag(
        key: ValueKey(widget.index),
        controller: controllerPlace,
        index: widget.index,
        child: GestureDetector(
          onTap: () {
            Utils.vibrateSound();

            widget.onItemSelected();

            RequestRooms requestRooms = RequestRooms(
                applicationId: applicationId,
                appuserId: appUserId,
                homeId: place!.homeId!);
            widget.roomsVM.getAllRooms(requestRooms);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                      place!.isSelected!
                          ? selectedButtonImage
                          : unSelectedButtonImage,
                      height: getHeight(widget.screenHeight, optionsNextButtonHeight),
                      width: getWidth(widget.screenWidth, optionsNextButtonWidth),
                      fit: BoxFit.fill),
                  Positioned.fill(
                    child: Align(
                      //alignment: Alignment.topCenter,
                        child: Text(place!.homeName!.toUpperCase(),
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
                height: getHeight(widget.screenHeight, placeListVerticalMargin),
              ),
            ],
          ),
        ));
  }

}
