import 'package:flutter/material.dart';
import 'package:kremot/models/AddSceneScheduleModel.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/view/widgets/CustomAlertDialog.dart';
import 'package:kremot/view/widgets/DialogButton.dart';
import 'package:kremot/view/widgets/DialogCheckBox.dart';
import 'package:kremot/view/widgets/dialogs/place/PlacesLayout.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsLayout.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/AddSceneScheduleVM.dart';
import 'package:kremot/view_model/ScenesVM.dart';
import 'package:kremot/view_model/SchedulesVM.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/DeleteMultipleSchedulesModel.dart';
import '../../../models/EditSceneScheduleModel.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../models/RoomsModel.dart';
import '../../../models/SchedulesModel.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/DeleteMultipleSchedulesVM.dart';
import '../../../view_model/EditSceneScheduleVM.dart';
import '../../../view_model/PlacesWithOwnerPermissionsVM.dart';
import '../../../view_model/RoomsVM.dart';
import '../CustomDialog.dart';
import '../DialogAlertText.dart';
import '../DialogCenterButton.dart';
import '../DialogCloseButton.dart';
import '../DialogListButton.dart';
import '../DialogNote.dart';
import '../DialogRadioCheckbox.dart';
import '../DialogTitle.dart';
import '../Loading.dart';

void createSceneDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "SET SCENE",
      "EDIT SCENE",
      "DELETE SCENE",
    ];

    List<Map<String, dynamic>> listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      mapOption['selected'] = false;
      listMapOptions.add(mapOption);
    }

    int selectedPosition = -1;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 31.85, "SCENE", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, optionsListTopMargin),
                  child: ListView.builder(
                      itemCount: listMapOptions.length,
                      itemBuilder: (context, position) {
                        return Column(
                          children: [
                            DialogCenterButton(
                                listMapOptions[position]['name'],
                                optionsButtonWidth,
                                optionsButtonHeight,
                                optionsButtonTextSize, (selected) {
                              setState(() {
                                for (int i = 0;
                                i < listMapOptions.length;
                                i++) {
                                  listMapOptions[i]['selected'] = false;
                                }

                                if (selected) {
                                  selectedPosition = position;
                                  listMapOptions[position]['selected'] =
                                  true;
                                } else {
                                  selectedPosition = -1;
                                }
                              });
                            },
                                tapped: true,
                                selected: listMapOptions[position]
                                ['selected']),
                            SizedBox(
                              height: getHeight(height, 25),
                            ),
                          ],
                        );
                      }),
                ),
                if (selectedPosition != -1)
                  DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                        Navigator.pop(context);
                        switch (selectedPosition) {
                          case 0:
                            sceneSelectPlaceRoomDialog(
                                context, height, width, "SET SCENE",
                                    (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                                  scheduleScenesPairedDevicesDialog(buildContext, height, width, 0, "", selectedPlaceId, listSelectedRoomsIds[0], "", "", 0);
                                });
                            break;
                          case 1:
                            sceneSelectPlaceRoomDialog(
                                context, height, width, "EDIT SCENE",
                                    (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                                  selectEditSceneDialog(buildContext, height, width, listSelectedRoomsIds[0]);
                                });
                            break;
                          case 2:
                            sceneSelectPlaceRoomDialog(
                                context, height, width, "DELETE SCENE",
                                    (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                                  selectDeleteSceneDialog(buildContext, height, width, listSelectedRoomsIds[0]);
                                });
                            break;
                        }
                      })
              ],
            )),
      );
    });
  });
}

