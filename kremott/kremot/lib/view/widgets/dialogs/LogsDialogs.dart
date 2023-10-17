import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/models/UsersModel.dart';
import 'package:kremot/view/widgets/dialogs/place/PlacesLayout.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsLayout.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:kremot/view_model/ScenesVM.dart';
import 'package:kremot/view_model/UsersVM.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../models/RoomsModel.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/RoomsVM.dart';
import '../CustomDialog.dart';
import '../DialogButton.dart';
import '../DialogCenterButton.dart';
import '../DialogCloseButton.dart';
import '../DialogListButton.dart';
import '../DialogNote.dart';
import '../DialogTitle.dart';
import '../Loading.dart';
import '../widget.dart';

void createLogsDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "USER",
      "DEVICE",
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
                DialogTitle(22.23, 36.49, "LOGS", 12.0, "Roboto"),
                DialogCloseButton(15, 30, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, 82.11),
                  child: ListView.builder(
                      itemCount: listOptions.length,
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
                              height: getHeight(height, 31),
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
                            logsSelectUserDialog(context, height, width);
                            break;
                          case 1:
                            logsSelectPlaceRoomDialog(context, height, width, (buildContext, selectedPlaceId, listSelectedRoomsIds) {
                              logsScenesPairedDevicesDialog(buildContext, height, width, listSelectedRoomsIds[0]);
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

void logsSelectUserDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "USER 1",
      "USER 2",
      "USER 3",
      "USER 4",
      "USER 5"
    ];

    List<Map<String, dynamic>> listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      mapOption['selected'] = false;
      listMapOptions.add(mapOption);
    }

    // RequestUsers requestUsers = RequestUsers();
    //
    // UsersVM usersVM = UsersVM();
    // usersVM.getUsers(requestUsers);

    String selectedUserId = "";

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(20.57, 31.85, "LOGS", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, dialogListTopMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, dialogListHeight),
                        // child: ChangeNotifierProvider<UsersVM>(
                        //   create: (BuildContext context) => additionalAdminsVM,
                        //   child: Consumer<UsersVM>(
                        //     builder: (context, viewModel, view) {
                        //       switch (viewModel.usersData.status) {
                        //         case ApiStatus.LOADING:
                        //           Utils.printMsg("UsersList :: LOADING");
                        //           return const Loading();
                        //         case ApiStatus.ERROR:
                        //           Utils.printMsg("UsersList :: ERROR${viewModel.usersData.message}");
                        //           return Center(
                        //               child: DefaultTextStyle(
                        //                   style: const TextStyle(),
                        //                   child: Text(
                        //                     "No Users found!",
                        //                     style: kNormalTextStyle(),
                        //                     textAlign: TextAlign.center,
                        //                   )));
                        //         case ApiStatus.COMPLETED:
                        //           Utils.printMsg(
                        //               "UsersList :: COMPLETED");
                        //
                        //           List<AdditionalAdminAccessPermissions>?
                        //           listUsers = viewModel
                        //               .usersData
                        //               .data!
                        //               .value!
                        //               .appUserAccessPermissions;
                        //
                        //           if (listUsers == null ||
                        //               listUsers.isEmpty) {
                        //             return Center(
                        //                 child: DefaultTextStyle(
                        //                     style: const TextStyle(),
                        //                     child: Text(
                        //                       "No Users found!",
                        //                       style: kNormalTextStyle(),
                        //                       textAlign: TextAlign.center,
                        //                     )));
                        //           } else {
                        //             Utils.printMsg(
                        //                 "UsersList${listUsers.length}");
                        //
                        //             return ListView.builder(
                        //                 padding: EdgeInsets.zero,
                        //                 itemCount: listMapOptions.length,
                        //                 itemBuilder: (context, position) {
                        //                   return Column(
                        //                     children: [
                        //                       DialogCenterButton(
                        //                           listUsers[position].username!,
                        //                           optionsButtonWidth,
                        //                           optionsButtonHeight,
                        //                           optionsTextSize, (selected) {
                        //                         setState(() {
                        //                           if (selected) {
                        //                             setState(() {
                        //                               selectedUserId = listUsers[position].userId!;
                        //                               for (int i = 0; i < listMapOptions.length; i++) {
                        //                                 listUsers[position].isSelected = false;
                        //                               }
                        //                               listUsers[position].isSelected = true;
                        //                             });
                        //                           } else {
                        //                             setState(() {
                        //                               selectedUserId = "";
                        //                               listUsers[position].isSelected = false;
                        //                             });
                        //                           }
                        //                         });
                        //                       },
                        //                           tapped: true,
                        //                           selected: listUsers[position].isSelected),
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
                                          selectedUserId =
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
                                          selectedUserId = "";
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
                                    height: getHeight(height, dialogListItemsVerticalMargin),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                if (selectedUserId != "")
                  DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                      optionsNextButtonHeight,
                      optionsNextButtonTextSize, () {
                        Navigator.pop(context);
                        logsSelectPlaceRoomDialog(context, height, width, (buildContext, selectedPlaceId, listSelectedRoomsIds){
                          logsSelectDateDialog(buildContext, height, width);
                        });
                      })
              ],
            )),
      );
    });
  });

}

