import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kremot/models/AddSceneScheduleModel.dart';
import 'package:kremot/models/AddSwitchScheduleModel.dart';
import 'package:kremot/models/EditSwitchScheduleModel.dart';
import 'package:kremot/models/PairedDevicesModel.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/view/widgets/CustomAlertDialog.dart';
import 'package:kremot/view/widgets/DialogButton.dart';
import 'package:kremot/view/widgets/DialogCheckBox.dart';
import 'package:kremot/view/widgets/dialogs/place/PlacesLayout.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsLayout.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/AddSceneScheduleVM.dart';
import 'package:kremot/view_model/PairedDevicesVM.dart';
import 'package:kremot/view_model/ScenesVM.dart';
import 'package:kremot/view_model/SchedulesVM.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/DeleteMultipleSchedulesModel.dart';
import '../../../models/EditSceneScheduleModel.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../models/SchedulesModel.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/AddSwitchScheduleVM.dart';
import '../../../view_model/DeleteMultipleSchedulesVM.dart';
import '../../../view_model/EditSceneScheduleVM.dart';
import '../../../view_model/EditSwitchScheduleVM.dart';
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

void createScheduleDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {

    List<String> listOptions = [
      "SET\nSCHEDULE",
      "EDIT\nSCHEDULE",
      "DELETE SCHEDULE",
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
                DialogTitle(20.57, 31.85, "SCHEDULE", 12.0, "Roboto"),
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
                  DialogButton(
                      "NEXT",
                      optionsNextButtonLeftMargin,
                      optionsNextButtonTopMargin,
                      optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                    Navigator.pop(context);
                    switch (selectedPosition) {
                      case 0:
                        scheduleSelectPlaceRoomDialog(
                            context, height, width, "SET SCHEDULE",
                                (buildContext, selectedPlaceId,
                                listSelectedRoomsIds) {
                              scheduleScenesPairedDevicesDialog(
                                  buildContext,
                                  height,
                                  width,
                                  selectedPlaceId,
                                  listSelectedRoomsIds[0]);
                            });
                        break;
                      case 1:
                        selectEditScheduleDialog(context, height, width);
                        break;
                      case 2:
                      // scheduleSelectPlaceRoomDialog(
                      //     context, height, width, "DELETE SCHEDULE",
                      //     (buildContext, selectedPlaceId,
                      //         listSelectedRoomsIds) {
                      //   selectDeleteScheduleDialog(
                      //       buildContext, height, width);
                      // });
                        selectDeleteScheduleDialog(context, height, width);
                        break;
                    }
                  })
              ],
            )),
      );
    });

  });
}

void scheduleSelectPlaceRoomDialog(BuildContext context, double height,
    double width, String title, Function onTap) {
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
                        fontSize: getAdaptiveTextSize(
                            context, placeRoomTextSize)),
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
                        fontSize: getAdaptiveTextSize(
                            context, placeRoomTextSize)),
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
                  child: ChangeNotifierProvider<
                      PlacesWithOwnerPermissionsVM>.value(
                    value: placesWithOwnerPermissionsVM,
                    child: Consumer<PlacesWithOwnerPermissionsVM>(
                      builder: (context, viewModel, view) {
                        switch (viewModel
                            .placesWithOwnerPermissionsData.status) {
                          case ApiStatus.COMPLETED:
                            List<AppUserAccessOwnerPermissions>?
                            listPlaces = viewModel
                                .placesWithOwnerPermissionsData
                                .data!
                                .value!
                                .appUserAccessPermissions;

                            if (listPlaces != null &&
                                listPlaces.isNotEmpty) {
                              return DialogCenterButton(
                                  "NEXT",
                                  optionsNextButtonWidth,
                                  optionsNextButtonHeight,
                                  optionsNextButtonTextSize, (selected) {
                                if (listSelectedRooms.isNotEmpty) {
                                  Navigator.pop(buildContext);
                                  List<String> listSelectedRoomsIds = [];
                                  for (var room in listSelectedRooms) {
                                    listSelectedRoomsIds.add(room.roomId);
                                  }
                                  onTap(buildContext, selectedPlace.homeId,
                                      listSelectedRoomsIds);
                                } else {
                                  showToastFun(
                                      buildContext, "Please select room");
                                }
                              });
                            }
                            return Container();
                          default:
                        }
                        return Container();
                      },
                    ),
                  )),
              DialogNote(
                  50, 316.63, "NOTE: SELECT 1 PLACE & ROOM AT A TIME"),
            ],
          )),
    );
  });
}