void sceneSelectPlaceRoomDialog(BuildContext context, double height, double width,
    String title, Function onTap) {
  PlacesWithOwnerPermissionsVM placesWithOwnerPermissionsVM =
  PlacesWithOwnerPermissionsVM();
  RoomsVM roomsVM = RoomsVM();

  RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions =
  RequestPlacesWithOwnerPermissions(
      applicationId: applicationId, appuserId: appUserId);
  placesWithOwnerPermissionsVM
      .getPlacesWithOwnerPermissions(requestPlacesWithOwnerPermissions);

  dynamic selectedPlace;
  List<dynamic> listSelectedRooms = [];

  Utils.showDialog(context, (buildContext, animation, secondaryAnimation) {
    return Center(
      child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(20.57, 21.23, title, 12.0, "Roboto"),
              DialogCloseButton(15, 18, () {
                Navigator.pop(buildContext);
              }),
              Positioned(
                left: getX(width, placeTextLeftMargin),
                top: getY(height, placeTextTopMargin),
                child: Text("PLACE",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: getAdaptiveTextSize(context, placeRoomTextSize)),
                    textAlign: TextAlign.center),
              ),
              Positioned(
                left: getX(width, roomTextLeftMargin),
                top: getY(height, roomTextTopMargin),
                child: Text("ROOM",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: getAdaptiveTextSize(context, placeRoomTextSize)),
                    textAlign: TextAlign.center),
              ),
              PlacesLayout(
                  width,
                  height,
                  getHeight(height, 150),
                  getWidth(width, 82.61),
                  getHeight(height, 27.56),
                  placesWithOwnerPermissionsVM,
                  roomsVM, false, (place) {
                selectedPlace = place;
                listSelectedRooms.clear();
              }),
              RoomsLayout(
                  width,
                  height,
                  getHeight(height, 150),
                  getWidth(width, 82.61),
                  getHeight(height, 27.56),
                  roomsVM,
                  false, false, (rooms) {
                listSelectedRooms = rooms;
              }),
              Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: ChangeNotifierProvider<PlacesWithOwnerPermissionsVM>.value(
                    value: placesWithOwnerPermissionsVM,
                    child: Consumer<PlacesWithOwnerPermissionsVM>(
                      builder: (context, viewModel, view) {
                        switch (viewModel.placesWithOwnerPermissionsData.status) {
                          case ApiStatus.COMPLETED:
                            List<AppUserAccessOwnerPermissions>?
                            listPlaces = viewModel
                                .placesWithOwnerPermissionsData
                                .data!
                                .value!
                                .appUserAccessPermissions;

                            if (listPlaces != null && listPlaces.isNotEmpty) {
                              return DialogCenterButton("NEXT", optionsNextButtonWidth,
                                  optionsNextButtonHeight,
                                  optionsNextButtonTextSize, (selected) {
                                    if (listSelectedRooms.isNotEmpty) {
                                      Navigator.pop(buildContext);
                                      List<String> listSelectedRoomsIds = [];
                                      for(var room in listSelectedRooms){
                                        listSelectedRoomsIds.add(room.roomId);
                                      }
                                      onTap(buildContext, selectedPlace.homeId, listSelectedRoomsIds);
                                    } else {
                                      showToastFun(buildContext, "Please select room");
                                    }
                                  });
                            }
                            return Container();
                          default:
                        }
                        return Container();
                      },
                    ),
                  )
              ),
              DialogNote(50, 316.63, "NOTE: SELECT 1 PLACE & ROOM AT A TIME"),
            ],
          )),
    );
  });
}

