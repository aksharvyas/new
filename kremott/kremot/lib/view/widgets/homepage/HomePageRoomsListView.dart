import 'package:flutter/material.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vibration/vibration.dart';

import '../../../models/RoomsModel.dart';
import '../../../utils/Utils.dart';

class HomePageRoomsListView extends StatefulWidget {
  double width;
  double height;
  List<AppUserAccessPermissionsRoom> listRooms;
  AutoScrollController controllerRoom;
  HomePageRoomsListView(this.width, this.height, this.listRooms, this.controllerRoom, {Key? key}) : super(key: key);

  @override
  State<HomePageRoomsListView> createState() => _HomePageRoomsListViewState();
}

class _HomePageRoomsListViewState extends State<HomePageRoomsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.listRooms.length,
      itemBuilder: (context, index) {
        return AutoScrollTag(
            key: ValueKey(index),
            controller: widget.controllerRoom,
            index: index,
            child: GestureDetector(
              onTap: (){
                Utils.vibrateSound();
                setState(() {
                  for (int i=0;i<widget.listRooms.length;i++) {
                    widget.listRooms[i].isSelected = false;
                  }
                  widget.listRooms[index].isSelected = true;
                });

                showToastFun(
                    context, '${widget.listRooms[index].roomName!} is Apply');
              },
              child: getHomeHorizontalItem(
                  context,
                  widget.listRooms[index].isSelected!,
                  widget.listRooms[index].roomName!,
                  widget.height,
                  widget.width,
                  getHeight(widget.height, homePageListButtonHeight),
                  getWidth(widget.width, homePageListButtonWidth)),
            ));
      },
    );
  }
}