void scheduleScenesPairedDevicesDialog(BuildContext context,
    double height,
    double width,
    String selectedPlaceId,
    String selectedRoomId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    int selectedTabPosition = 0;
    String selectedSceneId = "";

    RequestScenes requestScenes = RequestScenes(applicationId: applicationId, roomId: selectedRoomId);

    ScenesVM scenesVM = ScenesVM();
    scenesVM.getScenes(requestScenes);

    // List<String> listPairedDevices = [
    //   "SW 01",
    //   "SW 02",
    //   "SW 03",
    //   "SW 04",
    //   "SW 05",
    //   "SW 06",
    //   "SW 07",
    //   "SW 08",
    // ];
    //
    // List<Map<String, dynamic>> listPairedDevicesMapOptions = [];
    // for (var pairedDeviceName in listPairedDevices) {
    //   Map<String, dynamic> mapPairedDevice = {};
    //   mapPairedDevice['name'] = pairedDeviceName;
    //   mapPairedDevice['selected'] = false;
    //   listPairedDevicesMapOptions.add(mapPairedDevice);
    // }

    bool pairedDeviceSelected = false;
    RequestPairedDevices requestPairedDevices = RequestPairedDevices(applicationId: applicationId, roomId: selectedRoomId);

    PairedDevicesVM pairedDevicesVM = PairedDevicesVM();
    Future.delayed(const Duration(seconds: 0), () async {
      pairedDevicesVM.getPairedDevices(requestPairedDevices);
    });

    HashMap<String, int> mapFansSelectedPos = HashMap();

    List<int> listSelectedPairedDeviceIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57,
                    21.23,
                    "SET SCHEDULE",
                    12.0,
                    "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                Positioned(
                  left: getX(width, placeListButtonLeftMargin),
                  top: getY(height, optionsListTopMargin),
                  child: DialogListButton(
                    "SCENE",
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsButtonTextSize,
                        () {
                      setState(() {
                        selectedTabPosition = 0;
                      });
                    },
                    tapped: true,
                    selected: selectedTabPosition == 0,
                  ),
                ),
                Positioned(
                  left: getX(width, roomListButtonLeftMargin),
                  top: getY(height, optionsListTopMargin),
                  child: DialogListButton(
                    "PAIRED DEVICES",
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsButtonTextSize,
                        () {
                      setState(() {
                        selectedTabPosition = 1;
                      });
                    },
                    tapped: true,
                    selected: selectedTabPosition == 1,
                  ),
                ),
                selectedTabPosition == 0
                    ? Positioned.fill(
                  top: getY(height, dialogHeaderListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                        getHeight(height, dialogHeaderListHeight),
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
                                      "ScenesList :: ERROR${viewModel
                                          .scenesData.message}");
                                  return Center(
                                      child: Text(
                                        "No Scenes found!",
                                        style:
                                        apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "ScenesList :: COMPLETED");

                                  List<SceneList>? listScenes =
                                      viewModel.scenesData.data!
                                          .value!.sceneList;

                                  if (listScenes == null ||
                                      listScenes.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Scenes found!",
                                          style: apiMessageTextStyle(
                                              context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "ScenesList${listScenes.length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listScenes.length,
                                        itemBuilder:
                                            (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listScenes[position]
                                                      .name!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      (selected) {
                                                    setState(() {
                                                      for (int i = 0;
                                                      i <
                                                          listScenes
                                                              .length;
                                                      i++) {
                                                        listScenes[i]
                                                            .isSelected =
                                                        false;
                                                      }

                                                      if (selected) {
                                                        selectedSceneId =
                                                        listScenes[
                                                        position]
                                                            .id!;
                                                        listScenes[position]
                                                            .isSelected =
                                                        true;
                                                      } else {
                                                        selectedSceneId =
                                                        "";
                                                      }
                                                    });
                                                  },
                                                  tapped: true,
                                                  selected: listScenes[
                                                  position]
                                                      .isSelected),
                                              SizedBox(
                                                height: getHeight(height,
                                                    dialogListItemsVerticalMarginSmall),
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
                )
                    : Positioned.fill(
                  top: getY(height, dialogHeaderListTopMargin),
                  left: getX(width, placeListButtonLeftMargin),
                  right: getX(width, placeListButtonLeftMargin - 2.5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogHeaderListHeight),
                        child: ChangeNotifierProvider<
                            PairedDevicesVM>.value(
                          value: pairedDevicesVM,
                          child: Consumer<PairedDevicesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.pairedDevicesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "PairedDevicesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "PairedDevicesList :: ERROR${viewModel
                                          .pairedDevicesData.message}");
                                  return Center(
                                      child: Text(
                                        "No Paired Devices found!",
                                        style:
                                        apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "PairedDevicesList :: COMPLETED");

                                  List<RoomDetails>? listPairedDevices =
                                      viewModel.pairedDevicesData.data!
                                          .value!.roomDetails;

                                  if (listPairedDevices == null ||
                                      listPairedDevices.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Paired Devices found!",
                                          style: apiMessageTextStyle(
                                              context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "PairedDevicesList${listPairedDevices
                                            .length}");

                                    if (!pairedDeviceSelected) {
                                      for (int i = 0; i <
                                          listPairedDevices.length; i++) {
                                        RoomDetails getRoomDetails = listPairedDevices[i];
                                        if (getRoomDetails.switchName!
                                            .contains("F")) {
                                          mapFansSelectedPos[getRoomDetails
                                              .switchName!] =
                                              fanDefaultSelectedItem;
                                        }
                                      }
                                      pairedDeviceSelected = true;
                                    }

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Wrap(
                                        spacing: getWidth(width,
                                            dialogSwitchHorizontalMargin),
                                        children: listPairedDevices.map((
                                            e) =>
                                        e.switchName!.contains("L")
                                            ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Utils.vibrateSound();
                                                setState(() {
                                                  if (e.isSelected!) {
                                                    e.isSelected = false;
                                                    listSelectedPairedDeviceIds
                                                        .remove(e.id);
                                                  } else {
                                                    e.isSelected = true;
                                                    listSelectedPairedDeviceIds
                                                        .add(e.id!);
                                                  }
                                                });
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(e.isSelected!
                                                      ? switchSelectedImage
                                                      : switchUnSelectedImage,
                                                      height: getHeight(
                                                          height,
                                                          dialogSwitchHeight),
                                                      width: getWidth(width,
                                                          dialogSwitchWidth),
                                                      fit: BoxFit.fill),
                                                  Text(
                                                    e.switchDisplayName!,
                                                    style: TextStyle(
                                                        decoration: TextDecoration
                                                            .none,
                                                        color: textColor,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        //fontFamily: "Inter",
                                                        fontStyle: FontStyle
                                                            .normal,
                                                        fontSize: getAdaptiveTextSize(
                                                            context,
                                                            homePageButtonTextSize)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getHeight(height,
                                                  dialogListItemsVerticalMarginSmall),
                                            )
                                          ],
                                        )
                                            : Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Utils.vibrateSound();
                                                setState(() {
                                                  if (e.isSelected!) {
                                                    e.isSelected = false;
                                                    listSelectedPairedDeviceIds
                                                        .remove(e.id);
                                                  } else {
                                                    e.isSelected = true;
                                                    listSelectedPairedDeviceIds
                                                        .add(e.id!);
                                                  }
                                                });
                                              },
                                              child: Stack(
                                                alignment: Alignment
                                                    .topCenter,
                                                children: [
                                                  Image.asset(
                                                      e.isSelected!
                                                          ? fanSelectedImage
                                                          : fanUnSelectedImage,
                                                      height: getHeight(
                                                          height,
                                                          kRemotButtonHeight),
                                                      width: getWidth(width,
                                                          optionsNextButtonWidth *
                                                              2 +
                                                              dialogSwitchHorizontalMargin),
                                                      fit: BoxFit.fill),
                                                  Positioned(
                                                    top: getY(height, 2),
                                                    child: Text(
                                                      e.switchDisplayName!,
                                                      style: TextStyle(
                                                          decoration: TextDecoration
                                                              .none,
                                                          color: textColor,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          //fontFamily: "Inter",
                                                          fontStyle: FontStyle
                                                              .normal,
                                                          fontSize: getAdaptiveTextSize(
                                                              context,
                                                              homePageButtonTextSize)),
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: getY(height, 19),
                                                    child: Container(
                                                      decoration:
                                                      const BoxDecoration(
                                                        color:
                                                        homePageDividerColor,
                                                      ),
                                                      width: getWidth(width,
                                                          fanContainerWidth),
                                                      height: getHeight(
                                                          height,
                                                          fanContainerHeight),
                                                      alignment: Alignment
                                                          .center,
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                      left: getX(width, 5),
                                                      right: getX(width, 5),
                                                      top: getY(height, 10),
                                                      child: RotatedBox(
                                                          quarterTurns: -1,
                                                          child:
                                                          ListWheelScrollView
                                                              .useDelegate(
                                                            physics:
                                                            const FixedExtentScrollPhysics(),
                                                            offAxisFraction:
                                                            fanOffFraction,
                                                            magnification: 2.0,
                                                            onSelectedItemChanged:
                                                                (x) {
                                                              setState(() {
                                                                mapFansSelectedPos[e
                                                                    .switchName!] =
                                                                    x;
                                                              });
                                                            },
                                                            controller:
                                                            FixedExtentScrollController(
                                                                initialItem: fanDefaultSelectedItem),
                                                            itemExtent: getWidth(
                                                                width,
                                                                fanButtonUnSelectedWidth),
                                                            childDelegate:
                                                            ListWheelChildLoopingListDelegate(
                                                              children: List
                                                                  .generate(
                                                                  fanItemCount,
                                                                      (x) =>
                                                                      RotatedBox(
                                                                          quarterTurns: 1,
                                                                          child: AnimatedContainer(
                                                                              decoration: const BoxDecoration(),
                                                                              duration: const Duration(
                                                                                  milliseconds: 400),
                                                                              width: x ==
                                                                                  mapFansSelectedPos[e
                                                                                      .switchName!]
                                                                                  ? getWidth(
                                                                                  width,
                                                                                  fanButtonSelectedWidth)
                                                                                  : getWidth(
                                                                                  width,
                                                                                  fanButtonUnSelectedWidth),
                                                                              height: x ==
                                                                                  mapFansSelectedPos[e
                                                                                      .switchName!]
                                                                                  ? getHeight(
                                                                                  height,
                                                                                  fanButtonSelectedHeight)
                                                                                  : getHeight(
                                                                                  height,
                                                                                  fanButtonUnSelectedHeight),
                                                                              alignment: Alignment
                                                                                  .center,
                                                                              child: Text(
                                                                                (x +
                                                                                    1)
                                                                                    .toString(),
                                                                                style: TextStyle(
                                                                                    decoration: TextDecoration
                                                                                        .none,
                                                                                    fontWeight: FontWeight
                                                                                        .bold,
                                                                                    color: Colors
                                                                                        .white,
                                                                                    fontSize: x ==
                                                                                        mapFansSelectedPos[e
                                                                                            .switchName!]
                                                                                        ? getAdaptiveTextSize(
                                                                                        context,
                                                                                        fanButtonSelectedTextSize)
                                                                                        : getAdaptiveTextSize(
                                                                                        context,
                                                                                        fanButtonUnSelectedTextSize)),
                                                                              )))),
                                                            ),
                                                          ))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getHeight(height,
                                                  dialogListItemsVerticalMarginSmall),
                                            )
                                          ],
                                        )).toList(),
                                      ),
                                    );
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
                if ((selectedTabPosition == 0 &&
                    selectedSceneId.isNotEmpty) ||
                    (selectedTabPosition == 1 &&
                        listSelectedPairedDeviceIds.isNotEmpty))
                  Positioned(
                    left: getX(width, optionsNextButtonLeftMargin),
                    top: getY(height, optionsNextButtonTopMargin),
                    child: DialogCenterButton(
                        "DONE",
                        optionsNextButtonWidth,
                        optionsNextButtonHeight,
                        optionsNextButtonTextSize, (selected) {
                      Navigator.pop(context);
                      scheduleDateTimeDialog(
                          context,
                          height,
                          width,
                          null,
                          selectedTabPosition,
                          selectedPlaceId,
                          selectedRoomId,
                          selectedSceneId,
                          listSelectedPairedDeviceIds);
                    }),
                  ),
              ],
            )),
      );
    });
  });
}

void editScheduleScenesDialog(BuildContext context,
    double height,
    double width,
    ScheduleGetViewModel? selectedSchedule,
    String selectedPlaceId,
    String selectedRoomId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    String selectedSceneId = "";

    bool sceneSelected = false;
    RequestScenes requestScenes = RequestScenes(
        applicationId: applicationId, roomId: selectedRoomId);

    ScenesVM scenesVM = ScenesVM();
    scenesVM.getScenes(requestScenes);

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57,
                    21.23,
                    "EDIT SCHEDULE",
                    12.0,
                    "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, dialogListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                        getHeight(height, dialogListHeight),
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
                                      "ScenesList :: ERROR${viewModel
                                          .scenesData.message}");
                                  return Center(
                                      child: Text(
                                        "No Scenes found!",
                                        style:
                                        apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "ScenesList :: COMPLETED");

                                  List<SceneList>? listScenes =
                                      viewModel.scenesData.data!
                                          .value!.sceneList;

                                  if (listScenes == null ||
                                      listScenes.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Scenes found!",
                                          style: apiMessageTextStyle(
                                              context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "ScenesList${listScenes.length}");

                                    if (selectedSchedule != null &&
                                        !sceneSelected) {
                                      for (int i = 0; i <
                                          listScenes.length; i++) {
                                        if (listScenes[i].id ==
                                            selectedSchedule.sceneId) {
                                          Future.delayed(
                                              Duration.zero, () async {
                                            setState(() {
                                              listScenes[i].isSelected =
                                              true;
                                              selectedSceneId =
                                              selectedSchedule.sceneId!;
                                            });
                                            sceneSelected = true;
                                          });
                                          break;
                                        }
                                      }
                                    }

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listScenes.length,
                                        itemBuilder:
                                            (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listScenes[position]
                                                      .name!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      (selected) {
                                                    setState(() {
                                                      for (int i = 0;
                                                      i <
                                                          listScenes
                                                              .length;
                                                      i++) {
                                                        listScenes[i]
                                                            .isSelected =
                                                        false;
                                                      }

                                                      if (selected) {
                                                        selectedSceneId =
                                                        listScenes[
                                                        position]
                                                            .id!;
                                                        listScenes[position]
                                                            .isSelected =
                                                        true;
                                                      } else {
                                                        selectedSceneId =
                                                        "";
                                                      }
                                                    });
                                                  },
                                                  tapped: true,
                                                  selected: listScenes[
                                                  position]
                                                      .isSelected),
                                              SizedBox(
                                                height: getHeight(height,
                                                    dialogListItemsVerticalMarginSmall),
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
                if (selectedSceneId.isNotEmpty)
                  Positioned(
                    left: getX(width, optionsNextButtonLeftMargin),
                    top: getY(height, optionsNextButtonTopMargin),
                    child: DialogCenterButton(
                        "DONE",
                        optionsNextButtonWidth,
                        optionsNextButtonHeight,
                        optionsNextButtonTextSize, (selected) {
                      Navigator.pop(context);
                      scheduleDateTimeDialog(
                          context,
                          height,
                          width,
                          selectedSchedule,
                          0,
                          selectedPlaceId,
                          selectedRoomId,
                          selectedSceneId,
                          []);
                    }),
                  ),
              ],
            )),
      );
    });
  });
}

