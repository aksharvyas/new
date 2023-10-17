import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/view/widgets/dialogs/place/PlacesList.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../view_model/PlacesVM.dart';
import '../../../../view_model/RoomsVM.dart';
import 'PlaceDialog.dart';
import '../../widget.dart';

class PlacesLayout extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double listViewHeight;
  double buttonWidth;
  double buttonHeight;
  dynamic placesVM;
  RoomsVM roomsVM;
  bool isPairingDialog;
  Function selectedPlaceCallback;

  PlacesLayout(this.screenWidth, this.screenHeight, this.listViewHeight, this.buttonWidth, this.buttonHeight, this.placesVM, this.roomsVM, this.isPairingDialog, this.selectedPlaceCallback, {Key? key}) : super(key: key);

  @override
  State<PlacesLayout> createState() => _PlacesLayoutState();
}

class _PlacesLayoutState extends State<PlacesLayout> {
  int counter = 0;

  selectedPlaceCallback(placeSelected){
    widget.selectedPlaceCallback(placeSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: getX(widget.screenWidth, placeTopArrowLeftMargin),
          top: getY(widget.screenHeight, placeTopArrowTopMargin),
          child: GestureDetector(
            onTap: (){
              _nextCounter();
            },
            child: const Icon(
              Icons.arrow_drop_up,
              size: 20,
              color: textColor,
            ),
          ),
        ),
        Positioned(
          left: getX(widget.screenWidth, placeListButtonLeftMargin),
          top: getY(widget.screenHeight, placeListButtonTopMargin),
          child: SizedBox(
            width: getWidth(widget.screenWidth, optionsNextButtonWidth),
              height: getHeight(widget.screenHeight, placeListHeight),
              child: PlacesList(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, widget.placesVM, widget.roomsVM, selectedPlaceCallback)),
        ),
        Positioned(
          left: getX(widget.screenWidth, placeBottomArrowLeftMargin),
          top: getY(widget.screenHeight, placeBottomArrowTopMargin),
          child: GestureDetector(
            onTap: (){
              _previousCounter();
            },
            child: const Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Future _previousCounter() {
    setState((){
      counter = counter - 4;
      if(counter < 0){
        counter = 0;
      }
    });
    return _scrollToCounter();
  }

  Future _nextCounter() {
    setState((){
      counter = counter + 4;
    });
    return _scrollToCounter();
  }

  Future _scrollToCounter() async {
    await controllerPlace.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
    controllerPlace.highlight(counter);
  }

}