void logsSelectPlaceRoomDialog(
    BuildContext context, double height, double width, Function onNextTap) {
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
                  DialogTitle(
                      20.57, 21.23, "SELECT PLACE & ROOM", 12.0, "Roboto"),
                  DialogCloseButton(15, 18, () {
                    Navigator.pop(context);
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
                                          onNextTap(buildContext, selectedPlace.homeId, listSelectedRoomsIds);
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
      },
    );
  });

}

void logsSelectDateDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(36.67, 51, "SELECT DATE", 12.0, "Roboto"),
                DialogCloseButton(15, 18, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, optionsListTopMargin1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getX(width, 5.0)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("FROM",
                          style: TextStyle(
                            color: dialogTitleColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: getAdaptiveTextSize(context, 12.0),
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                DialogButton(formatter.format(startDate), optionsNextButtonLeftMargin, optionsListTopMargin1 + dialogListItemsVerticalMargin, optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize, () async{
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null && picked != startDate) {
                    setState(() {
                      startDate = picked;
                    });
                  }
                }),
                Positioned.fill(
                  top: getY(height, optionsListTopMargin1 + optionsNextButtonHeight +  (2 * dialogListItemsVerticalMargin)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getX(width, 5.0)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("TO",
                          style: TextStyle(
                            color: dialogTitleColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: getAdaptiveTextSize(context, 12.0),
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                DialogButton(formatter.format(endDate), optionsNextButtonLeftMargin, optionsListTopMargin1 + optionsNextButtonHeight + (3 * dialogListItemsVerticalMargin), optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize, () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null && picked != endDate) {
                    setState(() {
                      endDate = picked;
                    });
                  }
                }),
                DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsNextButtonTextSize, () {
                      Navigator.pop(context);
                      logsUsersDateTimeDialog(
                          context, height, width, "RONAK PATEL");
                    })
              ],
            )),
      );
    });
  });

}

void logsScenesPairedDevicesDialog(
    BuildContext context, double height, double width, String selectedRoomId) {

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
                DialogTitle(20.57, 21.23, "LOGS", 12.0, "Roboto"),
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
                                                optionsButtonTextSize,
                                                    (selected) {
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
                                                selected: listScenes[position].isSelected,),
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
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing:
                                getHeight(height, 16.35),
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
                                          for(int i=0; i<listPairedDevicesMapOptions.length; i++){
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
                  child: DialogCenterButton("DONE", optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize,
                          (selected) {
                        Navigator.pop(context);
                        if (selectedTabPosition == 0) {
                          logsScenesDateTimeDialog(
                              context, height, width, "SCENE1");
                        } else {
                          logsPairedDevicesDateTimeDialog(
                              context, height, width, "L1");
                        }
                      }),
                ),
              ],
            )),
      );
    });
  });

}

void logsUsersDateTimeDialog(BuildContext context, double height, double width,
    String selectedUserName) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<Map<String, String>> listUsers = [];

    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": ""
    });
    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "1234567890",
      "onTime": "",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "1234567890",
      "onTime": "",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listUsers.add({
      "name": "RONAK PATEL",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            373.58,
            Stack(
              children: [
                DialogTitle(20.57, 15.59, "LOGS", 12.0, "Roboto"),
                DialogCloseButton(15, 12, () {
                  Navigator.pop(context);
                }),
                DialogButton(
                    selectedUserName, optionsNextButtonLeftMargin, optionsListTopMargin, optionsNextButtonWidth, optionsNextButtonHeight, 7, () {}),
                Positioned(
                    left: getX(width, 30),
                    top: getY(height, 80.29),
                    child: Text(
                      "DEVICES",
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: getAdaptiveTextSize(context, 10),
                          decoration: TextDecoration.none),
                    )),
                Positioned(
                    left: getX(width, 125.44),
                    top: getY(height, 80.29),
                    child: Text(
                      "DATE\nON TIME",
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: getAdaptiveTextSize(context, 9),
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    )),
                Positioned(
                    left: getX(width, 210.12),
                    top: getY(height, 80.29),
                    child: Text("DATE\nOFF TIME",
                        style: TextStyle(
                            color: textColor,
                            fontFamily: "Roboto",
                            fontSize: getAdaptiveTextSize(context, 9),
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center)),
                Positioned(
                  left: getX(width, 41.39),
                  top: getY(height, 100.8),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned.fill(
                    top: getY(height, 122.67),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(height, dialogListHeight + 12),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: listUsers.length,
                              itemBuilder: (context, position) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        DialogListButton(
                                            listUsers[position]['name']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            8,
                                                () {}),
                                        DialogListButton(
                                            listUsers[position]['onTime']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            5,
                                                () {}),
                                        DialogListButton(
                                            listUsers[position]['offTime']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            5,
                                                () {}),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(height, 8),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: getHeight(height, 8),
                        ),
                      ],
                    )),
                Positioned(
                  left: getX(width, 41.49),
                  top: getY(height, 420),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  });

}