void editSchedulePairedDevicesDialog(BuildContext context,
    double height,
    double width,
    ScheduleGetViewModel? selectedSchedule,
    String selectedPlaceId,
    String selectedRoomId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    bool pairedDeviceSelected = false;
    RequestPairedDevices requestPairedDevices = RequestPairedDevices(
        applicationId: applicationId, roomId: selectedRoomId);

    PairedDevicesVM pairedDevicesVM = PairedDevicesVM();
    Future.delayed(const Duration(seconds: 0), () async {
      pairedDevicesVM.getPairedDevices(requestPairedDevices);
    });

    HashMap<String, int> mapFansSelectedPos = HashMap();

    List<int> listSelectedRoomCmacIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57,
                    21.23,
                    "EDIT SCHEDULE",
                    12.0,
                    "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, dialogListTopMargin),
                  left: getX(width, placeListButtonLeftMargin),
                  right: getX(width, placeListButtonLeftMargin - 2.5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogListHeight),
                        child: ChangeNotifierProvider<
                            PairedDevicesVM>.value(
                          value: pairedDevicesVM,
                          child: Consumer<PairedDevicesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.pairedDevicesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "PairedDevicesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "PairedDevicesList :: ERROR${viewModel
                                          .pairedDevicesData.message}");
                                  return Center(
                                      child: Text(
                                        "No Paired Devices found!",
                                        style:
                                        apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "PairedDevicesList :: COMPLETED");

                                  List<RoomDetails>? listPairedDevices =
                                      viewModel.pairedDevicesData.data!
                                          .value!.roomDetails;

                                  if (listPairedDevices == null ||
                                      listPairedDevices.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Paired Devices found!",
                                          style: apiMessageTextStyle(
                                              context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "PairedDevicesList${listPairedDevices
                                            .length}");

                                    // if (selectedSchedule != null && !sceneSelected) {
                                    //   for (int i = 0; i < listScenes.length; i++) {
                                    //     if (listScenes[i].id == selectedSchedule.sceneId) {
                                    //       Future.delayed(Duration.zero, () async {
                                    //         setState(() {
                                    //           listScenes[i].isSelected = true;
                                    //           selectedSceneId = selectedSchedule.sceneId!;
                                    //         });
                                    //         sceneSelected = true;
                                    //       });
                                    //       break;
                                    //     }
                                    //   }
                                    // }

                                    if (!pairedDeviceSelected) {
                                      for (int i = 0; i < listPairedDevices.length; i++) {
                                        RoomDetails getRoomDetails = listPairedDevices[i];
                                        if (getRoomDetails.switchName!.contains("F")) {
                                          mapFansSelectedPos[getRoomDetails.switchName!] = fanDefaultSelectedItem;
                                        }

                                        for(int j=0;j<selectedSchedule!.scheduleDetails!.length;j++){
                                          int roomCmacId = selectedSchedule.scheduleDetails![j].roomCmacDetailId!;
                                          if(roomCmacId == getRoomDetails.id){
                                            Future.delayed(Duration.zero, () async {
                                              setState(() {
                                                listPairedDevices[i].isSelected = true;
                                                //selectedSceneId = selectedSchedule.sceneId!;
                                              });
                                            });
                                          }
                                        }

                                      }
                                      pairedDeviceSelected = true;
                                    }

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Wrap(
                                        spacing: getWidth(width,
                                            dialogSwitchHorizontalMargin),
                                        children: listPairedDevices.map((
                                            e) =>
                                        e.switchName!.contains("L")
                                            ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Utils.vibrateSound();
                                                setState(() {
                                                  if (e.isSelected!) {
                                                    e.isSelected = false;
                                                    listSelectedRoomCmacIds
                                                        .remove(e.id);
                                                  } else {
                                                    e.isSelected = true;
                                                    listSelectedRoomCmacIds
                                                        .add(e.id!);
                                                  }
                                                });
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(e.isSelected!
                                                      ? switchSelectedImage
                                                      : switchUnSelectedImage,
                                                      height: getHeight(
                                                          height,
                                                          dialogSwitchHeight),
                                                      width: getWidth(width,
                                                          dialogSwitchWidth),
                                                      fit: BoxFit.fill),
                                                  Text(
                                                    e.switchDisplayName!,
                                                    style: TextStyle(
                                                        decoration: TextDecoration
                                                            .none,
                                                        color: textColor,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        //fontFamily: "Inter",
                                                        fontStyle: FontStyle
                                                            .normal,
                                                        fontSize: getAdaptiveTextSize(
                                                            context,
                                                            homePageButtonTextSize)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getHeight(height,
                                                  dialogListItemsVerticalMarginSmall),
                                            )
                                          ],
                                        )
                                            : Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Utils.vibrateSound();
                                                setState(() {
                                                  if (e.isSelected!) {
                                                    e.isSelected = false;
                                                    listSelectedRoomCmacIds
                                                        .remove(e.id);
                                                  } else {
                                                    e.isSelected = true;
                                                    listSelectedRoomCmacIds
                                                        .add(e.id!);
                                                  }
                                                });
                                              },
                                              child: Stack(
                                                alignment: Alignment
                                                    .topCenter,
                                                children: [
                                                  Image.asset(
                                                      e.isSelected!
                                                          ? fanSelectedImage
                                                          : fanUnSelectedImage,
                                                      height: getHeight(
                                                          height,
                                                          kRemotButtonHeight),
                                                      width: getWidth(width,
                                                          optionsNextButtonWidth *
                                                              2 +
                                                              dialogSwitchHorizontalMargin),
                                                      fit: BoxFit.fill),
                                                  Positioned(
                                                    top: getY(height, 2),
                                                    child: Text(
                                                      e.switchDisplayName!,
                                                      style: TextStyle(
                                                          decoration: TextDecoration
                                                              .none,
                                                          color: textColor,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          //fontFamily: "Inter",
                                                          fontStyle: FontStyle
                                                              .normal,
                                                          fontSize: getAdaptiveTextSize(
                                                              context,
                                                              homePageButtonTextSize)),
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: getY(height, 19),
                                                    child: Container(
                                                      decoration:
                                                      const BoxDecoration(
                                                        color:
                                                        homePageDividerColor,
                                                      ),
                                                      width: getWidth(width,
                                                          fanContainerWidth),
                                                      height: getHeight(
                                                          height,
                                                          fanContainerHeight),
                                                      alignment: Alignment
                                                          .center,
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                      left: getX(width, 5),
                                                      right: getX(width, 5),
                                                      top: getY(height, 10),
                                                      child: RotatedBox(
                                                          quarterTurns: -1,
                                                          child:
                                                          ListWheelScrollView
                                                              .useDelegate(
                                                            physics:
                                                            const FixedExtentScrollPhysics(),
                                                            offAxisFraction:
                                                            fanOffFraction,
                                                            magnification: 2.0,
                                                            onSelectedItemChanged:
                                                                (x) {
                                                              setState(() {
                                                                mapFansSelectedPos[e
                                                                    .switchName!] =
                                                                    x;
                                                              });
                                                            },
                                                            controller:
                                                            FixedExtentScrollController(
                                                                initialItem: fanDefaultSelectedItem),
                                                            itemExtent: getWidth(
                                                                width,
                                                                fanButtonUnSelectedWidth),
                                                            childDelegate:
                                                            ListWheelChildLoopingListDelegate(
                                                              children: List
                                                                  .generate(
                                                                  fanItemCount,
                                                                      (x) =>
                                                                      RotatedBox(
                                                                          quarterTurns: 1,
                                                                          child: AnimatedContainer(
                                                                              decoration: const BoxDecoration(),
                                                                              duration: const Duration(
                                                                                  milliseconds: 400),
                                                                              width: x ==
                                                                                  mapFansSelectedPos[e
                                                                                      .switchName!]
                                                                                  ? getWidth(
                                                                                  width,
                                                                                  fanButtonSelectedWidth)
                                                                                  : getWidth(
                                                                                  width,
                                                                                  fanButtonUnSelectedWidth),
                                                                              height: x ==
                                                                                  mapFansSelectedPos[e
                                                                                      .switchName!]
                                                                                  ? getHeight(
                                                                                  height,
                                                                                  fanButtonSelectedHeight)
                                                                                  : getHeight(
                                                                                  height,
                                                                                  fanButtonUnSelectedHeight),
                                                                              alignment: Alignment
                                                                                  .center,
                                                                              child: Text(
                                                                                (x +
                                                                                    1)
                                                                                    .toString(),
                                                                                style: TextStyle(
                                                                                    decoration: TextDecoration
                                                                                        .none,
                                                                                    fontWeight: FontWeight
                                                                                        .bold,
                                                                                    color: Colors
                                                                                        .white,
                                                                                    fontSize: x ==
                                                                                        mapFansSelectedPos[e
                                                                                            .switchName!]
                                                                                        ? getAdaptiveTextSize(
                                                                                        context,
                                                                                        fanButtonSelectedTextSize)
                                                                                        : getAdaptiveTextSize(
                                                                                        context,
                                                                                        fanButtonUnSelectedTextSize)),
                                                                              )))),
                                                            ),
                                                          ))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getHeight(height,
                                                  dialogListItemsVerticalMarginSmall),
                                            )
                                          ],
                                        )).toList(),
                                      ),
                                    );
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
                if (listSelectedRoomCmacIds.isNotEmpty)
                  Positioned(
                    left: getX(width, optionsNextButtonLeftMargin),
                    top: getY(height, optionsNextButtonTopMargin),
                    child: DialogCenterButton(
                        "DONE",
                        optionsNextButtonWidth,
                        optionsNextButtonHeight,
                        optionsNextButtonTextSize, (selected) {
                      Navigator.pop(context);
                      scheduleDateTimeDialog(
                          context,
                          height,
                          width,
                          selectedSchedule,
                          1,
                          selectedPlaceId,
                          selectedRoomId,
                          "",
                          listSelectedRoomCmacIds);
                    }),
                  ),
              ],
            )),
      );
    });
  });
}

