import 'package:flutter/material.dart';
import 'package:kremot/models/AdditionalAdminsModel.dart';
import 'package:kremot/models/DeleteMultipleDevicesModel.dart';
import 'package:kremot/models/DevicesWithGroupModel.dart';
import 'package:kremot/models/GuestUsersModel.dart';
import 'package:kremot/models/PlacesWithAdditionalAdminPermissionsModel.dart';
import 'package:kremot/models/PlacesWithGuestPermissionsModel.dart';
import 'package:kremot/models/RoutinesModel.dart';
import 'package:kremot/models/SchedulesModel.dart';
import 'package:kremot/view/widgets/CustomAlertDialog.dart';
import 'package:kremot/view/widgets/DialogButton.dart';
import 'package:kremot/view/widgets/DialogCheckBox.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsLayout.dart';
import 'package:kremot/view_model/AdditionalAdminsVM.dart';
import 'package:kremot/view_model/DeleteMultipleAdditionalAdminsVM.dart';
import 'package:kremot/view_model/DeleteMultipleDevicesVM.dart';
import 'package:kremot/view_model/DevicesWithGroupVM.dart';
import 'package:kremot/view_model/GuestUsersVM.dart';
import 'package:kremot/view_model/PlacesWithAddionalAdminPermissionsVM.dart';
import 'package:kremot/view_model/PlacesWithGuestPermissionsVM.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:kremot/view_model/RoutinesVM.dart';
import 'package:kremot/view_model/SchedulesVM.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/DeleteMultipleAdditionalAdminsModel.dart';
import '../../../models/DeleteMultipleRoomsModel.dart';
import '../../../models/DeleteMultipleSchedulesModel.dart';
import '../../../models/DeletePlaceModel.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../models/RoomsModel.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/DeleteMultipleRoomsVM.dart';
import '../../../view_model/DeleteMultipleSchedulesVM.dart';
import '../../../view_model/DeletePlaceVM.dart';
import '../../../view_model/RoomsVM.dart';
import '../DialogAlertText.dart';
import '../DialogNote.dart';
import '../Loading.dart';
import '../CustomDialog.dart';
import '../DialogCloseButton.dart';
import '../DialogListButton.dart';
import '../DialogCenterButton.dart';
import '../DialogTitle.dart';
import '../widget.dart';
import 'place/PlacesLayout.dart';

void createDeleteDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "DEVICES",
      "SHARING",
      "ADDITIONAL ADMIN",
      "SCHEDULE",
      "ROUTINE"
    ];

    List<Map<String, dynamic>> listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      mapOption['selected'] = false;
      listMapOptions.add(mapOption);
    }

    int selectedPosition = -1;

    return StatefulBuilder(builder: (context, setState) {
      return Center(
        child: CustomDialog(
            263.66,
            375.99,
            Stack(
              children: [
                DialogTitle(20.57, 31.85, "DELETE", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, optionsListTopMargin1),
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
                      optionsNextButtonTextSize, () async {
                    PlacesWithOwnerPermissionsVM
                    placesWithOwnerPermissionsVM =
                    PlacesWithOwnerPermissionsVM();
                    Navigator.pop(context);
                    switch (selectedPosition) {
                      case 0:
                        deleteSelectPlaceRoomDialog(
                            context,
                            height,
                            width,
                            "DEVICES",
                            placesWithOwnerPermissionsVM,
                            appUserId!,
                            false, (buildContext, selectedRoomId) {
                          selectDevicesDialog(
                              buildContext, height, width, selectedRoomId);
                        });
                        break;
                      case 1:
                        selectSharedUserDialog(context, height, width);
                        break;
                      case 2:
                        selectAdditionalAdminDialog(context, height, width);
                        break;
                      case 3:
                      // deleteSelectPlaceRoomDialog(
                      //     context,
                      //     height,
                      //     width,
                      //     "SCHEDULE",
                      //     placesWithOwnerPermissionsVM,
                      //     appUserId!,
                      //     false, (buildContext, selectedRoomId) {
                      //   selectScheduleDialog(buildContext, height, width);
                      // });
                        selectScheduleDialog(context, height, width);
                        break;
                      case 4:
                        deleteSelectPlaceRoomDialog(
                            context,
                            height,
                            width,
                            "ROUTINE",
                            placesWithOwnerPermissionsVM,
                            appUserId!,
                            false, (buildContext, selectedRoomId) {
                          selectRoutineDialog(buildContext, height, width);
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

void deleteSelectPlaceRoomDialog(
    BuildContext context,
    double height,
    double width,
    String type,
    dynamic placesVM,
    String selectedUserId,
    bool selectMultipleRooms,
    Function onNextTap) {
  RoomsVM roomsVM = RoomsVM();

  if (placesVM is PlacesWithOwnerPermissionsVM) {
    RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions =
        RequestPlacesWithOwnerPermissions(
            applicationId: applicationId, appuserId: appUserId);
    placesVM.getPlacesWithOwnerPermissions(requestPlacesWithOwnerPermissions);
  } else if (placesVM is PlacesWithGuestPermissionsVM) {
    RequestPlacesWithGuestPermissions requestPlacesWithGuestPermissions =
        RequestPlacesWithGuestPermissions(
            applicationId: applicationId,
            appuserId: selectedUserId,
            permissionGivenBy: appUserId);
    placesVM.getPlacesWithGuestPermissions(requestPlacesWithGuestPermissions);
  } else if (placesVM is PlacesWithAdditionalAdminPermissionsVM) {
    RequestPlacesWithAdditionalAdminPermissions
        requestPlacesWithAdditionalAdminPermissions =
        RequestPlacesWithAdditionalAdminPermissions(
            applicationId: applicationId,
            appuserId: selectedUserId,
            permissionGivenBy: appUserId);
    placesVM.getPlacesWithAdditionalAdminPermissions(
        requestPlacesWithAdditionalAdminPermissions);
  }

  dynamic selectedPlace;
  List<dynamic> listSelectedRooms = [];

  Utils.showDialog(context, (buildContext, animation, secondaryAnimation) {
    return Center(
      child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(
                  20.57, 21.23, "SELECT PLACE & ROOM", 12.0, "Roboto"),
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
                  placesVM,
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
                  selectMultipleRooms, false, (rooms) {
                listSelectedRooms = rooms;
              }),
              Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: placesVM is PlacesWithOwnerPermissionsVM
                      ? ChangeNotifierProvider<
                      PlacesWithOwnerPermissionsVM>.value(
                    value: placesVM,
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
                                if (type == "SHARING") {
                                  List<String> listSelectedRoomIds =
                                  [];
                                  for (var room
                                  in listSelectedRooms) {
                                    listSelectedRoomIds
                                        .add(room.roomId);
                                  }
                                  onNextTap(
                                      buildContext,
                                      selectedPlace.homeId,
                                      listSelectedRoomIds);
                                } else {
                                  if (listSelectedRooms.isNotEmpty) {
                                    Navigator.pop(buildContext);
                                    if (type == "DEVICES" ||
                                        type == "SCHEDULE" ||
                                        type == "ROUTINE") {
                                      onNextTap(
                                          buildContext,
                                          listSelectedRooms[0]
                                              .roomId);
                                    } else {
                                      onNextTap(buildContext);
                                    }
                                  } else {
                                    showToastFun(buildContext,
                                        "Please select room");
                                  }
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
                      : placesVM is PlacesWithGuestPermissionsVM
                      ? ChangeNotifierProvider<
                      PlacesWithGuestPermissionsVM>.value(
                    value: placesVM,
                    child: Consumer<PlacesWithGuestPermissionsVM>(
                      builder: (context, viewModel, view) {
                        switch (viewModel
                            .placesWithGuestPermissionsData
                            .status) {
                          case ApiStatus.COMPLETED:
                            List<AppUserAccessGuestPermissions>?
                            listPlaces = viewModel
                                .placesWithGuestPermissionsData
                                .data!
                                .value!
                                .appUserAccessPermissions;

                            if (listPlaces != null &&
                                listPlaces.isNotEmpty) {
                              return DialogCenterButton(
                                  "NEXT",
                                  optionsNextButtonWidth,
                                  optionsNextButtonHeight,
                                  optionsNextButtonTextSize,
                                      (selected) {
                                    if (type == "SHARING") {
                                      List<String>
                                      listSelectedRoomIds = [];
                                      for (var room
                                      in listSelectedRooms) {
                                        listSelectedRoomIds
                                            .add(room.roomId);
                                      }
                                      onNextTap(
                                          buildContext,
                                          selectedPlace.homeId,
                                          listSelectedRoomIds);
                                    } else {
                                      if (listSelectedRooms
                                          .isNotEmpty) {
                                        Navigator.pop(buildContext);
                                        if (type == "DEVICES" ||
                                            type == "SCHEDULE" ||
                                            type == "ROUTINE") {
                                          onNextTap(
                                              buildContext,
                                              listSelectedRooms[0]
                                                  .roomId);
                                        } else {
                                          onNextTap(buildContext);
                                        }
                                      } else {
                                        showToastFun(buildContext,
                                            "Please select room");
                                      }
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
                      : Container()),
              DialogNote(
                50,
                316.63,
                "NOTE: SELECT 1 PLACE & MULTIPLE ROOM AT A TIME",
              ),
            ],
          )),
    );
  });

}

void selectDevicesDialog(
    BuildContext context, double height, double width, String selectedRoomId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    RequestDevicesWithGroup requestDevicesWithGroup =
    RequestDevicesWithGroup(
        applicationId: applicationId, roomId: selectedRoomId);

    DevicesWithGroupVM devicesWithGroupVM = DevicesWithGroupVM();
    devicesWithGroupVM.getDevicesWithGroup(requestDevicesWithGroup);

    List<int> listSelectedDevicesGroupIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            312.2,
            480.74,
            Stack(
              children: [
                DialogTitle(20.57, 28.59, "SELECT DEVICES", 12.0, "Roboto"),
                DialogCloseButton(15, 27, () {
                  Navigator.pop(context);
                }),
                Positioned(
                  left: getX(width, 33.4),
                  top: getY(height, 58.39),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned(
                  left: getX(width, 33.4),
                  top: getY(height, 415.05),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: arrowColor,
                    ),
                  ),
                ),
                Positioned.fill(
                  left: getX(width, 14.27),
                  top: getY(height, 89.29),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(height, 316),
                        child: ChangeNotifierProvider<DevicesWithGroupVM>(
                          create: (BuildContext context) =>
                          devicesWithGroupVM,
                          child: Consumer<DevicesWithGroupVM>(
                            builder: (context, viewModel, view) {
                              switch (
                              viewModel.devicesWithGroupData.status) {
                                case ApiStatus.LOADING:
                                  Utils.printMsg(
                                      "DevicesWithGroupList :: LOADING");
                                  return const Loading();
                                case ApiStatus.ERROR:
                                  Utils.printMsg(
                                      "DevicesWithGroupList :: ERROR${viewModel.devicesWithGroupData.message}");
                                  return Center(
                                      child: Text(
                                        "No Devices found!",
                                        style: apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      ));
                                case ApiStatus.COMPLETED:
                                  Utils.printMsg(
                                      "DevicesWithGroupList :: COMPLETED");

                                  List<RoomDetails>? listDevicesWithGroup =
                                      viewModel.devicesWithGroupData.data!
                                          .value!.roomDetails;

                                  if (listDevicesWithGroup == null ||
                                      listDevicesWithGroup.isEmpty) {
                                    return Center(
                                        child: Text(
                                          "No Devices found!",
                                          style: apiMessageTextStyle(context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "DevicesWithGroupList${listDevicesWithGroup.length}");

                                    return ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                        listDevicesWithGroup.length,
                                        itemBuilder:
                                            (context, groupPosition) {
                                          List<DeviceSwitches>
                                          listDeviceSwitches =
                                          listDevicesWithGroup[
                                          groupPosition]
                                              .deviceSwitches!;

                                          return Column(
                                            children: [
                                              SizedBox(
                                                height:
                                                getHeight(height, 40),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child:
                                                      ListView.builder(
                                                          padding:
                                                          EdgeInsets
                                                              .zero,
                                                          scrollDirection:
                                                          Axis
                                                              .horizontal,
                                                          itemCount:
                                                          listDeviceSwitches
                                                              .length,
                                                          itemBuilder:
                                                              (context,
                                                              position) {
                                                            return Row(
                                                              children: [
                                                                DialogListButton(
                                                                    listDeviceSwitches[position].switchDisplayName!,
                                                                    49.1,
                                                                    35.17,
                                                                    8,
                                                                        () {}),
                                                                SizedBox(
                                                                  width: getWidth(
                                                                      width,
                                                                      10.7),
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Center(
                                                          child:
                                                          DialogCheckBox(
                                                            31.85,
                                                            27.87,
                                                            listDevicesWithGroup[
                                                            groupPosition]
                                                                .isSelected,
                                                                (checked) {
                                                              setState(() {
                                                                listDevicesWithGroup[groupPosition]
                                                                    .isSelected =
                                                                    checked;
                                                                if (checked) {
                                                                  listSelectedDevicesGroupIds.add(
                                                                      listDevicesWithGroup[groupPosition]
                                                                          .id!);
                                                                } else {
                                                                  listSelectedDevicesGroupIds
                                                                      .remove(
                                                                      listDevicesWithGroup[groupPosition].id!);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getHeight(height, 7.0),
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
                      SizedBox(
                        height: getY(height, 8),
                      ),
                    ],
                  ),
                ),
                if (listSelectedDevicesGroupIds.isNotEmpty)
                  Positioned(
                    left: getX(width, 125.41),
                    top: getY(height, 416.05),
                    child: DialogCenterButton("DELETE", 56.07, 29.53, 8,
                            (selected) {
                          alertDeleteDialog(context, height, width, "DEVICES",
                              listSelectedDevicesGroupIds:
                              listSelectedDevicesGroupIds);
                        }),
                  ),
                DialogNote(
                    46, 456.52, "NOTE: SELECT MULTIPLE DEVICE AT A TIME"),
              ],
            )),
      );
    });
  });
}

void selectSharedUserDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    RequestGuestUsers requestGuestUsers = RequestGuestUsers(
        applicationId: applicationId, appuserId: appUserId);

    GuestUsersVM guestUsersVM = GuestUsersVM();
    guestUsersVM.getGuestUsers(requestGuestUsers);

    String selectedGuestUserId = "";

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(28.2, 24.88, "DELETE SHARING", 12.0, "Roboto"),
              DialogCloseButton(15, 21, () {
                Navigator.pop(context);
              }),
              Positioned(
                  left: getX(width, 45.45),
                  right: getX(width, 51.32),
                  top: getY(height, dialogListTopMargin),
                  child: SizedBox(
                    height: getHeight(height, dialogListHeight),
                    child: ChangeNotifierProvider<GuestUsersVM>(
                      create: (BuildContext context) => guestUsersVM,
                      child: Consumer<GuestUsersVM>(
                        builder: (context, viewModel, view) {
                          switch (viewModel.guestUsersData.status) {
                            case ApiStatus.LOADING:
                              Utils.printMsg("GuestUsersList :: LOADING");
                              return const Loading();
                            case ApiStatus.ERROR:
                              Utils.printMsg(
                                  "GuestUsersList :: ERROR${viewModel.guestUsersData.message}");
                              return Center(
                                  child: Text(
                                    "No Guest Users found!",
                                    style: apiMessageTextStyle(context),
                                    textAlign: TextAlign.center,
                                  ));
                            case ApiStatus.COMPLETED:
                              Utils.printMsg("GuestUsersList :: COMPLETED");

                              List<GuestAccessPermissions>? listGuestUsers =
                                  viewModel.guestUsersData.data!.value!
                                      .appUserAccessPermissions;

                              if (listGuestUsers == null ||
                                  listGuestUsers.isEmpty) {
                                return Center(
                                    child: Text(
                                      "No Guest Users found!",
                                      style: apiMessageTextStyle(context),
                                      textAlign: TextAlign.center,
                                    ));
                              } else {
                                Utils.printMsg(
                                    "GuestUsersList${listGuestUsers.length}");

                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: listGuestUsers.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              DialogListButton(
                                                  listGuestUsers[index]
                                                      .userName!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      () {}),
                                              DialogCheckBox(
                                                  31.85,
                                                  27.87,
                                                  listGuestUsers[index]
                                                      .isSelected!,
                                                      (isChecked) {
                                                    if (isChecked) {
                                                      selectedGuestUserId =
                                                      listGuestUsers[index]
                                                          .appUserID!;

                                                      setState(() {
                                                        for (int i = 0;
                                                        i <
                                                            listGuestUsers
                                                                .length;
                                                        i++) {
                                                          listGuestUsers[i]
                                                              .isSelected =
                                                          false;
                                                        }
                                                        listGuestUsers[index]
                                                            .isSelected = true;
                                                      });
                                                    } else {
                                                      selectedGuestUserId = "";

                                                      setState(() {
                                                        listGuestUsers[index]
                                                            .isSelected = false;
                                                      });
                                                    }
                                                  })
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                            getHeight(height, dialogListItemsVerticalMargin),
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
                  )),
              if (selectedGuestUserId != "")
                DialogButton(
                    "NEXT",
                    optionsNextButtonLeftMargin,
                    optionsNextButtonTopMargin,
                    optionsNextButtonWidth,
                    optionsNextButtonHeight,
                    optionsNextButtonTextSize, () {
                  if (selectedGuestUserId != "") {
                    Navigator.pop(context);

                    PlacesWithGuestPermissionsVM
                    placesWithGuestPermissionsVM =
                    PlacesWithGuestPermissionsVM();

                    deleteSelectPlaceRoomDialog(
                        context,
                        height,
                        width,
                        "SHARING",
                        placesWithGuestPermissionsVM,
                        selectedGuestUserId,
                        true, (buildContext, selectedPlaceId,
                        listSelectedRoomsIds) {
                      alertDeleteDialog(
                          buildContext, height, width, "SHARE",
                          selectedGuestUserId: selectedGuestUserId,
                          selectedPlaceId: selectedPlaceId,
                          listSelectedRoomsIds: listSelectedRoomsIds);
                    });
                  } else {
                    showToastFun(context, "Please select shared user");
                  }
                }),
              DialogNote(
                  39.48, 324.18, "NOTE: SELECT SINGLE USER AT A TIME"),
            ],
          ),
        ),
      );
    });
  });
}

void selectAdditionalAdminDialog(
    BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    RequestAdditionalAdmins requestAdditionalAdmins =
    RequestAdditionalAdmins(
        applicationId: applicationId, appuserId: appUserId);

    AdditionalAdminsVM additionalAdminsVM = AdditionalAdminsVM();
    additionalAdminsVM.getAdditionalAdmins(requestAdditionalAdmins);

    String selectedAdditionalAdminId = "";

    return StatefulBuilder(builder: (BuildContext buildContext,
        void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(
                  25, 24.88, "DELETE ADDITIONAL ADMIN", 11.0, "Roboto"),
              DialogCloseButton(15, 21, () {
                Navigator.pop(buildContext);
              }),
              Positioned(
                  left: getX(width, 45.45),
                  right: getX(width, 51.32),
                  top: getY(height, dialogListTopMargin),
                  child: SizedBox(
                    height: getHeight(height, dialogListHeight),
                    child: ChangeNotifierProvider<AdditionalAdminsVM>(
                      create: (BuildContext context) => additionalAdminsVM,
                      child: Consumer<AdditionalAdminsVM>(
                        builder: (context, viewModel, view) {
                          switch (viewModel.additionalAdminsData.status) {
                            case ApiStatus.LOADING:
                              Utils.printMsg(
                                  "AdditionalAdminsList :: LOADING");
                              return const Loading();
                            case ApiStatus.ERROR:
                              Utils.printMsg(
                                  "AdditionalAdminsList :: ERROR${viewModel.additionalAdminsData.message}");
                              return Center(
                                  child: Text(
                                    "No Additional Admins found!",
                                    style: apiMessageTextStyle(buildContext),
                                    textAlign: TextAlign.center,
                                  ));
                            case ApiStatus.COMPLETED:
                              Utils.printMsg(
                                  "AdditionalAdminsList :: COMPLETED");

                              List<AdditionalAdminAccessPermissions>?
                              listAdditionalAdmins = viewModel
                                  .additionalAdminsData
                                  .data!
                                  .value!
                                  .appUserAccessPermissions;

                              if (listAdditionalAdmins == null ||
                                  listAdditionalAdmins.isEmpty) {
                                return Center(
                                    child: Text(
                                      "No Additional Admins found!",
                                      style:
                                      apiMessageTextStyle(context),
                                      textAlign: TextAlign.center,
                                    ));
                              } else {
                                Utils.printMsg(
                                    "AdditionalAdminsList${listAdditionalAdmins.length}");

                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: listAdditionalAdmins.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              DialogListButton(
                                                  listAdditionalAdmins[
                                                  index]
                                                      .userName!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      () {}),
                                              DialogCheckBox(
                                                  31.85,
                                                  27.87,
                                                  listAdditionalAdmins[
                                                  index]
                                                      .isSelected!,
                                                      (isChecked) {
                                                    if (isChecked) {
                                                      selectedAdditionalAdminId =
                                                      listAdditionalAdmins[
                                                      index]
                                                          .appUserID!;

                                                      setState(() {
                                                        for (int i = 0;
                                                        i <
                                                            listAdditionalAdmins
                                                                .length;
                                                        i++) {
                                                          listAdditionalAdmins[
                                                          i]
                                                              .isSelected =
                                                          false;
                                                        }
                                                        listAdditionalAdmins[
                                                        index]
                                                            .isSelected = true;
                                                      });
                                                    } else {
                                                      selectedAdditionalAdminId =
                                                      "";

                                                      setState(() {
                                                        listAdditionalAdmins[
                                                        index]
                                                            .isSelected = false;
                                                      });
                                                    }
                                                  })
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                            getHeight(height, dialogListItemsVerticalMargin),
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
                  )),
              if (selectedAdditionalAdminId != "")
                DialogButton("DONE", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight, optionsNextButtonTextSize, () {
                      if (selectedAdditionalAdminId != "") {
                        List<String> listSelectedAdditionalAdminsIds = [];
                        listSelectedAdditionalAdminsIds
                            .add(selectedAdditionalAdminId);
                        alertDeleteDialog(
                            context, height, width, "ADDITIONAL ADMINS",
                            listSelectedAdditionalAdminsIds:
                            listSelectedAdditionalAdminsIds);
                      } else {
                        showToastFun(context, "Please select additional admin");
                      }
                    }),
              DialogNote(
                  39.48, 324.18, "NOTE: SELECT SINGLE USER AT A TIME")
            ],
          ),
        ),
      );
    });
  });
}

void selectScheduleDialog(BuildContext context, double height, double width) {

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

    RequestSchedules requestSchedules = RequestSchedules(applicationId: applicationId, appUserId: appUserId);

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
              DialogTitle(28.2, 24.88, "DELETE SCHEDULE", 12.0, "Roboto"),
              DialogCloseButton(15, 21, () {
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
                                      "SchedulesList :: ERROR${viewModel.schedulesData.message}");
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
                                          style: apiMessageTextStyle(context),
                                          textAlign: TextAlign.center,
                                        ));
                                  } else {
                                    Utils.printMsg(
                                        "SchedulesList${listSchedules.length}");

                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listSchedules.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              DialogCenterButton(
                                                  listSchedules[index].scheduleName!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize, (selected) {
                                                setState(() {
                                                  if (selected) {
                                                    listSelectedSchedulesIds.add(listSchedules[index].id!);
                                                    listSchedules[index].isSelected = true;
                                                  } else {
                                                    listSelectedSchedulesIds.remove(listSchedules[index].id);
                                                    listSchedules[index].isSelected = false;
                                                  }
                                                });                                                  },
                                                  tapped: true,
                                                  selected: listSchedules[index].isSelected),
                                              SizedBox(
                                                height: getHeight(height, dialogListItemsVerticalMargin),
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
                        //                 listSelectedSchedulesIds
                        //                     .add(position.toString());
                        //                 listMapOptions[position]
                        //                     ['selected'] = true;
                        //               } else {
                        //                 listSelectedSchedulesIds
                        //                     .remove(position.toString());
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
                  )),
              if (listSelectedSchedulesIds.isNotEmpty)
                DialogButton("DONE", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight, optionsNextButtonTextSize, () {
                      if (listSelectedSchedulesIds.isNotEmpty) {
                        alertDeleteDialog(context, height, width, "SCHEDULE", listSelectedSchedulesIds: listSelectedSchedulesIds);
                      } else {
                        showToastFun(context, "Please select schedule");
                      }
                    }),
              DialogNote(39.48, 324.18,
                  "NOTE: SELECT MULTIPLE SCHEDULE AT A TIME"),
            ],
          ),
        ),
      );
    });
  });
}

void selectRoutineDialog(BuildContext context, double height, double width) {

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

    List<String> listSelectedRoutinesIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(28.2, 24.88, "DELETE ROUTINE", 12.0, "Roboto"),
              DialogCloseButton(15, 21, () {
                Navigator.pop(context);
              }),
              Positioned(
                  left: getX(width, 45.45),
                  right: getX(width, 51.32),
                  top: getY(height, dialogListTopMargin),
                  child: SizedBox(
                      height: getHeight(height, dialogListHeight),
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
                      //               listRoutines = viewModel
                      //                   .routinesData
                      //                   .data!
                      //                   .value!
                      //                   .appUserAccessPermissions;
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
                      //                 itemBuilder: (context, index) {
                      //                   return Column(
                      //                     mainAxisSize: MainAxisSize.max,
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.start,
                      //                     children: [
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           DialogListButton(
                      //                               listRoutines[index].name!,
                      //                               optionsButtonWidth,
                      //                               optionsButtonHeight,
                      //                               optionsTextSize,
                      //                               () {}),
                      //                           DialogCheckBox(
                      //                               31.85,
                      //                               27.87,
                      //                               listRoutines[index].isSelected!,
                      //                               (isChecked) {
                      //                             String selectedRoutineId = listRoutines[index].appUserID!;
                      //                             if (isChecked) {
                      //                               listSelectedRoutinesIds.add(selectedRoutineId);
                      //
                      //                               setState(() {
                      //                                 listRoutines[index].isSelected = true;
                      //                               });
                      //                             } else {
                      //                               listSelectedRoutinesIds.remove(selectedRoutineId);
                      //
                      //                               setState(() {
                      //                                 listRoutines[index].isSelected = false;
                      //                               });
                      //                             }
                      //                           })
                      //                         ],
                      //                       ),
                      //                       SizedBox(
                      //                         height: getHeight(height, 17.72),
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
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    DialogListButton(
                                        listMapSmartDevices[index]['name'],
                                        optionsButtonWidth,
                                        optionsButtonHeight,
                                        optionsButtonTextSize,
                                            () {}),
                                    DialogCheckBox(
                                        31.85,
                                        27.87,
                                        listMapSmartDevices[index]
                                        ['selected'], (isChecked) {
                                      if (isChecked) {
                                        listSelectedRoutinesIds.add(
                                            listMapSmartDevices[index]
                                            ['name']);

                                        setState(() {
                                          listMapSmartDevices[index]
                                          ['selected'] = true;
                                        });
                                      } else {
                                        listSelectedRoutinesIds.remove(
                                            listMapSmartDevices[index]
                                            ['name']);

                                        setState(() {
                                          listMapSmartDevices[index]
                                          ['selected'] = false;
                                        });
                                      }
                                    })
                                  ],
                                ),
                                SizedBox(
                                  height: getHeight(height, dialogListItemsVerticalMargin),
                                ),
                              ],
                            );
                          }))),
              if (listSelectedRoutinesIds.isNotEmpty)
                DialogButton("DONE", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight, optionsNextButtonTextSize, () {
                      if (listSelectedRoutinesIds.isNotEmpty) {
                        alertDeleteDialog(context, height, width, "ROUTINE");
                      } else {
                        showToastFun(context, "Please select routine");
                      }
                    }),
              DialogNote(
                  39.48, 324.18, "NOTE: SELECT MULTIPLE ROUTINE AT A TIME"),
            ],
          ),
        ),
      );
    });
  });
}

