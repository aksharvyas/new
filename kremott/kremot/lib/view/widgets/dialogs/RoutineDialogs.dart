import 'package:flutter/material.dart';
import 'package:kremot/models/RoutinesModel.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/view/widgets/CustomAlertDialog.dart';
import 'package:kremot/view/widgets/DialogCenterButton.dart';
import 'package:kremot/view/widgets/DialogCheckBox.dart';
import 'package:kremot/view/widgets/DialogListButton.dart';
import 'package:kremot/view/widgets/dialogs/place/PlacesLayout.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsLayout.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/RoutinesVM.dart';
import 'package:kremot/view_model/ScenesVM.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/PlacesWithOwnerPermissionsVM.dart';
import '../../../view_model/RoomsVM.dart';
import '../CustomDialog.dart';
import '../DialogAlertText.dart';
import '../DialogButton.dart';
import '../DialogCloseButton.dart';
import '../DialogNote.dart';
import '../DialogTitle.dart';
import '../Loading.dart';

void createRoutineDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "SET SMART",
      "EDIT SMART",
      "DELETE SMART",
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
                DialogTitle(22.23, 36.49, "SMART...", 12.0, "Roboto"),
                DialogCloseButton(15, 30, () {
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
                              height: getHeight(height, optionsButtonTopMargin),
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
                        setSmartDialog(context, height, width);
                        break;
                      case 1:
                        selectEditSmartDialog(context, height, width);
                        break;
                      case 2:
                        routineSelectPlaceRoomDialog(
                            context, height, width, "DELETE SMART",
                                (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                              deleteSmartDialog(buildContext, height, width);
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

void setSmartDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "WHEN EVENT TRIGGERS FROM",
      "DO ACTION",
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
                DialogTitle(22.23, 36.49, "SET SMART...", 12.0, "Roboto"),
                DialogCloseButton(15, 30, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, 81.12),
                  child: ListView.builder(
                      itemCount: listMapOptions.length,
                      itemBuilder: (context, position) {
                        return Column(
                          children: [
                            DialogCenterButton(
                                listMapOptions[position]['name'],
                                optionsButtonWidth,
                                optionsButtonHeight,
                                7.5, (selected) {
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
                              height: getHeight(height, 38),
                            ),
                          ],
                        );
                      }),
                ),
                if (selectedPosition != -1)
                  DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight, optionsNextButtonTextSize, () {
                        Navigator.pop(context);
                        switch (selectedPosition) {
                          case 0:
                            setEventTriggersDialog(context, height, width);
                            break;
                          case 1:
                            routineSelectPlaceRoomDialog(
                                context, height, width, "DO ACTION",
                                    (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                                  routineScenesPairedDevicesDialog(buildContext, height, width, listSelectedRoomsIds[0]);
                                });
                            break;
                        }
                      }),
              ],
            )),
      );
    });
  });

}

void selectEditSmartDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "SMART--1",
      "SMART--2",
      "SMART--3",
      "SMART--4",
    ];

    List<Map<String, dynamic>> listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      mapOption['selected'] = false;
      listMapOptions.add(mapOption);
    }

    // RequestRoutines requestRoutines = RequestRoutines();
    //
    // RoutinesVM routinesVM = RoutinesVM();
    // routinesVM.getRoutines(requestRoutines);

    String selectedSmartId = "";

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 31.85, "EDIT SMART", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, optionsListTopMargin1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, 250),
                        // child: ChangeNotifierProvider<RoutinesVM>(
                        //   create: (BuildContext context) => routinesVM,
                        //   child: Consumer<RoutinesVM>(
                        //     builder: (context, viewModel, view) {
                        //       switch (viewModel.routinesData.status) {
                        //         case ApiStatus.LOADING:
                        //           Utils.printMsg(
                        //               "RoutinesList :: LOADING");
                        //           return const Loading();
                        //         case ApiStatus.ERROR:
                        //           Utils.printMsg(
                        //               "RoutinesList :: ERROR${viewModel.routinesData.message}");
                        //           return Center(
                        //               child: DefaultTextStyle(
                        //                   style: const TextStyle(),
                        //                   child: Text(
                        //                     "No Routines found!",
                        //                     style: kNormalTextStyle(),
                        //                     textAlign: TextAlign.center,
                        //                   )));
                        //         case ApiStatus.COMPLETED:
                        //           Utils.printMsg(
                        //               "RoutinesList :: COMPLETED");
                        //
                        //           List<AdditionalAdminAccessPermissions>?
                        //           listRoutines = viewModel
                        //               .routinesData
                        //               .data!
                        //               .value!
                        //               .appUserAccessPermissions;
                        //
                        //           if (listRoutines == null ||
                        //               listRoutines.isEmpty) {
                        //             return Center(
                        //                 child: DefaultTextStyle(
                        //                     style: const TextStyle(),
                        //                     child: Text(
                        //                       "No Routines found!",
                        //                       style: kNormalTextStyle(),
                        //                       textAlign: TextAlign.center,
                        //                     )));
                        //           } else {
                        //             Utils.printMsg(
                        //                 "RoutinesList${listRoutines.length}");
                        //
                        //             return ListView.builder(
                        //                 padding: EdgeInsets.zero,
                        //                 itemCount: listRoutines.length,
                        //                 itemBuilder: (context, position) {
                        //                   return Column(
                        //                     children: [
                        //                       DialogCenterButton(
                        //                           listRoutines[position].name,
                        //                           optionsButtonWidth,
                        //                           optionsButtonHeight,
                        //                           optionsTextSize, (selected) {
                        //                         setState(() {
                        //                           if (selected) {
                        //                             setState(() {
                        //                               selectedSmartId = listRoutines[position].id;
                        //                               for (int i = 0; i < listRoutines.length; i++) {
                        //                                 listRoutines[i].isSelected = false;
                        //                               }
                        //                               listRoutines[position].isSelected = true;
                        //                             });
                        //                           } else {
                        //                             setState(() {
                        //                               selectedSmartId = "";
                        //                               listRoutines[position].isSelected = false;
                        //                             });
                        //                           }
                        //                         });
                        //                       },
                        //                           tapped: true,
                        //                           selected: listRoutines[position].isSelected),
                        //                       SizedBox(
                        //                         height: getHeight(height, 15),
                        //                       ),
                        //                     ],
                        //                   );
                        //                 });
                        //           }
                        //         default:
                        //       }
                        //       return const Loading();
                        //     },
                        //   ),
                        // ),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
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
                                      if (selected) {
                                        setState(() {
                                          selectedSmartId =
                                              position.toString();
                                          for (int i = 0;
                                          i < listMapOptions.length;
                                          i++) {
                                            listMapOptions[i]['selected'] =
                                            false;
                                          }
                                          listMapOptions[position]
                                          ['selected'] = true;
                                        });
                                      } else {
                                        setState(() {
                                          selectedSmartId = "";
                                          listMapOptions[position]
                                          ['selected'] = false;
                                        });
                                      }
                                    });
                                  },
                                      tapped: true,
                                      selected: listMapOptions[position]
                                      ['selected']),
                                  SizedBox(
                                    height: getHeight(height, optionsButtonTopMargin),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                if (selectedSmartId != "")
                  DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight, optionsNextButtonTextSize, () {
                        Navigator.pop(context);
                        //setSmartDialog(context, height, width);
                      })
              ],
            )),
      );
    });
  });

}

void setEventTriggersDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "TEMPERATURE CHANGES",
      "DEVICE OPERATED",
      "GEO FENCING"
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
                DialogTitle(22.23, 36.49, "SET SMART...", 12.0, "Roboto"),
                DialogCloseButton(15, 30, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, 42.96),
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
                              height: getHeight(height, 35),
                            ),
                          ],
                        );
                      }),
                ),
                if (selectedPosition != -1)
                  DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight, optionsNextButtonTextSize, () {
                        Navigator.pop(context);
                        switch (selectedPosition) {
                          case 0:
                            routineSelectPlaceRoomDialog(
                                context, height, width, "SET SMART...",
                                    (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                                  setTemperatureDialog(buildContext, height, width);
                                });
                            break;
                          case 1:
                            routineSelectPlaceRoomDialog(
                                context, height, width, "SET SMART...",
                                    (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                                  selectPairedDevicesDialog(buildContext, height, width);
                                });
                            break;
                          case 2:
                            setGeofencingDialog(context, height, width);
                            break;
                        }
                      }),
              ],
            )),
      );
    });
  });

}

void setTemperatureDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    int selectedTemp = 24;

    List<int> listTemperatures = [];
    int minTemp = 16;
    int maxTemp = 41;
    for (int i = minTemp; i < maxTemp; i++) {
      listTemperatures.add(i);
    }

    FixedExtentScrollController scrollController =
    FixedExtentScrollController(initialItem: (selectedTemp - minTemp));

    bool increaseSelected = false;
    bool decreaseSelected = false;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 21.23, "SET SMART...", 12.0, "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                Positioned(
                  left: getX(width, 45),
                  top: getY(height, 140),
                  child: DialogCenterButton(
                    "INCREASE\nFROM",
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    getAdaptiveTextSize(context, 8),
                        (selected) {
                      setState(() {
                        increaseSelected = true;
                        decreaseSelected = false;

                        if (selectedTemp < maxTemp - 1) {
                          selectedTemp = selectedTemp + 1;
                          scrollController
                              .jumpToItem(selectedTemp - minTemp);
                        }
                      });
                    },
                    tapped: true,
                    selected: increaseSelected,
                  ),
                ),
                Positioned(
                  left: getX(width, 45),
                  top: getY(height, 185),
                  child: DialogCenterButton(
                    "DECREASE\nFROM",
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    getAdaptiveTextSize(context, 8),
                        (selected) {
                      setState(() {
                        increaseSelected = false;
                        decreaseSelected = true;

                        if (selectedTemp > minTemp) {
                          selectedTemp = selectedTemp - 1;
                          scrollController
                              .jumpToItem(selectedTemp - minTemp);
                        }
                      });
                    },
                    tapped: true,
                    selected: decreaseSelected,
                  ),
                ),
                Positioned(
                    right: getX(width, 45),
                    top: getY(height, 140),
                    child: SizedBox(
                      width: getWidth(width, 30),
                      height: getHeight(height, 80),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            timeUnSelectedImage,
                            fit: BoxFit.cover,
                            width: getWidth(width, 30),
                            height: getHeight(height, 80),
                          ),
                          ListWheelScrollView(
                            magnification: 2.0,
                            onSelectedItemChanged: (x) {
                              setState(() {
                                selectedTemp = listTemperatures[x];
                              });
                            },
                            controller: scrollController,
                            itemExtent: getWidth(width, 30),
                            children: listTemperatures
                                .map((x) => Container(
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 5),
                              child: AnimatedContainer(
                                  decoration: x == selectedTemp
                                      ? const BoxDecoration(
                                      color: homePageDividerColor
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
                                          fontWeight: FontWeight.bold,
                                          color: x == selectedTemp ? textColor : highLightColor,
                                          fontSize:
                                          x == selectedTemp
                                              ? getAdaptiveTextSize(context, 12.0)
                                              : getAdaptiveTextSize(context, 8.0)),
                                    ),
                                  )),
                            ))
                                .toList(),
                          )
                        ],
                      ),
                    )),
                DialogButton("THEN", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight, optionsNextButtonTextSize, () {}),
              ],
            )),
      );
    });
  });

}