void scheduleDateTimeDialog(BuildContext context,
    double height,
    double width,
    ScheduleGetViewModel? selectedSchedule,
    int selectedTabPos,
    String selectedPlaceId,
    String selectedRoomId,
    String selectedSceneId,
    List<int> listSelectedRoomCmacIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    String selectedDate = "";
    String selectedTime = "";
    String selectedRepeat = "";

    int selectedDay = 0;
    int selectedMonth = 0;
    int selectedYear = 0;
    int selectedHour = 0;
    int selectedMinute = 0;

    if (selectedSchedule != null) {
      var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
      var inputDate = inputFormat.parse(selectedSchedule.scheduleStartDate!);
      var inputTime = inputFormat.parse(selectedSchedule.scheduleTime!);

      selectedDay = inputDate.day;
      selectedMonth = inputDate.month;
      selectedYear = inputDate.year;
      selectedHour = inputTime.hour;
      selectedMinute = inputTime.minute;

      var outputDateFormat = DateFormat('dd/MM/yyyy');
      selectedDate = outputDateFormat.format(inputDate);

      var outputTimeFormat = DateFormat('hh:mm a');
      selectedTime = outputTimeFormat.format(inputTime);

      String strCustomRepeat = "";
      if (selectedSchedule.scheduleRepeat == 3) {
        if (selectedSchedule.onEveryMonday!) {
          strCustomRepeat = "${strCustomRepeat}MON,";
        }
        if (selectedSchedule.onEveryTuesday!) {
          strCustomRepeat = "${strCustomRepeat}TUE,";
        }
        if (selectedSchedule.onEveryWednesday!) {
          strCustomRepeat = "${strCustomRepeat}WED,";
        }
        if (selectedSchedule.onEveryThursday!) {
          strCustomRepeat = "${strCustomRepeat}THU,";
        }
        if (selectedSchedule.onEveryFriday!) {
          strCustomRepeat = "${strCustomRepeat}FRI,";
        }
        if (selectedSchedule.onEverySaturday!) {
          strCustomRepeat = "${strCustomRepeat}SAT,";
        }
        if (selectedSchedule.onEverySunday!) {
          strCustomRepeat = "${strCustomRepeat}SUN";
        }
      }

      selectedRepeat = selectedSchedule.scheduleRepeat == 1
          ? "ONCE"
          : selectedSchedule.scheduleRepeat == 2
          ? "DAILY"
          : selectedSchedule.scheduleRepeat == 3
          ? strCustomRepeat
          : "";
    }

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57,
                    21.23,
                    selectedSchedule == null
                        ? "SET SCHEDULE"
                        : "EDIT SCHEDULE",
                    12.0,
                    "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                DialogButton(
                    "DATE",
                    placeListButtonLeftMargin,
                    optionsListTopMargin1,
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsNextButtonTextSize,
                        () {}),
                DialogButton(
                    selectedDate,
                    roomListButtonLeftMargin,
                    optionsListTopMargin1,
                    optionsButtonWidth,
                    optionsButtonHeight,
                    optionsButtonTextSize, () {
                  scheduleDateDialog(
                      context,
                      height,
                      width,
                      selectedDay,
                      selectedMonth,
                      selectedYear,
                          (getSelectedDate, getSelectedDay,
                          getSelectedMonth,
                          getSelectedYear) {
                        setState(() {
                          selectedDate = getSelectedDate;
                        });
                        selectedDay = getSelectedDay;
                        selectedMonth = getSelectedMonth;
                        selectedYear = getSelectedYear;
                      });
                }),
                DialogButton(
                    "TIME",
                    placeListButtonLeftMargin,
                    optionsListTopMargin1 +
                        dialogListItemsVerticalMargin +
                        optionsNextButtonHeight,
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsNextButtonTextSize,
                        () {}),
                DialogButton(
                    selectedTime,
                    roomListButtonLeftMargin,
                    optionsListTopMargin1 +
                        dialogListItemsVerticalMargin +
                        optionsNextButtonHeight,
                    optionsButtonWidth,
                    optionsButtonHeight,
                    optionsButtonTextSize, () {
                  scheduleTimeDialog(
                      context, height, width, selectedHour, selectedMinute,
                          (getSelectedTime, getSelectedHour,
                          getSelectedMinute) {
                        setState(() {
                          selectedTime = getSelectedTime;
                        });
                        selectedHour = getSelectedHour;
                        selectedMinute = getSelectedMinute;
                      });
                }),
                DialogButton(
                    "REPEAT",
                    placeListButtonLeftMargin,
                    optionsListTopMargin1 +
                        (2 * dialogListItemsVerticalMargin) +
                        (2 * optionsNextButtonHeight),
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsNextButtonTextSize,
                        () {}),
                DialogButton(
                    selectedRepeat,
                    roomListButtonLeftMargin,
                    optionsListTopMargin1 +
                        (2 * dialogListItemsVerticalMargin) +
                        (2 * optionsNextButtonHeight),
                    optionsButtonWidth,
                    optionsButtonHeight,
                    optionsButtonTextSize, () {
                  scheduleRepeatDialog(
                      context, height, width, selectedSchedule,
                          (getSelectedRepeat) {
                        setState(() {
                          selectedRepeat = getSelectedRepeat;
                        });
                      });
                }),
                DialogButton(
                    "DONE",
                    optionsNextButtonLeftMargin,
                    optionsNextButtonTopMargin,
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsNextButtonTextSize, () {
                  if (selectedDate.isEmpty) {
                    showToastFun(context, "Please select date");
                  } else if (selectedTime.isEmpty) {
                    showToastFun(context, "Please select time");
                  } else if (selectedRepeat.isEmpty) {
                    showToastFun(context, "Please select repeat");
                  } else {
                    String selectedDateTime = DateTime(
                        selectedYear,
                        selectedMonth,
                        selectedDay,
                        selectedHour,
                        selectedMinute)
                        .toString();
                    if (selectedTabPos == 0) {
                      if (selectedSchedule == null) {
                        addSceneSchedule(
                            context,
                            selectedPlaceId,
                            selectedRoomId,
                            selectedSceneId,
                            selectedDateTime,
                            selectedRepeat, () {
                          Navigator.pop(context);
                        });
                      } else {
                        editSceneSchedule(
                            context,
                            selectedSchedule.id!,
                            selectedPlaceId,
                            selectedRoomId,
                            selectedSceneId,
                            selectedDateTime,
                            selectedRepeat,
                            selectedSchedule.scheduleName!,
                            selectedSchedule.scheduleStartDate!, () {
                          Navigator.pop(context);
                        });
                      }
                    } else {
                      if (selectedSchedule == null) {
                        addSwitchSchedule(
                            context,
                            selectedPlaceId,
                            selectedRoomId,
                            selectedDateTime,
                            selectedRepeat,
                            listSelectedRoomCmacIds, () {
                          Navigator.pop(context);
                        });
                      } else {
                        editSwitchSchedule(
                            context,
                            selectedSchedule.id!,
                            selectedPlaceId,
                            selectedRoomId,
                            selectedDateTime,
                            selectedRepeat,
                            selectedSchedule.scheduleName!,
                            selectedSchedule.scheduleStartDate!,
                            listSelectedRoomCmacIds, () {
                          Navigator.pop(context);
                        });
                      }
                    }
                  }
                }),
              ],
            )),
      );
    });
  });
}

