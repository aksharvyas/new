import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kremot/data/remote/response/ApiStatus.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/res/AppStyles.dart';
import 'package:kremot/utils/Utils.dart';
import 'package:kremot/view/HomePage.dart';
import 'package:kremot/view/widgets/DialogTextfield.dart';
import 'package:kremot/view/widgets/Loading.dart';
import 'package:kremot/view/widgets/homepage/HomePageScenesListView.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/ScenesVM.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vibration/vibration.dart';

import '../../../models/FanItem.dart';
import '../../../models/LightItem.dart';
import '../../../models/SceneItem.dart';
import '../../../res/AppColors.dart';
import '../../../utils/Constants.dart';
import '../DialogButton.dart';
import '../DialogCenterButton.dart';
import '../DialogCloseButton.dart';
import '../DialogTitle.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../squareprogress.dart';

class HomePageScenesList extends StatefulWidget {
  double width;
  double height;
  ScenesVM scenesVM;
  bool isExpandPair;
  Function selectedSceneCallback;
  Function sceneLongPressCallback;

  HomePageScenesList(this.width, this.height, this.scenesVM, this.isExpandPair,
      this.selectedSceneCallback, this.sceneLongPressCallback,
      {Key? key})
      : super(key: key);

  @override
  State<HomePageScenesList> createState() => HomePageScenesListState();
}