void logsScenesDateTimeDialog(BuildContext context, double height, double width,
    String selectedSceneName) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<Map<String, String>> listScenes = [];

    listScenes.add({
      "name": "SCENE 1",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 2",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": ""
    });
    listScenes.add({
      "name": "SCENE 3",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 4",
      "onTime": "",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 5",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 6",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 7",
      "onTime": "",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 8",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listScenes.add({
      "name": "SCENE 9",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            373.58,
            Stack(
              children: [
                DialogTitle(20.57, 15.59, "LOGS", 12.0, "Roboto"),
                DialogCloseButton(15, 15, () {
                  Navigator.pop(context);
                }),
                DialogButton(
                    selectedSceneName, optionsNextButtonLeftMargin, optionsListTopMargin, optionsNextButtonWidth, optionsNextButtonHeight, optionsButtonTextSize, () {}),
                Positioned(
                    left: getX(width, 60.33),
                    top: getY(height, 78.63),
                    child: Text(
                      "DEVICES",
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: getAdaptiveTextSize(context, 10),
                          decoration: TextDecoration.none),
                    )),
                Positioned(
                    left: getX(width, 182.67),
                    top: getY(height, 78.63),
                    child: Text(
                      "DATE\nON TIME",
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: getAdaptiveTextSize(context, 9),
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    )),
                Positioned(
                  left: getX(width, 75.09),
                  top: getY(height, 100.8),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned.fill(
                    top: getY(height, 122.67),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(height, dialogListHeight + 12),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: listScenes.length,
                              itemBuilder: (context, position) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        DialogListButton(
                                            listScenes[position]['name']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            8,
                                                () {}),
                                        DialogListButton(
                                            listScenes[position]['onTime']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            5,
                                                () {}),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(height, 8),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: getHeight(height, 8),
                        ),
                      ],
                    )),
                Positioned(
                  left: getX(width, 75),
                  top: getY(height, 420),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  });

}