Future<void> addSceneSchedule(BuildContext context,
    String selectedPlaceId,
    String selectedRoomId,
    String selectedSceneId,
    String selectedUTCDateTime,
    String selectedRepeat,
    Function onSuccess) async {
  AddSceneScheduleVM addSceneScheduleVM = AddSceneScheduleVM();

  RequestAddSceneSchedule requestAddSceneSchedule = RequestAddSceneSchedule(
    applicationId: applicationId,
    homeId: selectedPlaceId,
    roomId: selectedRoomId,
    scheduleStartDate: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
    scheduleTime: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
    scheduleRepeat: selectedRepeat == "ONCE"
        ? 1
        : selectedRepeat == "DAILY"
        ? 2
        : 3,
    onEverySunday: selectedRepeat.contains("SUN") ? true : false,
    onEveryMonday: selectedRepeat.contains("MON") ? true : false,
    onEveryTuesday: selectedRepeat.contains("TUE") ? true : false,
    onEveryWednesday: selectedRepeat.contains("WED") ? true : false,
    onEveryThursday: selectedRepeat.contains("THU") ? true : false,
    onEveryFriday: selectedRepeat.contains("FRI") ? true : false,
    onEverySaturday: selectedRepeat.contains("SAT") ? true : false,
    scheduleName: "SCHEDULE 26",
    sceneId: selectedSceneId,
    individualAction: false,
    createdBy: appUserId,
    createdDateTime:
    DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseAddSceneSchedule> addSceneScheduleData =
  await addSceneScheduleVM.addSceneSchedule(requestAddSceneSchedule);
  if (addSceneScheduleData.status == ApiStatus.COMPLETED) {
    ResponseAddSceneSchedule responseAddSceneSchedule =
    addSceneScheduleData.data!;
    if (responseAddSceneSchedule.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseAddSceneSchedule.value!.meta!.message);
  }
}

Future<void> editSceneSchedule(BuildContext context,
    int selectedScheduleId,
    String selectedPlaceId,
    String selectedRoomId,
    String selectedSceneId,
    String selectedUTCDateTime,
    String selectedRepeat,
    String scheduleName,
    String scheduleStartDate,
    Function onSuccess) async {
  EditSceneScheduleVM editSceneScheduleVM = EditSceneScheduleVM();

  RequestEditSceneSchedule requestEditSceneSchedule = RequestEditSceneSchedule(
    applicationId: applicationId,
    id: selectedScheduleId,
    homeId: selectedPlaceId,
    roomId: selectedRoomId,
    scheduleStartDate: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
    scheduleTime: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
    scheduleRepeat: selectedRepeat == "ONCE"
        ? 1
        : selectedRepeat == "DAILY"
        ? 2
        : 3,
    onEverySunday: selectedRepeat.contains("SUN") ? true : false,
    onEveryMonday: selectedRepeat.contains("MON") ? true : false,
    onEveryTuesday: selectedRepeat.contains("TUE") ? true : false,
    onEveryWednesday: selectedRepeat.contains("WED") ? true : false,
    onEveryThursday: selectedRepeat.contains("THU") ? true : false,
    onEveryFriday: selectedRepeat.contains("FRI") ? true : false,
    onEverySaturday: selectedRepeat.contains("SAT") ? true : false,
    scheduleName: scheduleName,
    sceneId: selectedSceneId,
    individualAction: false,
    updatedBy: appUserId,
    updatedDateTime: currentDateTime,
  );

  ApiResponse<ResponseEditSceneSchedule> editSceneScheduleData =
  await editSceneScheduleVM.editSceneSchedule(requestEditSceneSchedule);
  if (editSceneScheduleData.status == ApiStatus.COMPLETED) {
    ResponseEditSceneSchedule responseEditSceneSchedule =
    editSceneScheduleData.data!;
    if (responseEditSceneSchedule.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseEditSceneSchedule.value!.meta!.message);
  }
}

Future<void> addSwitchSchedule(BuildContext context,
    String selectedPlaceId,
    String selectedRoomId,
    String selectedUTCDateTime,
    String selectedRepeat,
    List<int> listSelectedRoomCmacIds,
    Function onSuccess) async {
  AddSwitchScheduleVM addSwitchScheduleVM = AddSwitchScheduleVM();

  List<AddSwitches> listPairedDevices = [];
  for (int i = 0; i < listSelectedRoomCmacIds.length; i++) {
    AddSwitches addSwitches = AddSwitches(roomCmacDetailId: listSelectedRoomCmacIds[i], onOffStatus: "on");
    listPairedDevices.add(addSwitches);
  }

  RequestAddSwitchSchedule requestAddSwitchSchedule = RequestAddSwitchSchedule(
      schedule: AddSwitchSchedule(
        applicationId: applicationId,
        homeId: selectedPlaceId,
        roomId: selectedRoomId,
        scheduleStartDate: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
        scheduleTime: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
        scheduleRepeat: selectedRepeat == "ONCE"
            ? 1
            : selectedRepeat == "DAILY"
            ? 2
            : 3,
        onEverySunday: selectedRepeat.contains("SUN") ? true : false,
        onEveryMonday: selectedRepeat.contains("MON") ? true : false,
        onEveryTuesday: selectedRepeat.contains("TUE") ? true : false,
        onEveryWednesday: selectedRepeat.contains("WED") ? true : false,
        onEveryThursday: selectedRepeat.contains("THU") ? true : false,
        onEveryFriday: selectedRepeat.contains("FRI") ? true : false,
        onEverySaturday: selectedRepeat.contains("SAT") ? true : false,
        scheduleName: "SCHEDULE 26",
        sceneId: "",
        individualAction: true,
        createdBy: appUserId,
        createdDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
      ),
      switches: listPairedDevices
  );

  ApiResponse<ResponseAddSwitchSchedule> addSwitchScheduleData = await addSwitchScheduleVM.addSwitchSchedule(requestAddSwitchSchedule);
  if (addSwitchScheduleData.status == ApiStatus.COMPLETED) {
    ResponseAddSwitchSchedule responseAddSwitchSchedule = addSwitchScheduleData.data!;
    if (responseAddSwitchSchedule.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseAddSwitchSchedule.value!.meta!.message);
  }
}

Future<void> editSwitchSchedule(BuildContext context,
    int selectedScheduleId,
    String selectedPlaceId,
    String selectedRoomId,
    String selectedUTCDateTime,
    String selectedRepeat,
    String scheduleName,
    String scheduleStartDate,
    List<int> listSelectedRoomCmacIds,
    Function onSuccess) async {
  EditSwitchScheduleVM editSwitchScheduleVM = EditSwitchScheduleVM();

  List<EditSwitches> listPairedDevices = [];
  for (int i = 0; i < listSelectedRoomCmacIds.length; i++) {
    EditSwitches editSwitches = EditSwitches(roomCmacDetailId: listSelectedRoomCmacIds[i], onOffStatus: "on");
    listPairedDevices.add(editSwitches);
  }

  RequestEditSwitchSchedule requestEditSwitchSchedule = RequestEditSwitchSchedule(
    schedule: EditSwitchSchedule(
      applicationId: applicationId,
      id: selectedScheduleId,
      homeId: selectedPlaceId,
      roomId: selectedRoomId,
      scheduleStartDate: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
      scheduleTime: selectedUTCDateTime.replaceFirst(RegExp(' '), 'T'),
      scheduleRepeat: selectedRepeat == "ONCE"
          ? 1
          : selectedRepeat == "DAILY"
          ? 2
          : 3,
      onEverySunday: selectedRepeat.contains("SUN") ? true : false,
      onEveryMonday: selectedRepeat.contains("MON") ? true : false,
      onEveryTuesday: selectedRepeat.contains("TUE") ? true : false,
      onEveryWednesday: selectedRepeat.contains("WED") ? true : false,
      onEveryThursday: selectedRepeat.contains("THU") ? true : false,
      onEveryFriday: selectedRepeat.contains("FRI") ? true : false,
      onEverySaturday: selectedRepeat.contains("SAT") ? true : false,
      scheduleName: scheduleName,
      sceneId: "",
      individualAction: true,
      updatedBy: appUserId,
      updatedDateTime: currentDateTime,
    ),
    switches: listPairedDevices,

  );

  ApiResponse<ResponseEditSwitchSchedule> editSwitchScheduleData =
  await editSwitchScheduleVM.editSwitchSchedule(requestEditSwitchSchedule);
  if (editSwitchScheduleData.status == ApiStatus.COMPLETED) {
    ResponseEditSwitchSchedule responseEditSwitchSchedule = editSwitchScheduleData
        .data!;
    if (responseEditSwitchSchedule.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseEditSwitchSchedule.value!.meta!.message);
  }
}


void scheduleRepeatDialog(BuildContext context, double height, double width,
    ScheduleGetViewModel? selectedSchedule, Function selectedRepeatCallback) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    var isOnceChecked = false;
    var isDailyChecked = false;
    var isCustomChecked = false;

    if (selectedSchedule != null) {
      isOnceChecked = selectedSchedule.scheduleRepeat == 1 ? true : false;
      isDailyChecked = selectedSchedule.scheduleRepeat == 2 ? true : false;
      isCustomChecked = selectedSchedule.scheduleRepeat == 3 ? true : false;
    }

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: Align(
          alignment: const Alignment(0.5, 0.5),
          child: Container(
              width: getWidth(width, dateTimeDialogWidth),
              height: getHeight(height, dateTimeDialogHeight),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(14.86390495300293)),
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
                    image: AssetImage(alertDialogBg),
                    fit: BoxFit.fill),
              ),
//color: Colors.white,

              child: Column(
                children: [
                  SizedBox(
                    height: getHeight(height, 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DialogButton(
                          "ONCE",
                          54.74,
                          29.86,
                          optionsNextButtonWidth,
                          optionsNextButtonHeight,
                          optionsNextButtonTextSize,
                              () {}),
                      DialogRadioCheckBox(31.85, 27.87, isOnceChecked, () {
                        Navigator.pop(context);
                        selectedRepeatCallback("ONCE");
                      }),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(height, 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DialogButton(
                          "DAILY",
                          54.74,
                          66.35,
                          optionsNextButtonWidth,
                          optionsNextButtonHeight,
                          optionsNextButtonTextSize,
                              () {}),
                      DialogRadioCheckBox(31.85, 27.87, isDailyChecked, () {
                        Navigator.pop(context);
                        selectedRepeatCallback("DAILY");
                      }),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(height, 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DialogButton(
                          "CUSTOM",
                          54.74,
                          102.85,
                          optionsNextButtonWidth,
                          optionsNextButtonHeight,
                          optionsNextButtonTextSize,
                              () {}),
                      DialogRadioCheckBox(31.85, 27.87, isCustomChecked,
                              () {
                            Navigator.pop(context);
                            scheduleRepeatCustomDialog(
                                context, height, width, selectedSchedule,
                                    (strSelectedDays) {
                                  selectedRepeatCallback(strSelectedDays);
                                });
                          }),
                    ],
                  ),
                ],
              )),
        ),
      );
    });
  });
}