void scheduleScenesPairedDevicesDialog(
    BuildContext context, double height, double width, int selectedScheduleId, String selectedScheduleName, String selectedPlaceId, String selectedRoomId, String getDate, String getTime, int getRepeat) {

  bool isFanSelected = false;

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    int selectedTabPosition = 0;

    RequestScenes requestScenes = RequestScenes(applicationId: applicationId, roomId: selectedRoomId);

    ScenesVM scenesVM = ScenesVM();
    scenesVM.getScenes(requestScenes);

    String selectedSceneId = "";

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 21.23, "SET SCENE", 12.0, "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                // Positioned(
                //   left: getX(width, optionsNextButtonLeftMargin),
                //   top: getY(height, optionsListTopMargin),
                //   child: DialogListButton(
                //     "SCENE",
                //     optionsNextButtonWidth,
                //     optionsNextButtonHeight,
                //     optionsTextSize,
                //         () {
                //
                //     },
                //     tapped: true,
                //     selected: selectedTabPosition == 0,
                //   ),
                // ),
                Positioned.fill(
                  top: getY(height, dialogListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogListHeight),
                        child: ChangeNotifierProvider<ScenesVM>.value(
                          value: scenesVM,
                          child: Consumer<ScenesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.scenesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "ScenesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "ScenesList :: ERROR${viewModel.scenesData.message}");
                                  return Center(
                                      child: DefaultTextStyle(
                                          style: const TextStyle(),
                                          child: Text(
                                            "No Scenes found!",
                                            style: apiMessageTextStyle(context),
                                            textAlign: TextAlign.center,
                                          )));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "ScenesList :: COMPLETED");

                                  List<SceneList>?
                                  listScenes = viewModel
                                      .scenesData
                                      .data!
                                      .value!
                                      .sceneList;

                                  if (listScenes == null ||
                                      listScenes.isEmpty) {
                                    return Center(
                                        child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              "No Scenes found!",
                                              style: apiMessageTextStyle(context),
                                              textAlign: TextAlign.center,
                                            )));
                                  } else {
                                    Utils.printMsg(
                                        "ScenesList${listScenes.length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listScenes.length,
                                        itemBuilder: (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listScenes[position].name!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize, (selected) {
                                                setState((){
                                                  for (int i = 0; i < listScenes.length; i++) {
                                                    listScenes[i].isSelected = false;
                                                  }

                                                  if (selected) {
                                                    selectedSceneId = listScenes[position].id!;
                                                    listScenes[position].isSelected = true;
                                                  } else {
                                                    selectedSceneId = "";
                                                  }
                                                });
                                              }, tapped: true,
                                                  selected: listScenes[position].isSelected),
                                              SizedBox(
                                                height: getY(height, 16.35),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                default:
                              }
                              return const Loading();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if(selectedSceneId.isNotEmpty) Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: DialogCenterButton("DONE", optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize,
                          (selected) {
                        Navigator.pop(context);

                      }),
                ),
              ],
            )),
      );
    });
  });

}

