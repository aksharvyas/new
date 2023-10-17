import 'package:flutter/material.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vibration/vibration.dart';

import '../../../utils/Utils.dart';

class HomePagePlacesListView extends StatefulWidget {
  double width;
  double height;
  List<AppUserAccessOwnerPermissions> listPlaces;
  AutoScrollController controllerPlace;
  HomePagePlacesListView(this.width, this.height, this.listPlaces, this.controllerPlace, {Key? key}) : super(key: key);

  @override
  State<HomePagePlacesListView> createState() => _HomePagePlacesListViewState();
}

class _HomePagePlacesListViewState extends State<HomePagePlacesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.listPlaces.length,
      itemBuilder: (context, index) {
        return AutoScrollTag(
            key: ValueKey(index),
            controller: widget.controllerPlace,
            index: index,
            child: GestureDetector(
              onTap: (){
                Utils.vibrateSound();
                setState(() {
                  for (int i=0;i<widget.listPlaces.length;i++) {
                    widget.listPlaces[i].isSelected = false;
                  }
                  widget.listPlaces[index].isSelected = true;
                });

                showToastFun(
                    context, '${widget.listPlaces[index].homeName!} is Apply');
              },
              child: getHomeHorizontalItem(
                  context,
                  widget.listPlaces[index].isSelected!,
                  widget.listPlaces[index].homeName!,
                  widget. height,
                  widget.width,
                  getHeight(widget.height, homePageListButtonHeight),
                  getWidth(widget.width, homePageListButtonWidth)),
            ));
      },
    );
  }
}