void routineSelectPlaceRoomDialog(BuildContext context, double height, double width,
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
    return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
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
                                    return DialogCenterButton(
                                        "NEXT",
                                        optionsNextButtonWidth,
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
        }
    );
  });

}

void selectPairedDevicesDialog(
    BuildContext context, double height, double width) {

  bool isFanSelected = false;

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listPairedDevices = [
      "SW 01",
      "SW 02",
      "SW 03",
      "SW 04",
      "SW 05",
      "SW 06",
      "SW 07",
      "SW 08",
    ];

    List<Map<String, dynamic>> listPairedDevicesMapOptions = [];
    for (var pairedDeviceName in listPairedDevices) {
      Map<String, dynamic> mapPairedDevice = {};
      mapPairedDevice['name'] = pairedDeviceName;
      mapPairedDevice['selected'] = false;
      listPairedDevicesMapOptions.add(mapPairedDevice);
    }

    int selectedPairedDevicePosition = -1;

    final FixedExtentScrollController _scrollController =
    FixedExtentScrollController(initialItem: 1);
    int selected = 4;
    double itemWidth = 35.0;
    int itemCount = 9;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 21.23, "SET SMART...", 12.0, "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                DialogButton("PAIRED\nDEVICES", optionsNextButtonLeftMargin, optionsListTopMargin, optionsNextButtonWidth, optionsNextButtonHeight,
                    optionsButtonTextSize, () {}),
                Positioned.fill(
                  top: getY(height, optionsListTopMargin + optionsNextButtonHeight + dialogListItemsVerticalMargin),
                  left: getX(width, 33.18),
                  right: getX(width, 33.18),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogHeaderListHeight),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            GridView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: getHeight(height, 16.35),
                                mainAxisExtent: getHeight(height, 30),
                              ),
                              children: List.generate(
                                  listPairedDevicesMapOptions.length,
                                      (index) => Align(
                                    alignment: Alignment.center,
                                    child: DialogCenterButton(
                                      listPairedDevicesMapOptions[index]['name'],
                                      optionsNextButtonWidth,
                                      optionsNextButtonHeight,
                                      optionsNextButtonTextSize,
                                          (selected) {
                                        setState(() {
                                          for (int i = 0; i < listPairedDevicesMapOptions.length; i++) {
                                            listPairedDevicesMapOptions[i]['selected'] = false;
                                          }

                                          if (selected) {
                                            selectedPairedDevicePosition = index;
                                            listPairedDevicesMapOptions[index]['selected'] = true;
                                          } else {
                                            selectedPairedDevicePosition = -1;
                                          }
                                        });
                                      },
                                      tapped: true,
                                      selected: listPairedDevicesMapOptions[index]['selected'],
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: getHeight(height, dialogListItemsVerticalMarginSmall),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  isFanSelected = !isFanSelected;
                                });
                              },
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image.asset(
                                      isFanSelected
                                          ? fanSelectedImage
                                          : fanUnSelectedImage,
                                      height: getHeight(height,
                                          kRemotButtonHeight),
                                      width: getWidth(
                                          width, kRemotButtonWidth),
                                      fit: BoxFit.fill),
                                  Positioned(
                                      top: getY(height, 2),
                                      child: Text("FAN 1",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: highLightColor,
                                              fontWeight:
                                              FontWeight.w700,
                                              //fontFamily: "Inter",
                                              fontStyle:
                                              FontStyle.normal,
                                              fontSize:
                                              getAdaptiveTextSize(
                                                  context, 9)),
                                          textAlign:
                                          TextAlign.center)),
                                  Positioned.fill(
                                      left: getX(width, 35),
                                      right: getX(width, 35),
                                      top: getY(height, 10),
                                      child: RotatedBox(
                                          quarterTurns: -1,
                                          child: ListWheelScrollView
                                              .useDelegate(
                                            magnification: 2.0,
                                            onSelectedItemChanged:
                                                (x) {
                                              setState(() {
                                                selected = x;
                                              });
                                            },
                                            controller:
                                            _scrollController,
                                            itemExtent: getWidth(
                                                width, itemWidth),
                                            childDelegate:
                                            ListWheelChildLoopingListDelegate(
                                              children: List.generate(
                                                  itemCount,
                                                      (x) => RotatedBox(
                                                      quarterTurns: 1,
                                                      child: AnimatedContainer(
                                                          decoration: x == selected
                                                              ? const BoxDecoration(
                                                            color: homePageDividerColor,
                                                          )
                                                              : const BoxDecoration(),
                                                          duration: const Duration(milliseconds: 400),
                                                          width: x == selected ? getWidth(width, fanButtonSelectedWidth) : getWidth(width, fanButtonUnSelectedWidth),
                                                          height: x == selected ? getHeight(height, fanButtonSelectedHeight) : getHeight(height, fanButtonUnSelectedHeight),
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            (x + 1)
                                                                .toString(),
                                                            style: TextStyle(
                                                                decoration: TextDecoration.none,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: x == selected
                                                                    ? getAdaptiveTextSize(context, fanButtonSelectedTextSize)
                                                                    : getAdaptiveTextSize(context, fanButtonUnSelectedTextSize)),
                                                          )))),
                                            ),
                                          ))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if(selectedPairedDevicePosition != -1) Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: DialogCenterButton(
                      "DONE",
                      optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize,
                          (selected) {}),
                ),
              ],
            )),
      );
    });
  });

}

void setGeofencingDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(22.23, 36.49, "SET SMART...", 12.0, "Roboto"),
              DialogCloseButton(15, 30, () {
                Navigator.pop(context);
              }),
              Positioned(
                top: getY(height, 120),
                left: getX(width, 90.66),
                child: Image.asset("assets/images/location.png",
                    height: getHeight(height, 85.33),
                    width: getWidth(width, 83.33),
                    fit: BoxFit.fill),
              ),
              DialogButton("THEN", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                  optionsNextButtonHeight, optionsNextButtonTextSize, () {}),
            ],
          )),
    );
  });

}

void routineScenesPairedDevicesDialog(BuildContext context, double height, double width, String selectedRoomId) {

  bool isFanSelected = false;

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    int selectedTabPosition = 0;

    RequestScenes requestScenes = RequestScenes(applicationId: applicationId, roomId: selectedRoomId);

    ScenesVM scenesVM = ScenesVM();
    scenesVM.getScenes(requestScenes);

    String selectedSceneId = "";

    List<String> listPairedDevices = [
      "SW 01",
      "SW 02",
      "SW 03",
      "SW 04",
      "SW 05",
      "SW 06",
      "SW 07",
      "SW 08",
    ];

    List<Map<String, dynamic>> listPairedDevicesMapOptions = [];
    for (var pairedDeviceName in listPairedDevices) {
      Map<String, dynamic> mapPairedDevice = {};
      mapPairedDevice['name'] = pairedDeviceName;
      mapPairedDevice['selected'] = false;
      listPairedDevicesMapOptions.add(mapPairedDevice);
    }

    int selectedPairedDevicePosition = -1;

    final FixedExtentScrollController _scrollController =
    FixedExtentScrollController(initialItem: 1);
    int selected = 4;
    double itemWidth = 35.0;
    int itemCount = 9;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 21.23, "DO ACTION", 12.0, "Roboto"),
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
                        height: getHeight(height, dialogHeaderListHeight),
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
                                                setState(() {
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
                                              },
                                                  tapped: true,
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
                )
                    : Positioned.fill(
                  top: getY(height, dialogHeaderListTopMargin),
                  left: getX(width, 33.18),
                  right: getX(width, 33.18),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogHeaderListHeight),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            GridView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: getHeight(height, 16.35),
                                mainAxisExtent: getHeight(height, 30),
                              ),
                              children: List.generate(
                                  listPairedDevicesMapOptions.length,
                                      (index) => Align(
                                    alignment: Alignment.center,
                                    child: DialogCenterButton(
                                      listPairedDevicesMapOptions[index]['name'],
                                      optionsNextButtonWidth,
                                      optionsNextButtonHeight,
                                      optionsNextButtonTextSize,
                                          (selected) {
                                        setState((){
                                          for (int i = 0; i < listPairedDevicesMapOptions.length; i++) {
                                            listPairedDevicesMapOptions[i]['selected'] = false;
                                          }

                                          if (selected) {
                                            selectedPairedDevicePosition = index;
                                            listPairedDevicesMapOptions[index]['selected'] = true;
                                          } else {
                                            selectedPairedDevicePosition = -1;
                                          }
                                        });
                                      },
                                      tapped: true,
                                      selected: listPairedDevicesMapOptions[index]['selected'],
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: getHeight(height, dialogListItemsVerticalMarginSmall),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  isFanSelected = !isFanSelected;
                                });
                              },
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image.asset(
                                      isFanSelected
                                          ? fanSelectedImage
                                          : fanUnSelectedImage,
                                      height: getHeight(height,
                                          kRemotButtonHeight),
                                      width: getWidth(
                                          width, kRemotButtonWidth),
                                      fit: BoxFit.fill),
                                  Positioned(
                                      top: getY(height, 2),
                                      child: Text("FAN 1",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: highLightColor,
                                              fontWeight:
                                              FontWeight.w700,
                                              //fontFamily: "Inter",
                                              fontStyle:
                                              FontStyle.normal,
                                              fontSize:
                                              getAdaptiveTextSize(
                                                  context, 9)),
                                          textAlign:
                                          TextAlign.center)),
                                  Positioned.fill(
                                      left: getX(width, 35),
                                      right: getX(width, 35),
                                      top: getY(height, 10),
                                      child: RotatedBox(
                                          quarterTurns: -1,
                                          child: ListWheelScrollView
                                              .useDelegate(
                                            magnification: 2.0,
                                            onSelectedItemChanged:
                                                (x) {
                                              setState(() {
                                                selected = x;
                                              });
                                            },
                                            controller:
                                            _scrollController,
                                            itemExtent: getWidth(
                                                width, itemWidth),
                                            childDelegate:
                                            ListWheelChildLoopingListDelegate(
                                              children: List.generate(
                                                  itemCount,
                                                      (x) => RotatedBox(
                                                      quarterTurns: 1,
                                                      child: AnimatedContainer(
                                                          decoration: x == selected
                                                              ? const BoxDecoration(
                                                            color: homePageDividerColor,
                                                          )
                                                              : const BoxDecoration(),
                                                          duration: const Duration(milliseconds: 400),
                                                          width: x == selected ? getWidth(width, fanButtonSelectedWidth) : getWidth(width, fanButtonUnSelectedWidth),
                                                          height: x == selected ? getHeight(height, fanButtonSelectedHeight) : getHeight(height, fanButtonUnSelectedHeight),
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            (x + 1)
                                                                .toString(),
                                                            style: TextStyle(
                                                                decoration: TextDecoration.none,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: x == selected
                                                                    ? getAdaptiveTextSize(context, fanButtonSelectedTextSize)
                                                                    : getAdaptiveTextSize(context, fanButtonUnSelectedTextSize)),
                                                          )))),
                                            ),
                                          ))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if((selectedTabPosition == 0 && selectedSceneId.isNotEmpty) || (selectedTabPosition == 1 && selectedPairedDevicePosition != -1)) Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: DialogCenterButton(
                      "DONE",
                      optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize,
                          (selected) {}),
                ),
              ],
            )),
      );
    });
  });

}

void deleteSmartDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listSmartDevices = [
      "SMART--1",
      "SMART--2",
      "SMART--3",
      "SMART--4"
    ];

    List<Map<String, dynamic>> listMapSmartDevices = [];
    for (var smartDeviceName in listSmartDevices) {
      Map<String, dynamic> mapSmartDevice = {};
      mapSmartDevice['name'] = smartDeviceName;
      mapSmartDevice['selected'] = false;
      listMapSmartDevices.add(mapSmartDevice);
    }

    // RequestRoutines requestRoutines = RequestRoutines();
    //
    // RoutinesVM routinesVM = RoutinesVM();
    // routinesVM.getRoutines(requestRoutines);

    List<String> listSelectedSmartDevicesIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 24.88, "DELETE SMART", 12.0, "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                Positioned(
                  left: getX(width, placeTextLeftMargin),
                  top: getY(height, placeTextTopMargin),
                  child: Text("SMART",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: getAdaptiveTextSize(context, 11)),
                      textAlign: TextAlign.center),
                ),
                Positioned(
                  left: getX(width, roomTextLeftMargin),
                  top: getY(height, roomTextTopMargin),
                  child: Text("SELECT",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: getAdaptiveTextSize(context, 11),),
                      textAlign: TextAlign.center),
                ),
                Positioned(
                  left: getX(width, placeTopArrowLeftMargin),
                  top: getY(height, placeTopArrowTopMargin),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned(
                  left: getX(width, roomTopArrowLeftMargin),
                  top: getY(height, roomTopArrowTopMargin),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned.fill(
                  left: getX(width, placeListButtonLeftMargin),
                  right: getX(width, placeListButtonLeftMargin),
                  top: getY(height, placeListButtonTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, placeListHeight),
                        // child: ChangeNotifierProvider<RoutinesVM>(
                        //   create: (BuildContext context) => routinesVM,
                        //   child: Consumer<RoutinesVM>(
                        //     builder: (context, viewModel, view) {
                        //       switch (viewModel.routinesData.status) {
                        //         case ApiStatus.LOADING:
                        //           Utils.printMsg(
                        //               "RoutinesList :: LOADING");
                        //           return const Loading();
                        //         case ApiStatus.ERROR:
                        //           Utils.printMsg(
                        //               "RoutinesList :: ERROR${viewModel.routinesData.message}");
                        //           return Center(
                        //               child: DefaultTextStyle(
                        //                   style: const TextStyle(),
                        //                   child: Text(
                        //                     "No Routines found!",
                        //                     style: kNormalTextStyle(),
                        //                     textAlign: TextAlign.center,
                        //                   )));
                        //         case ApiStatus.COMPLETED:
                        //           Utils.printMsg(
                        //               "RoutinesList :: COMPLETED");
                        //
                        //           List<AdditionalAdminAccessPermissions>?
                        //           listRoutines = viewModel
                        //               .routinesData
                        //               .data!
                        //               .value!
                        //               .appUserAccessPermissions;
                        //
                        //           if (listRoutines == null ||
                        //               listRoutines.isEmpty) {
                        //             return Center(
                        //                 child: DefaultTextStyle(
                        //                     style: const TextStyle(),
                        //                     child: Text(
                        //                       "No Routines found!",
                        //                       style: kNormalTextStyle(),
                        //                       textAlign: TextAlign.center,
                        //                     )));
                        //           } else {
                        //             Utils.printMsg(
                        //                 "RoutinesList${listRoutines.length}");
                        //
                        //             return ListView.builder(
                        //                 padding: EdgeInsets.zero,
                        //                 itemCount: listRoutines.length,
                        //                 itemBuilder: (context, position) {
                        //                   return Column(
                        //                     children: [
                        //                       Row(
                        //                         mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           DialogListButton(
                        //                             listRoutines[position].name,
                        //                             optionsButtonWidth,
                        //                             optionsButtonHeight,
                        //                             optionsTextSize,
                        //                                 () {},),
                        //                           DialogCheckBox(
                        //                             31.85,
                        //                             27.87,
                        //                             listRoutines[position].isSelected,
                        //                                 (isChecked) {
                        //                               if (isChecked) {
                        //                                 listSelectedSmartDevicesIds.add(listRoutines[position].id);
                        //                                 setState(() {
                        //                                   listRoutines[position].isSelected = true;
                        //                                 });
                        //                               } else {
                        //                                 listSelectedSmartDevicesIds.remove(listRoutines[position].id);
                        //                                 setState(() {
                        //                                   listRoutines[position].isSelected = false;
                        //                                 });
                        //                               }
                        //                             },
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       SizedBox(
                        //                         height: getHeight(height, 15.42),
                        //                       ),
                        //                     ],
                        //                   );
                        //                 });
                        //           }
                        //         default:
                        //       }
                        //       return const Loading();
                        //     },
                        //   ),
                        // ),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: listMapSmartDevices.length,
                            itemBuilder: (context, position) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      DialogListButton(
                                        listMapSmartDevices[position]
                                        ['name'],
                                        optionsButtonWidth,
                                        optionsButtonHeight,
                                        optionsButtonTextSize,
                                            () {},),
                                      SizedBox(width: getWidth(width, 63)),
                                      DialogCheckBox(
                                        31.85,
                                        27.87,
                                        listMapSmartDevices[position]
                                        ['selected'],
                                            (isChecked) {
                                          if (isChecked) {
                                            listSelectedSmartDevicesIds.add(listMapSmartDevices[position]['name']);
                                            setState(() {
                                              listMapSmartDevices[position]['selected'] = true;
                                            });
                                          } else {
                                            listSelectedSmartDevicesIds.remove(listMapSmartDevices[position]['name']);
                                            setState(() {
                                              listMapSmartDevices[position]['selected'] = false;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getHeight(height, dialogListItemsVerticalMargin),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: getX(width, placeBottomArrowLeftMargin),
                  top: getY(height, placeBottomArrowTopMargin),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: arrowColor,
                  ),
                ),
                Positioned(
                  left: getX(width, roomBottomArrowLeftMargin),
                  top: getY(height, roomBottomArrowTopMargin),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: arrowColor,
                  ),
                ),
                if(listSelectedSmartDevicesIds.isNotEmpty) Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: DialogCenterButton(
                      "DELETE",
                      optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, (selected) {
                    alertDeleteSmartDialog(context, height, width);
                  }),
                ),
                DialogNote(39, 324.18, "NOTE: SELECT 1 PLACE & MULTIPLE ROOM AT A TIME"),
              ],
            )),
      );
    });
  });

}