void selectEditSceneDialog(
    BuildContext context, double height, double width, String selectedRoomId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    // List<String> listOptions = [
    //   "SCENE 1",
    //   "SCENE 2",
    //   "SCENE 3",
    //   "SCENE 4",
    //   "SCENE 5"
    // ];
    //
    // List<Map<String, dynamic>> listMapOptions = [];
    // for (var optionName in listOptions) {
    //   Map<String, dynamic> mapOption = {};
    //   mapOption['name'] = optionName;
    //   mapOption['date'] = "2023-01-04T07:25:58.416Z";
    //   mapOption['time'] = "2023-01-04T07:25:58.416Z";
    //   mapOption['repeat'] = 1;
    //   mapOption['selected'] = false;
    //   listMapOptions.add(mapOption);
    // }

    RequestScenes requestScenes = RequestScenes(applicationId: applicationId, roomId: selectedRoomId);

    ScenesVM scenesVM = ScenesVM();
    scenesVM.getScenes(requestScenes);

    String selectedSceneId = "";
    // String selectedScheduleName = "";
    // String getDate = "";
    // String getTime = "";
    // int getRepeat = 0;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 31.85, "EDIT SCENE", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, dialogListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogListHeight),
                        child: ChangeNotifierProvider<ScenesVM>(
                          create: (BuildContext context) => scenesVM,
                          child: Consumer<ScenesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.scenesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "ScenesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "ScenesList :: ERROR${viewModel.scenesData.message}");
                                  return Center(
                                      child: DefaultTextStyle(
                                          style: const TextStyle(),
                                          child: Text(
                                            "No Scenes found!",
                                            style: apiMessageTextStyle(context),
                                            textAlign: TextAlign.center,
                                          )));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "ScenesList :: COMPLETED");

                                  List<SceneList>?
                                  listScenes = viewModel
                                      .scenesData
                                      .data!
                                      .value!
                                      .sceneList;

                                  if (listScenes == null || listScenes.isEmpty) {
                                    return Center(
                                        child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              "No Scenes found!",
                                              style: apiMessageTextStyle(context),
                                              textAlign: TextAlign.center,
                                            )));
                                  } else {
                                    Utils.printMsg(
                                        "ScenesList${listScenes.length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listScenes.length,
                                        itemBuilder: (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listScenes[position].name!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize, (selected) {
                                                setState(() {
                                                  if (selected) {
                                                    setState(() {
                                                      selectedSceneId = listScenes[position].id!;
                                                      for (int i = 0; i < listScenes.length; i++) {
                                                        listScenes[i].isSelected = false;
                                                      }
                                                      listScenes[position].isSelected = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      selectedSceneId = "";
                                                      listScenes[position].isSelected = false;
                                                    });
                                                  }
                                                });
                                              },
                                                  tapped: true,
                                                  selected: listScenes[position].isSelected),
                                              SizedBox(
                                                height: getHeight(height, 15),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                default:
                              }
                              return const Loading();
                            },
                          ),
                        ),
                        // child: ListView.builder(
                        //     padding: EdgeInsets.zero,
                        //     itemCount: listMapOptions.length,
                        //     itemBuilder: (context, position) {
                        //       return Column(
                        //         children: [
                        //           DialogCenterButton(
                        //               listMapOptions[position]['name'],
                        //               optionsButtonWidth,
                        //               optionsButtonHeight,
                        //               optionsButtonTextSize, (selected) {
                        //             setState(() {
                        //               if (selected) {
                        //                 setState(() {
                        //                   selectedScheduleId = position + 1;
                        //                   selectedScheduleName = listMapOptions[position]['name'];
                        //                   getDate = listMapOptions[position]['date'];
                        //                   getTime = listMapOptions[position]['time'];
                        //                   getRepeat = listMapOptions[position]['repeat'];
                        //                   for (int i = 0;
                        //                   i < listMapOptions.length;
                        //                   i++) {
                        //                     listMapOptions[i]['selected'] =
                        //                     false;
                        //                   }
                        //                   listMapOptions[position]
                        //                   ['selected'] = true;
                        //                 });
                        //               } else {
                        //                 setState(() {
                        //                   selectedScheduleId = 0;
                        //                   selectedScheduleName = "";
                        //                   getDate = "";
                        //                   getTime = "";
                        //                   getRepeat = 0;
                        //                   listMapOptions[position]
                        //                   ['selected'] = false;
                        //                 });
                        //               }
                        //             });
                        //           },
                        //               tapped: true,
                        //               selected: listMapOptions[position]
                        //               ['selected']),
                        //           SizedBox(
                        //             height: getHeight(height, dialogListItemsVerticalMargin),
                        //           ),
                        //         ],
                        //       );
                        //     }),
                      ),
                    ],
                  ),
                ),
                if (selectedSceneId.isNotEmpty)
                  DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                        Navigator.pop(context);

                      })
              ],
            )),
      );
    });
  });

}