void logsPairedDevicesDateTimeDialog(BuildContext context, double height,
    double width, String selectedPairedDeviceName) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<Map<String, String>> listPairedDevices = [];

    listPairedDevices.add({
      "name": "L1",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listPairedDevices.add(
        {"name": "L2", "onTime": "10/10/2020\n08:21 AM", "offTime": ""});
    listPairedDevices.add({
      "name": "L3",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listPairedDevices.add(
        {"name": "L4", "onTime": "", "offTime": "10/10/2020\n08:21 AM"});
    listPairedDevices.add({
      "name": "L5",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listPairedDevices.add({
      "name": "L6",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listPairedDevices.add(
        {"name": "L7", "onTime": "", "offTime": "10/10/2020\n08:21 AM"});
    listPairedDevices.add({
      "name": "L8",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });
    listPairedDevices.add({
      "name": "L9",
      "onTime": "10/10/2020\n08:21 AM",
      "offTime": "10/10/2020\n08:21 AM"
    });

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            373.58,
            Stack(
              children: [
                DialogTitle(20.57, 15.59, "LOGS", 12.0, "Roboto"),
                DialogCloseButton(15, 12, () {
                  Navigator.pop(context);
                }),
                DialogButton(selectedPairedDeviceName, optionsNextButtonLeftMargin, optionsListTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight, 10, () {}),
                Positioned(
                    left: getX(width, 30),
                    top: getY(height, 80.29),
                    child: Text(
                      "DEVICES",
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: getAdaptiveTextSize(context, 10),
                          decoration: TextDecoration.none),
                    )),
                Positioned(
                    left: getX(width, 125.44),
                    top: getY(height, 80.29),
                    child: Text(
                      "DATE\nON TIME",
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: getAdaptiveTextSize(context, 9),
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    )),
                Positioned(
                    left: getX(width, 210.12),
                    top: getY(height, 80.29),
                    child: Text("DATE\nOFF TIME",
                        style: TextStyle(
                            color: textColor,
                            fontFamily: "Roboto",
                            fontSize: getAdaptiveTextSize(context, 9),
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center)),
                Positioned(
                  left: getX(width, 41.39),
                  top: getY(height, 100.8),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned.fill(
                    top: getY(height, 120.13),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(height, dialogListHeight + 12),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: listPairedDevices.length,
                              itemBuilder: (context, position) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        DialogListButton(
                                            listPairedDevices[position]
                                            ['name']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            8,
                                                () {}),
                                        DialogListButton(
                                            listPairedDevices[position]
                                            ['onTime']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            5,
                                                () {}),
                                        DialogListButton(
                                            listPairedDevices[position]
                                            ['offTime']!,
                                            optionsNextButtonWidth,
                                            optionsNextButtonHeight,
                                            5,
                                                () {}),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(height, 8),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: getHeight(height, 8),
                        ),
                      ],
                    )),
                Positioned(
                  left: getX(width, 41.39),
                  top: getY(height, 420),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  });

}

// void logsPairedDeviceDialog(BuildContext context, double height, double width) {
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
//               263.66,
//               356.99,
//               Stack(
//                 children: [
//                   DialogTitle(20.57, 21.23, "LOGS", 12.0, "Roboto"),
//                   DialogCloseButton(15, 18, () {
//                     Navigator.pop(context);
//                   }),
//                   DialogButton("SCENE", 33.18, 58.08, 83.28, 27.56, 7, () {}),
//                   DialogButton(
//                       "PAIRED DEVICE", 140.01, 58.08, 83.28, 27.56, 7, () {}),
//                   Positioned.fill(
//                     top: getY(height, 108.28),
//                     child: ListView(
//                       padding: EdgeInsets.zero,
//                       children: [
//                         DialogCenterButton("SCENE 1", 83.28, 27.56, 7, () {}),
//                         SizedBox(
//                           height: getY(height, 16.35),
//                         ),
//                         DialogCenterButton("SCENE 2", 83.28, 27.56, 7, () {}),
//                         SizedBox(
//                           height: getY(height, 16.35),
//                         ),
//                         DialogCenterButton("SCENE 3", 83.28, 27.56, 7, () {}),
//                         SizedBox(
//                           height: getY(height, 16.35),
//                         ),
//                         DialogCenterButton("SCENE 4", 83.28, 27.56, 7, () {}),
//                         SizedBox(
//                           height: getY(height, 16.35),
//                         ),
//                       ],
//                     ),
//                   ),
//                   DialogButton("DONE", 104, 293.66, 55.07, 30.19, 7, () {
//                     logsPairedDevicesDateTimeDialog(context, height, width);
//                   }),
//                 ],
//               )),
//         );
//       });
// }
//
// void logsPairedDeviceDialog1(BuildContext context, double height, double width){
//   showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black45,
//       transitionDuration: const Duration(milliseconds: 200),
//       pageBuilder: (BuildContext buildContext, Animation animation,
//           Animation secondaryAnimation) {
//
//         final FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: 1);
//         int selectedValue = 2;
//
//         return StatefulBuilder(
//             builder: (BuildContext context, void Function(void Function()) setState) {
//               return Center(
//                 child: CustomDialog(
//                     263.66,
//                     373.58,
//                     Stack(
//                       children: [
//                         DialogTitle(20.57, 15.59, "LOGS", 12.0, "Roboto"),
//                         DialogCloseButton(15, 12, () {
//                           Navigator.pop(context);
//                         }),
//                         DialogButton(
//                             "SCENE", 36.83, 40.84, 78.3,25.55,7,(){
//
//                         }
//                         ),
//                         DialogButton(
//                             "PAIRED DEVICE", 145.32, 40.84, 78.3,25.55,7,(){
//
//                         }
//                         ),
//                         Positioned(
//                           left: getX(width, 123),
//                           top: getY(height, 72.33),
//                           child: GestureDetector(
//                             child: const Icon(
//                               Icons.arrow_drop_down,
//                               size: 20,
//                               color: Color(0xffD9DADB),
//                             ),
//                           ),
//                         ),
//                         Positioned.fill(
//                             left: getX(width, 66.69),
//                             right: getX(width, 66.69),
//                             top: getY(height, 88.31),
//                             child: ListView(
//                               padding: EdgeInsets.zero,
//                               children: [
//                                 SizedBox(
//                                   height: getHeight(height, 228),
//                                   child: ListView(
//                                     padding: EdgeInsets.zero,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           DialogListButton(
//                                               "L1", 49.1, 35.17, 8,() {}),
//                                           DialogListButton(
//                                               "L2", 49.1, 35.17, 8,() {}),
//                                         ],
//                                       ),
//
//                                       SizedBox(
//                                         height: getHeight(height, 10),
//                                       ),
//
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           DialogListButton(
//                                               "L1", 49.1, 35.17, 8,() {}),
//                                           DialogListButton(
//                                               "L2", 49.1, 35.17, 8,() {}),
//                                         ],
//                                       ),
//
//                                       SizedBox(
//                                         height: getHeight(height, 10),
//                                       ),
//
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           DialogListButton(
//                                               "L1", 49.1, 35.17, 8,() {}),
//                                           DialogListButton(
//                                               "L2", 49.1, 35.17, 8,() {}),
//                                         ],
//                                       ),
//
//                                       SizedBox(
//                                         height: getHeight(height, 10),
//                                       ),
//
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           DialogListButton(
//                                               "CLOSE", 49.1, 35.17, 8,() {}),
//                                           DialogListButton(
//                                               "OPEN", 49.1, 35.17, 8,() {}),
//                                         ],
//                                       ),
//
//                                       SizedBox(
//                                         height: getHeight(height, 20),
//                                       ),
//
//                                       Stack(
//                                         alignment: Alignment.topCenter,
//                                         children: [
//                                           Image.asset('assets/images/fanbutton.png',
//                                               height: getHeight(height, 25.55),
//                                               width: getWidth(width, 109.82),
//                                               fit: BoxFit.fill),
//                                           Positioned.fill(
//                                               left: 10,
//                                               right: 10,
//                                               child: RotatedBox(
//                                                   quarterTurns: -1,
//                                                   child: ListWheelScrollView(
//                                                     magnification: 2.0,
//                                                     onSelectedItemChanged: (x) {
//                                                       setState(() {
//                                                         selectedValue = x;
//                                                       });
//                                                     },
//                                                     controller: scrollController,
//                                                     itemExtent: 20,
//                                                     children: List.generate(
//                                                         7,
//                                                             (x) => RotatedBox(
//                                                             quarterTurns: 1,
//                                                             child: Container(
//                                                               margin:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   top: 5,
//                                                                   bottom: 5),
//                                                               child:
//                                                               AnimatedContainer(
//                                                                   decoration: x ==
//                                                                       selectedValue
//                                                                       ? const BoxDecoration(
//                                                                       image: DecorationImage(
//                                                                           image: AssetImage(
//                                                                               'assets/images/fanbackground.png'),
//                                                                           fit: BoxFit
//                                                                               .cover,
//                                                                           scale:
//                                                                           1))
//                                                                       : const BoxDecoration(),
//                                                                   duration: const Duration(
//                                                                       milliseconds:
//                                                                       400),
//                                                                   width:
//                                                                   x == selectedValue
//                                                                       ? 60
//                                                                       : 50,
//                                                                   height:
//                                                                   x == selectedValue
//                                                                       ? 60
//                                                                       : 50,
//                                                                   alignment:
//                                                                   Alignment
//                                                                       .center,
//                                                                   child: DefaultTextStyle(
//                                                                     style: const TextStyle(),
//                                                                     child: Text(
//                                                                       (x + 1)
//                                                                           .toString(),
//                                                                       style: TextStyle(
//                                                                           color: Colors
//                                                                               .white,
//                                                                           fontSize: x ==
//                                                                               selectedValue
//                                                                               ? 12
//                                                                               : 8),
//                                                                     ),
//                                                                   )),
//                                                             ))),
//                                                   ))),
//                                         ],
//                                       )
//
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: getHeight(height, 8),
//                                 ),
//                               ],
//                             )),
//                         Positioned(
//                           left: getX(width, 123),
//                           top: getY(height, 312.85),
//                           child: GestureDetector(
//                             child: const Icon(
//                               Icons.arrow_drop_up,
//                               size: 20,
//                               color: Color(0xffD9DADB),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: getX(width, 107),
//                           top: getY(height, 333.43),
//                           child: DialogCenterButton("NEXT", 49.1, 25.55, 8, () {
//                             logsPairedDevicesDateTimeDialog(context, height, width);
//                           }),
//                         ),
//                       ],
//                     )),
//               );}
//         );
//       });
// }
