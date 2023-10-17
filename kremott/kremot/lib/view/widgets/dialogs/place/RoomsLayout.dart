import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsList.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../res/AppColors.dart';
import '../../../../res/AppDimensions.dart';
import '../../../../view_model/RoomsVM.dart';
import 'PlaceDialog.dart';
import '../../widget.dart';

class RoomsLayout extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double listViewHeight;
  double buttonWidth;
  double buttonHeight;
  dynamic roomsVM;
  bool selectMultipleRooms;
  bool isPairingDialog;
  Function selectedRoomCallback;

  RoomsLayout(this.screenWidth, this.screenHeight, this.listViewHeight, this.buttonWidth, this.buttonHeight, this.roomsVM, this.selectMultipleRooms, this.isPairingDialog, this.selectedRoomCallback, {Key? key}) : super(key: key);

  @override
  State<RoomsLayout> createState() => _RoomsLayoutState();
}

class _RoomsLayoutState extends State<RoomsLayout> {
  int counter = 0;

  selectedRoomCallback(roomsSelected){
    widget.selectedRoomCallback(roomsSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: getX(widget.screenWidth, widget.isPairingDialog ? 227 : roomTopArrowLeftMargin),
          top: getY(widget.screenHeight, roomTopArrowTopMargin),
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
          left: getX(widget.screenWidth, widget.isPairingDialog ? 206 :  roomListButtonLeftMargin),
          top: getY(widget.screenHeight, roomListButtonTopMargin),
          child: SizedBox(
              width: getWidth(widget.screenWidth, optionsNextButtonWidth),
              height: getHeight(widget.screenHeight, roomListHeight),
              child: RoomsList(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, widget.roomsVM, widget.selectMultipleRooms, widget.isPairingDialog, selectedRoomCallback)),
        ),
        Positioned(
          left: getX(widget.screenWidth, widget.isPairingDialog ? 227 : roomBottomArrowLeftMargin),
          top: getY(widget.screenHeight, roomBottomArrowTopMargin),
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
        ),      ],
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
    await controllerRoom.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
    controllerRoom.highlight(counter);
  }

}