void scheduleRepeatCustomDialog(BuildContext context, double height,
    double width, ScheduleGetViewModel? selectedSchedule,
    Function selectedDaysCallback) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listSelectedDays = [];

    List<String> listOptions = [
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY",
      "SUNDAY"
    ];

    List<Map<String, dynamic>> listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      if (selectedSchedule != null) {
        switch (optionName) {
          case "MONDAY":
            {
              mapOption['selected'] = selectedSchedule.onEveryMonday;
              if (selectedSchedule.onEveryMonday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
          case "TUESDAY":
            {
              mapOption['selected'] = selectedSchedule.onEveryTuesday;
              if (selectedSchedule.onEveryTuesday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
          case "WEDNESDAY":
            {
              mapOption['selected'] = selectedSchedule.onEveryWednesday;
              if (selectedSchedule.onEveryWednesday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
          case "THURSDAY":
            {
              mapOption['selected'] = selectedSchedule.onEveryThursday;
              if (selectedSchedule.onEveryThursday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
          case "FRIDAY":
            {
              mapOption['selected'] = selectedSchedule.onEveryFriday;
              if (selectedSchedule.onEveryFriday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
          case "SATURDAY":
            {
              mapOption['selected'] = selectedSchedule.onEverySaturday;
              if (selectedSchedule.onEverySaturday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
          case "SUNDAY":
            {
              mapOption['selected'] = selectedSchedule.onEverySunday;
              if (selectedSchedule.onEverySunday!) {
                listSelectedDays.add(optionName);
              }
              break;
            }
        }
      } else {
        mapOption['selected'] = false;
      }
      listMapOptions.add(mapOption);
    }

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: Align(
          alignment: const Alignment(0.5, 0.7),
          child: Container(
              width: getWidth(width, dateTimeDialogWidth),
              height: getHeight(height, 375),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(14.86390495300293)),
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
                    image: AssetImage(alertDialogBg),
                    fit: BoxFit.fill),
              ),
//color: Colors.white,
              child: Stack(
                children: [
                  Positioned.fill(
                    top: getY(height, 25),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: listMapOptions.length,
                            itemBuilder: (context, position) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DialogListButton(
                                          listMapOptions[position]['name'],
                                          optionsNextButtonWidth,
                                          optionsNextButtonHeight,
                                          optionsButtonTextSize,
                                              () {}),
                                      DialogCheckBox(
                                        31.85,
                                        27.87,
                                        listMapOptions[position]
                                        ['selected'],
                                            (checked) {
                                          setState(() {
                                            if (checked) {
                                              listMapOptions[position]
                                              ['selected'] = true;
                                              listSelectedDays.add(
                                                  listMapOptions[position]
                                                  ['name']);
                                            } else {
                                              listMapOptions[position]
                                              ['selected'] = false;
                                              listSelectedDays.remove(
                                                  listMapOptions[position]
                                                  ['name']);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getHeight(height, 6.3),
                                  ),
                                ],
                              );
                            }),
                        SizedBox(
                          height: getHeight(height, 9),
                        ),
                        DialogCenterButton(
                            "DONE",
                            optionsNextButtonWidth,
                            optionsNextButtonHeight,
                            optionsNextButtonTextSize, (selected) {
                          Navigator.pop(context);

                          String strSelectedDays = "";
                          for (String selectedDay in listSelectedDays) {
                            if (strSelectedDays.isEmpty) {
                              strSelectedDays = selectedDay.substring(0, 3);
                            } else {
                              strSelectedDays =
                              "$strSelectedDays,${selectedDay.substring(
                                  0, 3)}";
                            }
                          }

                          selectedDaysCallback(strSelectedDays);
                        }),
                      ],
                    ),
                  )
                ],
              )),
        ),
      );
    });
  });
}

void scheduleDateDialog(BuildContext context, double height, double width,
    int getSelectedDay, int getSelectedMonth, int getSelectedYear,
    Function selectedDateCallback) async {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<int> list31DaysMonths = [1, 3, 5, 7, 8, 10, 12];

    int currentDay = DateTime
        .now()
        .day;
    int currentMonth = DateTime
        .now()
        .month;
    int currentYear = DateTime
        .now()
        .year;

    int selectedDay = getSelectedDay == 0 ? currentDay : getSelectedDay;
    int selectedMonth = getSelectedMonth == 0
        ? currentMonth
        : getSelectedMonth;
    int selectedYear = getSelectedYear == 0 ? currentYear : getSelectedYear;

    FixedExtentScrollController dayController = FixedExtentScrollController(initialItem: 1);

    List<int> listDays = [];
    int maxDays = 0;
    if (list31DaysMonths.contains(selectedMonth)) {
      maxDays = 31;
    } else if (selectedMonth != 2) {
      maxDays = 30;
    } else {
      if (isLeapYear(selectedYear)) {
        maxDays = 29;
      } else {
        maxDays = 28;
      }
    }

    if (selectedMonth > currentMonth || selectedYear > currentYear) {
      for (int i = 1; i <= maxDays; i++) {
        listDays.add(i);
      }
      dayController = FixedExtentScrollController(initialItem: selectedDay);
    } else {
      int pos = 0;
      for (int i = currentDay; i <= maxDays; i++) {
        listDays.add(i);
        if(i == selectedDay){
          dayController = FixedExtentScrollController(initialItem: pos);
        }
        pos++;
      }
    }

    final FixedExtentScrollController monthController = FixedExtentScrollController(initialItem: selectedMonth);

    List<int> listMonths = [];
    for (int i = currentMonth; i <= 12; i++) {
      listMonths.add(i);
    }

    FixedExtentScrollController yearController = FixedExtentScrollController(initialItem: 1);

    List<int> listYears = [];
    int nextYear = currentYear;
    for (int i = 0; i < 9; i++) {
      i == 0 ? listYears.add(currentYear) : listYears.add(nextYear);

      if (selectedYear == nextYear) {
        yearController = FixedExtentScrollController(initialItem: i);
      }

      nextYear = nextYear + 1;
    }

    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setState) {
        return Center(
          child: Align(
            alignment: const Alignment(0.5, 0.1),
            child: Container(
                width: getWidth(width, dateTimeDialogWidth),
                height: getHeight(height, dateTimeDialogHeight),
                // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(14.86390495300293)),
                  border: Border.all(
                      color: homePageDividerColor,
                      width: 1.0617074966430664),
                  // boxShadow: const [
                  //   BoxShadow(
                  //       color: Color(0x40000000),
                  //       offset: Offset(5.308538436889648, 5.308538436889648),
                  //       blurRadius: 6.370244979858398,
                  //       spreadRadius: 0)
                  // ],
                  //color: const Color(0xff484949)
                  image: const DecorationImage(
                      image:
                      AssetImage(alertDialogBg),
                      fit: BoxFit.fill),
                ),
//color: Colors.white,

                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(height, 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: getWidth(width, 23.67),
                          height: getHeight(height, 90),
                          child: Stack(
                            children: [
                              Image.asset(
                                timeUnSelectedImage,
                                fit: BoxFit.cover,
                                width: getWidth(width, 23.67),
                                height: getHeight(height, 90),
                              ),
                              ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    selectedDay = listDays[x];
                                  });
                                },
                                controller: dayController,
                                itemExtent: getWidth(width, 23.67),
                                children: listDays
                                    .map((x) =>
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: getHeight(height, 5),
                                          bottom: getHeight(height, 5)),
                                      child: AnimatedContainer(
                                          decoration: x == selectedDay
                                              ? const BoxDecoration(
                                              color:
                                              homePageDividerColor)
                                              : const BoxDecoration(),
                                          duration: const Duration(
                                              milliseconds: 400),
                                          alignment: Alignment.center,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              x.toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: x ==
                                                      selectedDay
                                                      ? textColor
                                                      : highLightColor,
                                                  fontSize: x ==
                                                      selectedDay
                                                      ? getAdaptiveTextSize(
                                                      context, 10)
                                                      : getAdaptiveTextSize(
                                                      context, 8)),
                                            ),
                                          )),
                                    ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getWidth(width, 23.67),
                          height: getHeight(height, 90),
                          child: Stack(
                            children: [
                              Image.asset(
                                timeUnSelectedImage,
                                fit: BoxFit.cover,
                                width: getWidth(width, 23.67),
                                height: getHeight(height, 90),
                              ),
                              ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    selectedMonth = listMonths[x];

                                    listDays.clear();
                                    int maxDays = 0;
                                    if (list31DaysMonths
                                        .contains(selectedMonth)) {
                                      maxDays = 31;
                                    } else if (selectedMonth != 2) {
                                      maxDays = 30;
                                    } else {
                                      if (isLeapYear(selectedYear)) {
                                        maxDays = 29;
                                      } else {
                                        maxDays = 28;
                                      }
                                    }
                                    if (currentYear == selectedYear &&
                                        currentMonth == selectedMonth) {
                                      for (int i = currentDay;
                                      i <= maxDays;
                                      i++) {
                                        listDays.add(i);
                                      }
                                    } else {
                                      for (int i = 1; i <= maxDays; i++) {
                                        listDays.add(i);
                                      }
                                    }
                                  });
                                },
                                controller: monthController,
                                itemExtent: getWidth(width, 23.67),
                                children: listMonths
                                    .map((x) =>
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: getHeight(height, 5),
                                          bottom: getHeight(height, 5)),
                                      child: AnimatedContainer(
                                          decoration: x == selectedMonth
                                              ? const BoxDecoration(
                                              color:
                                              homePageDividerColor)
                                              : const BoxDecoration(),
                                          duration: const Duration(
                                              milliseconds: 400),
                                          alignment: Alignment.center,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              (x < 10 ? "0$x" : (x))
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: x ==
                                                      selectedMonth
                                                      ? textColor
                                                      : highLightColor,
                                                  fontSize: x ==
                                                      selectedMonth
                                                      ? getAdaptiveTextSize(
                                                      context, 10)
                                                      : getAdaptiveTextSize(
                                                      context, 8)),
                                            ),
                                          )),
                                    ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getWidth(width, 23.67),
                          height: getHeight(height, 90),
                          child: Stack(
                            children: [
                              Image.asset(
                                timeUnSelectedImage,
                                fit: BoxFit.cover,
                                width: getWidth(width, 23.67),
                                height: getHeight(height, 90),
                              ),
                              ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    selectedYear = listYears[x];

                                    listMonths.clear();
                                    if (currentYear == selectedYear) {
                                      for (int i = currentMonth;
                                      i <= 12;
                                      i++) {
                                        listMonths.add(i);
                                      }
                                    } else {
                                      for (int i = 1; i <= 12; i++) {
                                        listMonths.add(i);
                                      }
                                    }

                                    listDays.clear();
                                    int maxDays = 0;
                                    if (list31DaysMonths
                                        .contains(selectedMonth)) {
                                      maxDays = 31;
                                    } else if (selectedMonth != 2) {
                                      maxDays = 30;
                                    } else {
                                      if (isLeapYear(selectedYear)) {
                                        maxDays = 29;
                                      } else {
                                        maxDays = 28;
                                      }
                                    }
                                    if (currentYear == selectedYear &&
                                        currentMonth == selectedMonth) {
                                      for (int i = currentDay;
                                      i <= maxDays;
                                      i++) {
                                        listDays.add(i);
                                      }
                                    } else {
                                      for (int i = 1; i <= maxDays; i++) {
                                        listDays.add(i);
                                      }
                                    }
                                  });
                                },
                                controller: yearController,
                                itemExtent: getWidth(width, 23.67),
                                children: listYears
                                    .map((x) =>
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: getHeight(height, 5),
                                          bottom: getHeight(height, 5)),
                                      child: AnimatedContainer(
                                          decoration: x == selectedYear
                                              ? const BoxDecoration(
                                              color:
                                              homePageDividerColor)
                                              : const BoxDecoration(),
                                          duration: const Duration(
                                              milliseconds: 400),
                                          alignment: Alignment.center,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              x.toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: x == selectedYear
                                                      ? textColor
                                                      : highLightColor,
                                                  fontSize: x ==
                                                      selectedYear
                                                      ? getAdaptiveTextSize(
                                                      context, 8)
                                                      : getAdaptiveTextSize(
                                                      context, 7)),
                                            ),
                                          )),
                                    ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(height, 20),
                    ),
                    DialogCenterButton(
                        "DONE",
                        optionsNextButtonWidth,
                        optionsNextButtonHeight,
                        optionsNextButtonTextSize, (selected) {
                      String selectedDate =
                          "$selectedDay/$selectedMonth/$selectedYear";
                      selectedDateCallback(selectedDate, selectedDay,
                          selectedMonth, selectedYear);
                      Navigator.pop(context, selectedDay);
                    }),
                  ],
                )),
          ),
        );
      },
    );
  });
}