void alertDeleteDialog(
    BuildContext context, double height, double width, String type,
    {List<int>? listSelectedDevicesGroupIds,
    String? selectedGuestUserId,
    String? selectedPlaceId,
    List<String>? listSelectedRoomsIds,
    List<String>? listSelectedAdditionalAdminsIds,
    List<int>? listSelectedSchedulesIds}) {

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
              5,
              44.24,
              "ARE YOU SURE YOU WANT\nTO DELETE $type?",
            ),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(buildContext);
                      alertDeleteDialogAgain(context, height, width, type,
                        listSelectedDevicesGroupIds: listSelectedDevicesGroupIds,
                        selectedGuestUserId: selectedGuestUserId,
                        selectedPlaceId: selectedPlaceId,
                        listSelectedRoomsIds: listSelectedRoomsIds,
                        listSelectedAdditionalAdminsIds: listSelectedAdditionalAdminsIds,
                        listSelectedSchedulesIds: listSelectedSchedulesIds,
                      );
                    }),
                    DialogListButton("NO", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(buildContext);
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  });
}

void alertDeleteDialogAgain(
    BuildContext context, double height, double width, String type,
    {List<int>? listSelectedDevicesGroupIds,
      String? selectedGuestUserId,
      String? selectedPlaceId,
      List<String>? listSelectedRoomsIds,
      List<String>? listSelectedAdditionalAdminsIds,
      List<int>? listSelectedSchedulesIds}) {

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
              5,
              44.24,
              "ARE YOU SURE YOU WANT\nTO DELETE $type?",
            ),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("NO", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(buildContext);
                    }),
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      switch (type) {
                        case "DEVICES":
                          deleteMultipleDevices(
                              context, listSelectedDevicesGroupIds!, () {
                            Navigator.pop(buildContext);
                            Navigator.pop(buildContext);
                          });
                          break;
                        case "SHARE":
                          if (listSelectedRoomsIds!.isNotEmpty) {
                            deleteMultipleRooms(
                                context,
                                listSelectedRoomsIds,
                                selectedGuestUserId!, () {
                              Navigator.pop(buildContext);
                              Navigator.pop(buildContext);
                            });
                          } else if (selectedPlaceId != "") {
                            deletePlace(context, selectedPlaceId!,
                                selectedGuestUserId!, () {
                                  Navigator.pop(buildContext);
                                  Navigator.pop(buildContext);
                                });
                          }
                          break;
                        case "ADDITIONAL ADMINS":
                          deleteMultipleAdditionalAdmins(
                              context, listSelectedAdditionalAdminsIds!, () {
                            Navigator.pop(buildContext);
                            Navigator.pop(buildContext);
                          });
                          break;
                        case "SCHEDULE":
                          deleteMultipleSchedules(
                              context, listSelectedSchedulesIds!, () {
                            Navigator.pop(buildContext);
                            Navigator.pop(buildContext);
                          });
                          break;
                        case "ROUTINE":
                          break;
                      }
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  });

}