class HomePageScenesListState extends State<HomePageScenesList> {
  List<SceneList>? listScenes = [];
  int _currentFocusedIndex = 0;
  AutoScrollController controllerScene = AutoScrollController();
  static var sceneList = [
    HomePageSceneItem('SCENE 1', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 2', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 3', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 4', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 5', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 6', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 7', unSelectedButtonImage, false, FocusNode()),
    HomePageSceneItem('SCENE 8', unSelectedButtonImage, false, FocusNode()),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: animatedDuration),
          top: getY(widget.height, widget.isExpandPair ? 188 : 134),
          left: getX(widget.width, 11),
          child: GestureDetector(
            onTap: () {
              _currentFocusedIndex--;
              if (_currentFocusedIndex < 0) {
                _currentFocusedIndex = listScenes!.length - 1;
              }

              controllerScene.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);

              setState(() {});
            },
            child: const Icon(
              Icons.arrow_left,
              size: 20,
              color: arrowColor,
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: animatedDuration),
            top: getY(widget.height, widget.isExpandPair ? 178 : 124),
            left: getX(widget.width, 30),
            right: getX(widget.width, 30),
            child: SizedBox(
              height: getHeight(widget.height, 38.55),
              child: PageView.builder(
                padEnds: false,
                controller: PageController(viewportFraction: 1 / 3.8),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        onScene(index);
                        if (widget.selectedSceneCallback() != null ||
                            widget.selectedSceneCallback() == "null") {
                          widget.selectedSceneCallback();
                        }
                      },
                      onLongPress: () {
                        widget.sceneLongPressCallback();
                        renameSceneDialog(
                            context,
                            widget.height,
                            widget.width,
                            index % sceneList.length,
                            sceneList[index % sceneList.length]._name);
                      },
                      child: getHomeHorizontalItem(
                          context,
                          !HomePageState.scenesEnabled
                              ? unSelectedButtonImage
                              : sceneList[index % sceneList.length]._image,
                          sceneList[index % sceneList.length]._name,
                          widget.height,
                          widget.width,
                          getHeight(widget.height, homePageListButtonHeight),
                          getWidth(widget.width, homePageListButtonWidth),
                          index % sceneList.length));
                },
              ),
              // child: PageView(
              //   padEnds: false,
              //   controller: PageController(viewportFraction: 1/3.8, initialPage: 999),
              //   children: getSceneList(context, widget.width, widget.height),
              // ),
              // child: ListView.separated(
              //   itemCount: sceneList.length,
              //  itemBuilder: (context, index){
              //    return AutoScrollTag(
              //        key: ValueKey(index),
              //        controller: controllerScene,
              //        index: index,
              //        child: GestureDetector(
              //          onTap: (){
              //            Utils.vibrateSound();
              //            setState(() {
              //              HomePageState.scenesEnabled = true;
              //              if(sceneList[index].getImage() == "assets/images/next_on.png"){
              //                //sceneList[index].setImage("assets/images/next_off.png");
              //              } else{
              //                for(HomePageSceneItem sceneItem in sceneList){
              //                  sceneItem.setImage("assets/images/next_off.png");
              //                }
              //                sceneList[index].setImage("assets/images/next_on.png");
              //              }
              //            });
              //          },
              //          onLongPress: (){
              //            renameSceneDialog(context, widget.height, widget.width, index);
              //          },
              //          child: getHomeHorizontalItem(
              //              context,
              //              !HomePageState.scenesEnabled ? "assets/images/next_off.png" : sceneList[index].getImage(),
              //              sceneList[index].getName(),
              //              widget.height,
              //              widget.width,
              //              getHeight(widget.height, homePageListButtonHeight),
              //              getWidth(widget.width, homePageListButtonWidth), index),
              //        ));
              //  },
              // separatorBuilder: (context, index) => SizedBox(
              //   width: getWidth(widget.width, homePageItemHorizontalMargin),
              // ),
              //   physics: const PageScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   controller: controllerScene,
              //   // children:
              //   // getSceneList(context, widget.width, widget.height),
              // ),
            )),
        // Positioned(
        //     top: getY(widget.height, widget.isExpandPair ? 178 : 124),
        //     left: getX(widget.width, 30),
        //     right: getX(widget.width, 30),
        //     child: SizedBox(
        //       height: getHeight(widget.height, 34),
        //       child: ChangeNotifierProvider<ScenesVM>.value(
        //         value: widget.scenesVM,
        //         child: Consumer<ScenesVM>(
        //           builder: (context, viewModel, view) {
        //             switch (viewModel.scenesData.status) {
        //               case ApiStatus.LOADING:
        //                 Utils.printMsg(
        //                     "ScenesList :: LOADING");
        //                 return const Loading();
        //               case ApiStatus.ERROR:
        //                 Utils.printMsg(
        //                     "ScenesList :: ERROR${viewModel.scenesData.message}");
        //                 return Center(
        //                     child: DefaultTextStyle(
        //                         style: const TextStyle(),
        //                         child: Text(
        //                           "No Scenes found!",
        //                           style: apiMessageTextStyle(context),
        //                           textAlign: TextAlign.center,
        //                         )));
        //               case ApiStatus.COMPLETED:
        //                 Utils.printMsg(
        //                     "ScenesList :: COMPLETED");
        //
        //                 listScenes = viewModel
        //                     .scenesData
        //                     .data!
        //                     .value!
        //                     .sceneList;
        //
        //                 if (listScenes == null ||
        //                     listScenes!.isEmpty) {
        //                   return Center(
        //                       child: DefaultTextStyle(
        //                           style: const TextStyle(),
        //                           child: Text(
        //                             "No Scenes found!",
        //                             style: apiMessageTextStyle(context),
        //                             textAlign: TextAlign.center,
        //                           )));
        //                 } else {
        //                   Utils.printMsg(
        //                       "ScenesList${listScenes!.length}");
        //
        //                   return HomePageScenesListView(widget.width, widget.height, listScenes!, controllerScene);
        //                 }
        //               default:
        //             }
        //             return Container();
        //           },
        //         ),
        //       ),
        //     )),
        AnimatedPositioned(
          duration: const Duration(milliseconds: animatedDuration),
          right: getX(widget.width, 11),
          top: getY(widget.height, widget.isExpandPair ? 188 : 134),
          child: GestureDetector(
            onTap: () {
              _currentFocusedIndex++;
              if (_currentFocusedIndex > listScenes!.length) {
                _currentFocusedIndex = 0;
              }
              controllerScene.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);
              setState(() {});
            },
            child: const Icon(
              Icons.arrow_right,
              size: 20,
              color: arrowColor,
            ),
          ),
        ),
      ],
    );
  }

  // List<Widget> getSceneList(double width, double height) {
  //   HomePageState homePageState = HomePageState();
  //   return List.generate(
  //     homePageState.sceneItems.length,
  //         (index) =>
  //         AutoScrollTag(
  //             key: ValueKey(index),
  //             controller: controllerScene,
  //             index: index,
  //             child: InkWell(
  //               onTapDown: (TapDownDetails details) {
  //                 Vibration.vibrate(duration: 100);
  //                 setState(() {
  //                   homePageState.sceneItems[index].setImage(
  //                       "assets/images/menuitemselect.png");
  //                   homePageState.sceneItems[index].setSelectd(true);
  //                 });
  //
  //                homePageState.sendCommandCMID(
  //                     LightItem.name(0),
  //                     FanItem.name(0),
  //                     false,
  //                     homePageState.sceneItems[index],
  //                     true,
  //                     false,
  //                     false,
  //                     false,
  //                     false,
  //                     false,
  //                     false);
  //
  //
  //                 homePageState.sceneItems[index].time = Timer.periodic(const Duration(
  //                     milliseconds: 15), (Timer t) {
  //                   setState(() {
  //                     homePageState.sceneItems[index].itemCount =
  //                     (homePageState.sceneItems[index].itemCount + 1);
  //                   });
  //                   if (homePageState.sceneItems[index].itemCount >= 100) {
  //                     setState(() {
  //                       homePageState.sceneItems[index].time.cancel();
  //                       homePageState.sceneItems[index].itemCount = 0;
  //                     });
  //                   }
  //                 });
  //
  //                 // showToastFun(
  //                 //     context, '${sceneList[index].getName()} is Apply');
  //               },
  //               // onTapUp: (TapUpDetails details) {
  //               //   Vibration.vibrate(duration: 100);
  //               //   setState(() {
  //               //     _sceneItem[index].setImage("assets/images/menuitem.png");
  //               //   });
  //               // },
  //               child: getHomeHorizontalItems(
  //                   context,
  //                   false,
  //                   homePageState.sceneItems[index].getName(),
  //                   height,
  //                   width,
  //                   getHeight(height, 38.96),
  //                   getWidth(width, 74.89),
  //                   homePageState.sceneItems[index].getSelected(),
  //                   homePageState.sceneItems[index].itemCount),
  //             )),
  //   );
  // }
  List<Widget> getSceneList(BuildContext context, double width, double height) {
    return List.generate(
      sceneList.length,
      (index) => GestureDetector(
        onTap: () {
          Utils.vibrateSound();
          setState(() {
            HomePageState.scenesEnabled = true;
            if (sceneList[index]._image == selectedButtonImage) {
              //sceneList[index].setImage("assets/images/next_off.png");
            } else {
              for (HomePageSceneItem sceneItem in sceneList) {
                sceneItem._image = unSelectedButtonImage;
              }
              sceneList[index]._image = selectedButtonImage;
            }
            HomePageState homePageState = HomePageState();
            homePageState.sendCommandCMID(
                LightItem.name(0),
                FanItem.name(0),
                false,
                homePageState.sceneItems[index],
                true,
                false,
                false,
                false,
                false,
                false,
                false);
            widget.selectedSceneCallback();
          });
        },
        onLongPress: () {
          widget.sceneLongPressCallback();
          renameSceneDialog(
              context, height, width, index, sceneList[index]._name);
        },
        child: getHomeHorizontalItem(
            context,
            !HomePageState.scenesEnabled
                ? unSelectedButtonImage
                : sceneList[index]._image,
            sceneList[index]._name,
            height,
            width,
            getHeight(height, homePageListButtonHeight),
            getWidth(width, homePageListButtonWidth),
            index),
      ),
    );
  }

  Widget getHomeHorizontalItem(
      BuildContext context,
      String image,
      String name,
      double screenHeight,
      double screenWidth,
      double height,
      double width,
      int selectedSceneIndex) {
    TextEditingController editingController = TextEditingController();
    editingController.text = name;
    editingController.selection = TextSelection.fromPosition(
        TextPosition(offset: editingController.text.length));

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(image, height: height, width: width, fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: TextField(
                  enableInteractiveSelection: false,
                  cursorColor: dialogTitleColor,
                  focusNode: sceneList[selectedSceneIndex]._focusNode,
                  //autofocus: true,
                  controller: editingController,
                  enabled: sceneList[selectedSceneIndex].isEditable,
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        editingController.text = text.toUpperCase();
                        sceneList[selectedSceneIndex]._name =
                            text.toUpperCase();
                        sceneList[selectedSceneIndex].isEditable = false;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                      height: cursorHeight,
                      decoration: TextDecoration.none,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      //fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      fontSize:
                          getAdaptiveTextSize(context, homePageButtonTextSize)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(textFieldMaxLength),
                  ],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: getWidth(width, homePageItemHorizontalMargin),
        ),
      ],
    );
  }

  Widget getHomeHorizontalItems(
      BuildContext context,
      bool selected,
      String name,
      double screenHeight,
      double screenWidth,
      double height,
      double width,
      bool selected1,
      int itemCount) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
                selected
                    ? "assets/images/next_on.png"
                    : "assets/images/next_off.png",
                height: height,
                width: width,
                fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                //alignment: Alignment.topCenter,
                child: SquarePercentIndicatorWidget(
                  height: getHeight(screenHeight, 38.96),
                  width: getWidth(screenWidth, 74.89),
                  startAngle: StartAngle.topLeft,
                  reverse: selected1,
                  progress: itemCount / 100,

                  // reverse: true,
                  // borderRadius: 12,
                  shadowWidth: 0.1,
                  progressWidth: 1,
                  shadowColor: Colors.white,
                  progressColor: Colors.white,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(name,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            fontSize: getAdaptiveTextSize(
                                context, homePageButtonTextSize)),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: getWidth(screenWidth, 16),
        ),
      ],
    );
  }

  void renameSceneDialog(BuildContext context, double height, double width,
      int selectedPos, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Align(
            alignment: const Alignment(0, -0.5),
            child: Container(
              width: getWidth(width, renameDialogWidth),
              height: getHeight(height, renameDialogHeight + 15.0),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(14.86390495300293)),
                border: Border.all(
                    color: homePageDividerColor, width: 1.0617074966430664),
                // boxShadow: const [
                //   BoxShadow(
                //       color: Color(0x40000000),
                //       offset: Offset(5.308538436889648, 5.308538436889648),
                //       blurRadius: 6.370244979858398,
                //       spreadRadius: 0)
                // ],
                //color: const Color(0xff484949)
                image: const DecorationImage(
                    image: AssetImage(alertDialogBg), fit: BoxFit.fill),
              ),
//color: Colors.white,

              child: Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          fontSize: getAdaptiveTextSize(context, 12.0)),
                    ),
                    DialogCenterButton("RENAME", optionsButtonWidth,
                        optionsButtonHeight, optionsButtonTextSize, (selected) {
                      Navigator.pop(context);
                      setState(() {
                        for (int i = 0; i < sceneList.length; i++) {
                          sceneList[i].isEditable = false;
                        }
                        sceneList[selectedPos].isEditable = true;

                        Future.delayed(const Duration(milliseconds: 100),
                            () async {
                          FocusManager.instance.primaryFocus
                              ?.requestFocus(sceneList[selectedPos]._focusNode);
                        });
                      });
                    }),
                    DialogCenterButton("SAVE SCENE", optionsButtonWidth,
                        optionsButtonHeight, optionsButtonTextSize, () {
                      HomePageState homepageState = HomePageState();
                      homepageState.getSwitchScene();
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  onScene(int index) async {
    Utils.vibrateSound();

    HomePageState.scenesEnabled = true;
    if (sceneList[index % sceneList.length]._image == selectedButtonImage) {
    } else {
      for (HomePageSceneItem sceneItem in sceneList) {
        sceneItem._image = unSelectedButtonImage;
      }
      sceneList[index % sceneList.length]._image = selectedButtonImage;
    }



  }
}

class HomePageSceneItem extends ChangeNotifier {
  late String _name;
  late String _image;
  late bool isEditable;
  late FocusNode _focusNode;

  HomePageSceneItem(this._name, this._image, this.isEditable, this._focusNode);
}