void scheduleTimeDialog(BuildContext context, double height, double width,
    int getSelectedHour, int getSelectedMinute,
    Function selectedTimeCallback) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    int selectedHour = 0;
    int selectedMinute = 0;
    List<String> listAMPM = ["AM", "PM"];
    String selectedAMPM = "AM";

    if (getSelectedHour > 12) {
      selectedHour = getSelectedHour - 12;
      selectedAMPM = "PM";
    } else if (getSelectedHour == 0) {
      selectedHour = 12;
      selectedAMPM = "AM";
    } else if (getSelectedHour == 12) {
      selectedHour = getSelectedHour;
      selectedAMPM = "PM";
    } else {
      selectedHour = getSelectedHour;
      selectedAMPM = "AM";
    }

    if (getSelectedMinute != 0) {
      selectedMinute = getSelectedMinute;
    }

    final FixedExtentScrollController hourController = FixedExtentScrollController(
        initialItem: selectedHour);
    final FixedExtentScrollController minuteController = FixedExtentScrollController(
        initialItem: selectedMinute);
    final FixedExtentScrollController ampmController = FixedExtentScrollController(
        initialItem: selectedAMPM == "AM" ? 0 : 1);

    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setState) {
        return Center(
          child: Align(
            alignment: const Alignment(0.5, 0.25),
            child: Container(
                width: getWidth(width, dateTimeDialogWidth),
                height: getHeight(height, dateTimeDialogHeight),
                // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(14.86390495300293)),
                  border: Border.all(
                      color: homePageDividerColor,
                      width: 1.0617074966430664),
                  // boxShadow: const [
                  //   BoxShadow(
                  //       color: Color(0x40000000),
                  //       offset: Offset(5.308538436889648, 5.308538436889648),
                  //       blurRadius: 6.370244979858398,
                  //       spreadRadius: 0)
                  // ],
                  //color: const Color(0xff484949)
                  image: const DecorationImage(
                      image:
                      AssetImage(alertDialogBg),
                      fit: BoxFit.fill),
                ),
//color: Colors.white,

                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(height, 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: getWidth(width, 23.67),
                          height: getHeight(height, 90),
                          child: Stack(
                            children: [
                              Image.asset(
                                timeUnSelectedImage,
                                fit: BoxFit.cover,
                                width: getWidth(width, 23.67),
                                height: getHeight(height, 90),
                              ),
                              ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    selectedHour = x + 1;
                                  });
                                },
                                controller: hourController,
                                itemExtent: getWidth(width, 23.67),
                                children: List.generate(
                                    12,
                                        (x) =>
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: getHeight(height, 5),
                                              bottom: getHeight(height, 5)),
                                          child: AnimatedContainer(
                                              decoration: x + 1 ==
                                                  selectedHour
                                                  ? const BoxDecoration(
                                                color: homePageDividerColor,
                                              )
                                                  : const BoxDecoration(),
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              alignment: Alignment.center,
                                              child: DefaultTextStyle(
                                                style: const TextStyle(),
                                                child: Text(
                                                  (x < 9
                                                      ? "0${x + 1}"
                                                      : (x + 1))
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: x + 1 ==
                                                          selectedHour
                                                          ? textColor
                                                          : highLightColor,
                                                      fontSize: x + 1 ==
                                                          selectedHour
                                                          ? getAdaptiveTextSize(
                                                          context, 10)
                                                          : getAdaptiveTextSize(
                                                          context, 8)),
                                                ),
                                              )),
                                        )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getWidth(width, 23.67),
                          height: getHeight(height, 90),
                          child: Stack(
                            children: [
                              Image.asset(
                                timeUnSelectedImage,
                                fit: BoxFit.cover,
                                width: getWidth(width, 23.67),
                                height: getHeight(height, 90),
                              ),
                              ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    selectedMinute = x;
                                  });
                                },
                                controller: minuteController,
                                itemExtent: getWidth(width, 23.67),
                                children: List.generate(
                                    60,
                                        (x) =>
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: getHeight(height, 5),
                                              bottom: getHeight(height, 5)),
                                          child: AnimatedContainer(
                                              decoration: x ==
                                                  selectedMinute
                                                  ? const BoxDecoration(
                                                color:
                                                homePageDividerColor,
                                              )
                                                  : const BoxDecoration(),
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              alignment: Alignment.center,
                                              child: DefaultTextStyle(
                                                style: const TextStyle(),
                                                child: Text(
                                                  (x < 10 ? "0$x" : (x))
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: x ==
                                                          selectedMinute
                                                          ? textColor
                                                          : highLightColor,
                                                      fontSize: x ==
                                                          selectedMinute
                                                          ? getAdaptiveTextSize(
                                                          context, 10)
                                                          : getAdaptiveTextSize(
                                                          context, 8)),
                                                ),
                                              )),
                                        )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getWidth(width, 23.67),
                          height: getHeight(height, 90),
                          child: Stack(
                            children: [
                              Image.asset(
                                timeUnSelectedImage,
                                fit: BoxFit.cover,
                                width: getWidth(width, 23.67),
                                height: getHeight(height, 90),
                              ),
                              ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    if (x == 0) {
                                      selectedAMPM = "AM";
                                    } else {
                                      selectedAMPM = "PM";
                                    }
                                  });
                                },
                                controller: ampmController,
                                itemExtent: getWidth(width, 23.67),
                                children: listAMPM
                                    .map((x) =>
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: getHeight(height, 5),
                                          bottom: getHeight(height, 5)),
                                      child: AnimatedContainer(
                                          decoration: x == selectedAMPM
                                              ? const BoxDecoration(
                                            color:
                                            homePageDividerColor,
                                          )
                                              : const BoxDecoration(),
                                          duration: const Duration(
                                              milliseconds: 400),
                                          alignment: Alignment.center,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(),
                                            child: Text(
                                              x.toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: x == selectedAMPM
                                                      ? textColor
                                                      : highLightColor,
                                                  fontSize: x ==
                                                      selectedAMPM
                                                      ? getAdaptiveTextSize(
                                                      context, 10)
                                                      : getAdaptiveTextSize(
                                                      context, 8)),
                                            ),
                                          )),
                                    ))
                                    .toList(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getHeight(height, 20),
                    ),
                    DialogCenterButton(
                        "DONE",
                        optionsNextButtonWidth,
                        optionsNextButtonHeight,
                        optionsNextButtonTextSize, (selected) {
                      String getHour = "";
                      String getMinute = "";
                      if (selectedHour < 10) {
                        getHour = "0$selectedHour";
                      } else {
                        getHour = (selectedHour).toString();
                      }
                      if (selectedMinute < 10) {
                        getMinute = "0$selectedMinute";
                      } else {
                        getMinute = selectedMinute.toString();
                      }
                      String selectedTime =
                          "$getHour:$getMinute $selectedAMPM";

                      int getSelectedHour = selectedHour;
                      if (selectedAMPM == "AM") {
                        if (selectedHour == 12) {
                          getSelectedHour = 0;
                        } else {
                          getSelectedHour = selectedHour;
                        }
                      } else if (selectedAMPM == "PM") {
                        if (selectedHour == 12) {
                          getSelectedHour = selectedHour;
                        } else {
                          getSelectedHour = selectedHour + 12;
                        }
                      }

                      selectedTimeCallback(
                          selectedTime, getSelectedHour, selectedMinute);
                      Navigator.pop(context);
                    }),
                  ],
                )),
          ),
        );
      },
    );
  });
}