void alertDeleteSmartDialog(BuildContext context, double height, double width) {

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
                "ARE YOU SURE YOU WANT\nTO DELETE SMART?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(context);
                      alertDeleteSmartDialogAgain(context, height, width);
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

void alertDeleteSmartDialogAgain(BuildContext context, double height, double width) {

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
                "ARE YOU SURE YOU WANT\nTO DELETE SMART?"),
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


// void alertDeleteRoutineDialog(
//     BuildContext context, double height, double width) {
//   showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black45,
//       transitionDuration: const Duration(milliseconds: 200),
//       pageBuilder: (BuildContext buildContext, Animation animation,
//           Animation secondaryAnimation) {
//         return Center(
//           child: CustomDialog(
//             188.45,
//             129.17,
//             Stack(
//               children: [
//                 DialogCloseButton(7.0, 8.0, () {
//                   Navigator.pop(context);
//                 }),
//                 DialogTitle(5, 44.24,
//                     "ARE YOU SURE YOU WANT TO DELETE ROUTINE?", 7.0, "Inter",
//                     alignment: "center"),
//                 Positioned.fill(
//                     top: getY(height, alertButtonsTopMargin),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         DialogListButton("YES", 55.07, 30.52, 10.0, () {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                         }),
//                         DialogListButton("NO", 55.07, 30.52, 10.0, () {
//                           Navigator.pop(context);
//                         }),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         );
//       });
// }
