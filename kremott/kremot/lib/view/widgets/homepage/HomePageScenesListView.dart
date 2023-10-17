import 'package:flutter/material.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vibration/vibration.dart';

import '../../../utils/Utils.dart';

class HomePageScenesListView extends StatefulWidget {
  double width;
  double height;
  List<SceneList> listScenes;
  AutoScrollController controllerScene;
  HomePageScenesListView(this.width, this.height, this.listScenes, this.controllerScene, {Key? key}) : super(key: key);

  @override
  State<HomePageScenesListView> createState() => _HomePageScenesListViewState();
}

class _HomePageScenesListViewState extends State<HomePageScenesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.listScenes.length,
      itemBuilder: (context, index) {
        return AutoScrollTag(
            key: ValueKey(index),
            controller: widget.controllerScene,
            index: index,
            child: GestureDetector(
              onTap: (){

                Utils.vibrateSound();
                setState(() {
                  for (int i=0;i<widget.listScenes.length;i++) {
                    widget.listScenes[i].isSelected = false;
                  }
                  widget.listScenes[index].isSelected = true;
                });

                showToastFun(
                    context, '${widget.listScenes[index].name!} is Apply');
              },
              child: getHomeHorizontalItem(
                  context,
                  widget.listScenes[index].isSelected!,
                  widget.listScenes[index].name!,
                  widget.height,
                  widget.width,
                  getHeight(widget.height, homePageListButtonHeight),
                  getWidth(widget.width, homePageListButtonWidth)),
            ));
      },
    );
  }
}