void selectEditScheduleDialog(BuildContext context, double height,
    double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    // List<String> listOptions = [
    //   "SCHEDULE 1",
    //   "SCHEDULE 2",
    //   "SCHEDULE 3",
    //   "SCHEDULE 4",
    //   "SCHEDULE 5"
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

    RequestSchedules requestSchedules = RequestSchedules(
        applicationId: applicationId, appUserId: appUserId);

    SchedulesVM schedulesVM = SchedulesVM();
    schedulesVM.getSchedules(requestSchedules);

    int selectedScheduleId = 0;
    ScheduleGetViewModel? selectedSchedule;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 31.85, "EDIT SCHEDULE", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, dialogListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogListHeight),
                        child: ChangeNotifierProvider<SchedulesVM>(
                          create: (BuildContext context) => schedulesVM,
                          child: Consumer<SchedulesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.schedulesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "SchedulesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "SchedulesList :: ERROR${viewModel
                                          .schedulesData.message}");
                                  return Center(
                                      child: Text(
                                        "No Schedules found!",
                                        style: apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "SchedulesList :: COMPLETED");

                                  List<ScheduleGetViewModel>?
                                  listSchedules = viewModel
                                      .schedulesData
                                      .data!
                                      .value!
                                      .scheduleGetViewModel;

                                  if (listSchedules == null ||
                                      listSchedules.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Schedules found!",
                                          style: apiMessageTextStyle(
                                              context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "SchedulesList${listSchedules
                                            .length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listSchedules.length,
                                        itemBuilder: (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listSchedules[position]
                                                      .scheduleName!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      (selected) {
                                                    setState(() {
                                                      if (selected) {
                                                        setState(() {
                                                          selectedScheduleId =
                                                          listSchedules[
                                                          position]
                                                              .id!;
                                                          selectedSchedule =
                                                          listSchedules[
                                                          position];
                                                          for (int i = 0;
                                                          i <
                                                              listSchedules
                                                                  .length;
                                                          i++) {
                                                            listSchedules[i]
                                                                .isSelected =
                                                            false;
                                                          }
                                                          listSchedules[
                                                          position]
                                                              .isSelected =
                                                          true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          selectedScheduleId =
                                                          0;
                                                          selectedSchedule =
                                                          null;
                                                          listSchedules[position]
                                                              .isSelected =
                                                          false;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  tapped: true,
                                                  selected: listSchedules[position]
                                                      .isSelected),
                                              SizedBox(
                                                height: getHeight(height,
                                                    dialogListItemsVerticalMargin),
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
                        //                       i < listMapOptions.length;
                        //                       i++) {
                        //                     listMapOptions[i]['selected'] =
                        //                         false;
                        //                   }
                        //                   listMapOptions[position]
                        //                       ['selected'] = true;
                        //                 });
                        //               } else {
                        //                 setState(() {
                        //                   selectedScheduleId = 0;
                        //                   selectedScheduleName = "";
                        //                   getDate = "";
                        //                   getTime = "";
                        //                   getRepeat = 0;
                        //                   listMapOptions[position]
                        //                       ['selected'] = false;
                        //                 });
                        //               }
                        //             });
                        //           },
                        //               tapped: true,
                        //               selected: listMapOptions[position]
                        //                   ['selected']),
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
                if (selectedScheduleId != 0)
                  DialogButton(
                      "NEXT",
                      optionsNextButtonLeftMargin,
                      optionsNextButtonTopMargin,
                      optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                    Navigator.pop(context);
                    scheduleSelectPlaceRoomDialog(
                        context, height, width, "EDIT SCHEDULE",
                            (buildContext, selectedPlaceId,
                            listSelectedRoomsIds) {
                          if (!selectedSchedule!.individualAction!) {
                            editScheduleScenesDialog(
                                buildContext,
                                height,
                                width,
                                selectedSchedule,
                                selectedPlaceId,
                                listSelectedRoomsIds[0]);
                          } else {
                            editSchedulePairedDevicesDialog(
                                buildContext,
                                height,
                                width,
                                selectedSchedule,
                                selectedPlaceId,
                                listSelectedRoomsIds[0]);
                          }
                        });
                  })
              ],
            )),
      );
    });
  });
}

void selectDeleteScheduleDialog(BuildContext context, double height,
    double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    // List<String> listOptions = [
    //   "SCHEDULE 1",
    //   "SCHEDULE 2",
    //   "SCHEDULE 3",
    //   "SCHEDULE 4",
    //   "SCHEDULE 5"
    // ];
    //
    // List<Map<String, dynamic>> listMapOptions = [];
    // for (var optionName in listOptions) {
    //   Map<String, dynamic> mapOption = {};
    //   mapOption['name'] = optionName;
    //   mapOption['selected'] = false;
    //   listMapOptions.add(mapOption);
    // }

    RequestSchedules requestSchedules = RequestSchedules(
        appUserId: appUserId, applicationId: applicationId);

    SchedulesVM schedulesVM = SchedulesVM();
    schedulesVM.getSchedules(requestSchedules);

    List<int> listSelectedSchedulesIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57, 31.85, "DELETE SCHEDULE", 12.0, "Roboto"),
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
                        child: ChangeNotifierProvider<SchedulesVM>(
                          create: (BuildContext context) => schedulesVM,
                          child: Consumer<SchedulesVM>(
                            builder: (context, viewModel, view) {
                              switch (viewModel.schedulesData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "SchedulesList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "SchedulesList :: ERROR${viewModel
                                          .schedulesData.message}");
                                  return Center(
                                      child: Text(
                                        "No Schedules found!",
                                        style: apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "SchedulesList :: COMPLETED");

                                  List<ScheduleGetViewModel>?
                                  listSchedules = viewModel
                                      .schedulesData
                                      .data!
                                      .value!
                                      .scheduleGetViewModel;

                                  if (listSchedules == null ||
                                      listSchedules.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Schedules found!",
                                          style: apiMessageTextStyle(
                                              context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "SchedulesList${listSchedules
                                            .length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listSchedules.length,
                                        itemBuilder: (context, position) {
                                          return Column(
                                            children: [
                                              DialogCenterButton(
                                                  listSchedules[position]
                                                      .scheduleName!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      (selected) {
                                                    setState(() {
                                                      if (selected) {
                                                        listSelectedSchedulesIds
                                                            .add(
                                                            listSchedules[
                                                            position]
                                                                .id!);
                                                        listSchedules[position]
                                                            .isSelected =
                                                        true;
                                                      } else {
                                                        listSelectedSchedulesIds
                                                            .remove(
                                                            listSchedules[
                                                            position]
                                                                .id);
                                                        listSchedules[position]
                                                            .isSelected =
                                                        false;
                                                      }
                                                    });
                                                  },
                                                  tapped: true,
                                                  selected: listSchedules[
                                                  position]
                                                      .isSelected),
                                              SizedBox(
                                                height: getHeight(height,
                                                    dialogListItemsVerticalMargin),
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
                        //                 listSelectedSchedulesIds.add(position);
                        //                 listMapOptions[position]
                        //                     ['selected'] = true;
                        //               } else {
                        //                 listSelectedSchedulesIds.remove(position);
                        //                 listMapOptions[position]
                        //                     ['selected'] = false;
                        //               }
                        //             });
                        //           },
                        //               tapped: true,
                        //               selected: listMapOptions[position]
                        //                   ['selected']),
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
                if (listSelectedSchedulesIds.isNotEmpty)
                  DialogButton(
                      "DELETE",
                      optionsNextButtonLeftMargin,
                      optionsNextButtonTopMargin,
                      optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                    alertDeleteScheduleDialog(
                        context, height, width, listSelectedSchedulesIds);
                  })
              ],
            )),
      );
    });
  });
}

void alertDeleteScheduleDialog(BuildContext context, double height,
    double width, List<int> listSelectedSchedulesIds) {

  Utils.showDialog(context, (buildContext, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        188.45,
        129.17,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(
                5, 44.24, "ARE YOU SURE YOU WANT\nTO DELETE SCHEDULE?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton(
                        "YES",
                        optionsAlertButtonWidth,
                        optionsAlertButtonHeight,
                        optionsAlertButtonTextSize, () {
                      Navigator.pop(buildContext);
                      alertDeleteScheduleDialogAgain(
                          context, height, width, listSelectedSchedulesIds);
                    }),
                    DialogListButton(
                        "NO",
                        optionsAlertButtonWidth,
                        optionsAlertButtonHeight,
                        optionsAlertButtonTextSize, () {
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

void alertDeleteScheduleDialogAgain(BuildContext context, double height,
    double width, List<int> listSelectedScheduleIds) {

  Utils.showDialog(context, (buildContext, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        188.45,
        129.17,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(
                5, 44.24, "ARE YOU SURE YOU WANT\nTO DELETE SCHEDULE?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton(
                        "NO",
                        optionsAlertButtonWidth,
                        optionsAlertButtonHeight,
                        optionsAlertButtonTextSize, () {
                      Navigator.pop(context);
                    }),
                    DialogListButton(
                        "YES",
                        optionsAlertButtonWidth,
                        optionsAlertButtonHeight,
                        optionsAlertButtonTextSize, () {
                      deleteMultipleSchedules(
                          context, listSelectedScheduleIds, () {
                        Navigator.pop(buildContext);
                        Navigator.pop(buildContext);
                      });
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  });
}

Future<void> deleteMultipleSchedules(BuildContext context,
    List<int> listSelectedScheduleIds, Function onSuccess) async {
  DeleteMultipleSchedulesVM deleteMultipleSchedulesVM =
  DeleteMultipleSchedulesVM();

  List<DeleteScheduleIds> listScheduleIds = [];
  for (int id in listSelectedScheduleIds) {
    listScheduleIds.add(DeleteScheduleIds(id: id));
  }

  RequestDeleteMultipleSchedules requestDeleteMultipleSchedules =
  RequestDeleteMultipleSchedules(
    applicationId: applicationId,
    ids: listScheduleIds,
    deletedBy: appUserId,
    deletedDateTime:
    DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseDeleteMultipleSchedules> deleteMultipleSchedulesData =
  await deleteMultipleSchedulesVM
      .deleteMultipleSchedules(requestDeleteMultipleSchedules);
  if (deleteMultipleSchedulesData.status == ApiStatus.COMPLETED) {
    ResponseDeleteMultipleSchedules responseDeleteMultipleSchedules =
    deleteMultipleSchedulesData.data!;
    if (responseDeleteMultipleSchedules.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseDeleteMultipleSchedules.value!.meta!.message);
  }
}

bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}
