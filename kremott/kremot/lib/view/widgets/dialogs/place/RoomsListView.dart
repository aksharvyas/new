import 'package:flutter/material.dart';
import 'package:kremot/models/RoomsModel.dart';
import 'PlaceDialog.dart';
import 'RoomsListViewItem.dart';

class RoomsListView extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double buttonWidth;
  double buttonHeight;
  List<dynamic> roomsList;
  bool selectMultipleRooms;
  Function selectedRoomCallback;

  RoomsListView(this.screenWidth, this.screenHeight, this.buttonWidth, this.buttonHeight, this.roomsList, this.selectMultipleRooms, this.selectedRoomCallback, {Key? key})
      : super(key: key);

  @override
  State<RoomsListView> createState() => _RoomsListViewState();
}

class _RoomsListViewState extends State<RoomsListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        controller: controllerRoom,
        itemCount: widget.roomsList.length,
        itemBuilder: (context, index) {
          return RoomsListViewItem(
              widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, index, widget.roomsList, () {
            setState(() {
              if(!widget.selectMultipleRooms){
                for(int i=0;i<widget.roomsList.length;i++){
                  widget.roomsList[i].isSelected = false;
                }
              }

              widget.roomsList[index].isSelected = !widget.roomsList[index].isSelected!;

            });

            List<dynamic> listSelectedRooms = [];
            for(var getRoom in widget.roomsList){
              if(getRoom.isSelected!){
                listSelectedRooms.add(getRoom);
              }
            }

            widget.selectedRoomCallback(listSelectedRooms);
          });
        });
  }

}