void selectDeleteSceneDialog(
    BuildContext context, double height, double width, String selectedRoomId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    // List<String> listOptions = [
    //   "SCENE 1",
    //   "SCENE 2",
    //   "SCENE 3",
    //   "SCENE 4",
    //   "SCENE 5"
    // ];
    //
    // List<Map<String, dynamic>> listMapOptions = [];
    // for (var optionName in listOptions) {
    //   Map<String, dynamic> mapOption = {};
    //   mapOption['name'] = optionName;
    //   mapOption['selected'] = false;
    //   listMapOptions.add(mapOption);
    // }

    RequestScenes requestScenes = RequestScenes(applicationId: applicationId, roomId: selectedRoomId);

    ScenesVM scenesVM = ScenesVM();
    scenesVM.getScenes(requestScenes);

    List<String> listSelectedScenesIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57, 31.85, "DELETE SCENE", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  left: getX(width, 45.45),
                  right: getX(width, 51.32),
                  top: getY(height, dialogListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogListHeight),
                        child: ChangeNotifierProvider<ScenesVM>(
                          create: (BuildContext context) => scenesVM,
                          child: Consumer<ScenesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.scenesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "ScenesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "ScenesList :: ERROR${viewModel.scenesData.message}");
                                  return Center(
                                      child: DefaultTextStyle(
                                          style: const TextStyle(),
                                          child: Text(
                                            "No Scenes found!",
                                            style: apiMessageTextStyle(context),
                                            textAlign: TextAlign.center,
                                          )));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "ScenesList :: COMPLETED");

                                  List<SceneList>?
                                  listScenes = viewModel
                                      .scenesData
                                      .data!
                                      .value!
                                      .sceneList;

                                  if (listScenes == null ||
                                      listScenes.isEmpty) {
                                    return Center(
                                        child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              "No Scenes found!",
                                              style: apiMessageTextStyle(context),
                                              textAlign: TextAlign.center,
                                            )));
                                  } else {
                                    Utils.printMsg(
                                        "ScenesList${listScenes.length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listScenes.length,
                                        itemBuilder: (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listScenes[position].name!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize, (selected) {
                                                setState(() {
                                                  if (selected) {
                                                    listSelectedScenesIds.add(listScenes[position].id!);
                                                    listScenes[position].isSelected = true;
                                                  } else {
                                                    listSelectedScenesIds.remove(listScenes[position].id);
                                                    listScenes[position].isSelected = false;
                                                  }
                                                });
                                              },
                                                  tapped: true,
                                                  selected: listScenes[position].isSelected),
                                              SizedBox(
                                                height: getHeight(height, 15),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                default:
                              }
                              return const Loading();
                            },
                          ),
                        ),
                        // child: ListView.builder(
                        //     padding: EdgeInsets.zero,
                        //     itemCount: listMapOptions.length,
                        //     itemBuilder: (context, position) {
                        //       return Column(
                        //         children: [
                        //           DialogCenterButton(
                        //               listMapOptions[position]['name'],
                        //               optionsButtonWidth,
                        //               optionsButtonHeight,
                        //               optionsButtonTextSize, (selected) {
                        //             setState(() {
                        //               if (selected) {
                        //                 listSelectedScenesIds.add(position);
                        //                 listMapOptions[position]
                        //                 ['selected'] = true;
                        //               } else {
                        //                 listSelectedScenesIds.remove(position);
                        //                 listMapOptions[position]
                        //                 ['selected'] = false;
                        //               }
                        //             });
                        //           },
                        //               tapped: true,
                        //               selected: listMapOptions[position]
                        //               ['selected']),
                        //           SizedBox(
                        //             height: getHeight(height, dialogListItemsVerticalMargin),
                        //           ),
                        //         ],
                        //       );
                        //     }),
                      ),
                    ],
                  ),
                ),
                if (listSelectedScenesIds.isNotEmpty)
                  DialogButton("DELETE", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                        alertDeleteSceneDialog(context, height, width, listSelectedScenesIds);
                      })
              ],
            )),
      );
    });
  });

}

void alertDeleteSceneDialog(
    BuildContext context, double height, double width, List<String> listSelectedSceneIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        188.45,
        129.17,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(5, 44.24,
                "ARE YOU SURE YOU WANT\nTO DELETE SCENE?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(context);
                      alertDeleteSceneDialog(context, height, width, listSelectedSceneIds);
                    }),
                    DialogListButton("NO", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(context);
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  });

}

void alertDeleteSceneDialogAgain(
    BuildContext context, double height, double width, List<int> listSelectedScenesIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        188.45,
        129.17,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(5, 44.24,
                "ARE YOU SURE YOU WANT\nTO DELETE SCENE?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("NO", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(context);
                    }),
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {

                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  });

}