Future<void> deleteMultipleDevices(BuildContext context,
    List<int> listSelectedDevicesGroupIds, Function onSuccess) async {
  DeleteMultipleDevicesVM deleteMultipleDevicesVM = DeleteMultipleDevicesVM();

  List<GroupIds> listSelectedDevices = [];
  for (var selectedDeviceGroupId in listSelectedDevicesGroupIds) {
    listSelectedDevices.add(GroupIds(id: selectedDeviceGroupId));
  }

  RequestDeleteMultipleDevices requestDeleteMultipleDevices =
      RequestDeleteMultipleDevices(
    applicationId: applicationId,
    deleteBy: appUserId,
    deleteDateTime: currentDateTime,
    ids: listSelectedDevices,
  );

  ApiResponse<ResponseDeleteMultipleDevices> deleteMultipleDevicesData =
      await deleteMultipleDevicesVM
          .deleteMultipleDevices(requestDeleteMultipleDevices);

  if (deleteMultipleDevicesData.status == ApiStatus.COMPLETED) {
    ResponseDeleteMultipleDevices responseDeleteMultipleDevices =
        deleteMultipleDevicesData.data!;
    if (responseDeleteMultipleDevices.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseDeleteMultipleDevices.value!.meta!.message);
  }
}

Future<void> deletePlace(BuildContext context, String placeId,
    String sharedUserId, Function onSuccess) async {
  DeletePlaceVM deletePlaceVM = DeletePlaceVM();

  RequestDeletePlace requestDeletePlace = RequestDeletePlace(
    id: placeId,
    applicationId: applicationId,
    appUserId: sharedUserId,
    deletedBy: sharedUserId,
    deletedDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseDeletePlace> deletePlaceData =
      await deletePlaceVM.deletePlace(requestDeletePlace);
  if (deletePlaceData.status == ApiStatus.COMPLETED) {
    ResponseDeletePlace responseDeletePlace = deletePlaceData.data!;
    if (responseDeletePlace.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseDeletePlace.value!.meta!.message);
  }
}

Future<void> deleteMultipleRooms(
    BuildContext context,
    List<String> listSelectedRoomIds,
    String sharedUserId,
    Function onSuccess) async {
  DeleteMultipleRoomsVM deleteMultipleRoomsVM = DeleteMultipleRoomsVM();

  List<Ids> listRoomIds = [];
  for (var getId in listSelectedRoomIds) {
    listRoomIds.add(Ids(id: getId));
  }

  RequestDeleteMultipleRooms requestDeleteMultipleRooms =
      RequestDeleteMultipleRooms(
    applicationId: applicationId,
    deleteDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
    deleteBy: sharedUserId,
    ids: listRoomIds,
  );

  ApiResponse<ResponseDeleteMultipleRooms> deleteMultipleRoomsData =
      await deleteMultipleRoomsVM
          .deleteMultipleRooms(requestDeleteMultipleRooms);
  if (deleteMultipleRoomsData.status == ApiStatus.COMPLETED) {
    ResponseDeleteMultipleRooms responseDeleteMultipleRooms =
        deleteMultipleRoomsData.data!;
    if (responseDeleteMultipleRooms.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseDeleteMultipleRooms.value!.meta!.message);
  }
}

Future<void> deleteMultipleAdditionalAdmins(BuildContext context,
    List<String> listSelectedAppUserIds, Function onSuccess) async {
  DeleteMultipleAdditionalAdminsVM deleteMultipleAdditionalAdminsVM =
      DeleteMultipleAdditionalAdminsVM();

  List<AppUser> listSelectedAppUsers = [];
  for (var selectedAppUserId in listSelectedAppUserIds) {
    listSelectedAppUsers.add(AppUser(appUserId: selectedAppUserId));
  }

  RequestDeleteMultipleAdditionalAdmins requestDeleteMultipleAdditionalAdmins =
      RequestDeleteMultipleAdditionalAdmins(
    applicationId: applicationId,
    deletedDateTime: currentDateTime,
    deletedBy: appUserId,
    appUser: listSelectedAppUsers,
  );

  ApiResponse<ResponseDeleteMultipleAdditionalAdmins>
      deleteMultipleAdditionalAdminsData =
      await deleteMultipleAdditionalAdminsVM.deleteMultipleAdditionalAdmins(
          requestDeleteMultipleAdditionalAdmins);

  if (deleteMultipleAdditionalAdminsData.status == ApiStatus.COMPLETED) {
    ResponseDeleteMultipleAdditionalAdmins
        responseDeleteMultipleAdditionalAdmins =
        deleteMultipleAdditionalAdminsData.data!;
    if (responseDeleteMultipleAdditionalAdmins.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(
        context, responseDeleteMultipleAdditionalAdmins.value!.meta!.message);
  }
}

Future<void> deleteMultipleSchedules(BuildContext context, List<int> listSelectedScheduleIds, Function onSuccess) async {
  DeleteMultipleSchedulesVM deleteMultipleSchedulesVM = DeleteMultipleSchedulesVM();

  List<DeleteScheduleIds> listScheduleIds = [];
  for(int id in listSelectedScheduleIds){
    listScheduleIds.add(DeleteScheduleIds(id: id));
  }

  RequestDeleteMultipleSchedules requestDeleteMultipleSchedules = RequestDeleteMultipleSchedules(
    applicationId: applicationId,
    ids: listScheduleIds,
    deletedBy: appUserId,
    deletedDateTime:
    DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseDeleteMultipleSchedules> deleteMultipleSchedulesData = await deleteMultipleSchedulesVM.deleteMultipleSchedules(requestDeleteMultipleSchedules);
  if (deleteMultipleSchedulesData.status == ApiStatus.COMPLETED) {
    ResponseDeleteMultipleSchedules responseDeleteMultipleSchedules = deleteMultipleSchedulesData.data!;
    if (responseDeleteMultipleSchedules.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseDeleteMultipleSchedules.value!.meta!.message);
  }
}
