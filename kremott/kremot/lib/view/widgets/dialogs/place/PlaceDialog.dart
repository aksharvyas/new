import 'package:flutter/material.dart';
import 'package:kremot/data/remote/response/ApiResponse.dart';
import 'package:kremot/data/remote/response/ApiStatus.dart';
import 'package:kremot/models/DeleteMultipleRoomsModel.dart';
import 'package:kremot/models/DeletePlaceModel.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import 'package:kremot/models/RenamePlaceModel.dart';
import 'package:kremot/models/RenameRoomModel.dart';
import 'package:kremot/models/RoomsModel.dart';
import 'package:kremot/models/SceneItem.dart';
import 'package:kremot/view_model/DeleteMultipleRoomsVM.dart';
import 'package:kremot/view_model/DeletePlaceVM.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:kremot/view_model/RenamePlaceVM.dart';
import 'package:kremot/view_model/RenameRoomVM.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../res/AppColors.dart';
import '../../../../res/AppDimensions.dart';
import '../../../../res/AppStyles.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/Utils.dart';
import '../../../../view_model/RoomsVM.dart';
import '../../CustomAlertDialog.dart';
import '../../CustomDialog.dart';
import '../../DialogAlertText.dart';
import '../../DialogButton.dart';
import '../../DialogCenterButton.dart';
import '../../DialogCloseButton.dart';
import '../../DialogListButton.dart';
import '../../DialogNote.dart';
import '../../DialogTextfield.dart';
import '../../DialogTitle.dart';
import 'PlacesLayout.dart';
import '../../widget.dart';
import 'RoomsLayout.dart';

List<Widget> itemsRoom = [];

var roomList = [
  // SceneItem('ROOM 1', "assets/images/menuitem.png"),
  // SceneItem('ROOM 2', "assets/images/menuitem.png"),
  // SceneItem('ROOM 3', "assets/images/menuitem.png"),
  // SceneItem('ROOM 4', "assets/images/menuitem.png"),
  // SceneItem('ROOM 5', "assets/images/menuitem.png"),
  // SceneItem('ROOM 6', "assets/images/menuitem.png"),
  // SceneItem('ROOM 7', "assets/images/menuitem.png"),
  // SceneItem('ROOM 8', "assets/images/menuitem.png"),
];

AutoScrollController controllerPlace = AutoScrollController();
AutoScrollController controllerRoom = AutoScrollController();

void createDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Center(
            child: CustomDialog(
              268.61,
              236.27,
              Stack(
                children: [
                  DialogTitle(122, 11, "PLACE", 12.0, "Roboto",),
                  DialogCloseButton(15, 27, () {
                    Navigator.pop(context);
                  }),
                  DialogButton(
                      "RENAME",
                      optionsNextButtonLeftMargin,
                      optionsListTopMargin1,
                      optionsButtonWidth,
                      optionsButtonHeight,
                      optionsButtonTextSize,
                          () {
                        Navigator.pop(context);
                        renameDeleteSelectPlaceRoomDialog(context, height, width, "RENAME");
                      }),
                  DialogButton(
                      "DELETE",
                      optionsNextButtonLeftMargin,
                      optionsButtonTopMargin + optionsButtonHeight + optionsListTopMargin1,
                      optionsButtonWidth,
                      optionsButtonHeight,
                      optionsButtonTextSize,
                          () {
                        Navigator.pop(context);
                        renameDeleteSelectPlaceRoomDialog(
                            context, height, width, "DELETE");
                      }),
                ],
              ),
            ),
          );
        }
    );
  });
}

void renameDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Center(
            child: CustomDialog(
              268.61,
              236.27,
              Stack(
                children: [
                  DialogTitle(122, 11, "RENAME", 12.0, "Roboto",),
                  DialogCloseButton(15, 27, () {
                    Navigator.pop(context);
                  }),
                  DialogButton(
                      "RENAME",
                      optionsNextButtonLeftMargin,
                      optionsListTopMargin1,
                      optionsButtonWidth,
                      optionsButtonHeight,
                      optionsButtonTextSize,
                          () {

                      }),
                  Positioned(
                      left: getX(width, 44.62),
                      top: getY(height, 133.52),
                      child: Container(
                          height: getHeight(height, 120),
                          width: getWidth(width, 180),
                          padding: EdgeInsets.fromLTRB(
                              getWidth(width, 5),
                              getHeight(height, 3),
                              getWidth(width, 5),
                              getHeight(height, 3)),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5.86390495300293)),
                              border: Border.all(
                                  color: const Color(0xffeceded),
                                  width: 0.3380129933357239),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x40000000),
                                    offset: Offset(
                                        1.6900649070739746,
                                        1.6900649070739746),
                                    blurRadius: 2.028078079223633,
                                    spreadRadius: 0)
                              ],
                              image: const DecorationImage(
                                image: AssetImage(alertDialogBg),
                                fit: BoxFit.fill,
                              )
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text("NOTE:",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: getAdaptiveTextSize(
                                          context, 8),
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.left),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "1. RENAME CAN BE WITH MAXIMUM 10 CHARACTERS IN ONE LINE MAXIMUM"
                                        "2 LINE(TOTAL 10 X 2 = 20 CHARACTERS)",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                        fontSize:
                                        getAdaptiveTextSize(context, 8)),
                                    textAlign: TextAlign.left),
                              ),
                              SizedBox(
                                height: getHeight(height, 5),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "2. ONLY RENAME OF KEYS BY LONG PRESS KEYS FROM INDIVIDUAL KEYS ON HOME PAGE",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: getAdaptiveTextSize(
                                          context, 8),
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.left),
                              ),
                              SizedBox(
                                height: getHeight(height, 5),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "3. SHARED PERSON CANNOT EDIT NAME ",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        decoration: TextDecoration.none,
                                        fontSize:
                                        getAdaptiveTextSize(context, 8)),
                                    textAlign: TextAlign.left),
                              )
                            ],
                          ))),
                ],
              ),
            ),
          );
        }
    );
  });
}

Future<void> deletePlace(BuildContext context, String placeId) async {
  DeletePlaceVM deletePlaceVM = DeletePlaceVM();

  RequestDeletePlace requestDeletePlace = RequestDeletePlace(
    id: placeId,
    applicationId: applicationId,
    appUserId: appUserId,
    deletedBy: appUserId,
    deletedDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseDeletePlace> deletePlaceData =
      await deletePlaceVM.deletePlace(requestDeletePlace);
  if (deletePlaceData.status == ApiStatus.COMPLETED) {
    ResponseDeletePlace responseDeletePlace = deletePlaceData.data!;
    showToastFun(context, responseDeletePlace.value!.meta!.message);
    if (responseDeletePlace.value!.meta!.code == 1) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }
}

Future<void> deleteMultipleRooms(
    BuildContext context, List<String> listSelectedRoomIds) async {
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
    deleteBy: appUserId,
    ids: listRoomIds,
  );

  ApiResponse<ResponseDeleteMultipleRooms> deleteMultipleRoomsData =
      await deleteMultipleRoomsVM
          .deleteMultipleRooms(requestDeleteMultipleRooms);
  if (deleteMultipleRoomsData.status == ApiStatus.COMPLETED) {
    ResponseDeleteMultipleRooms responseDeleteMultipleRooms =
        deleteMultipleRoomsData.data!;
    showToastFun(context, responseDeleteMultipleRooms.value!.meta!.message);
    if (responseDeleteMultipleRooms.value!.meta!.code == 1) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }
}

void renameDeleteSelectPlaceRoomDialog(BuildContext context, double height, double width, String type) {
  controllerPlace = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical);

  controllerRoom = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical);

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
    return StatefulBuilder(builder: (context, setState) {
      return Center(
        child: CustomDialog(
          264.61,
          358.28,
          Stack(
            children: [
              DialogTitle(33.63, 20.98, type, 12.0, "Roboto"),
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
                  type == "DELETE" ? true : false, false, (rooms) {
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
                              return DialogCenterButton(type, optionsNextButtonWidth,
                                  optionsNextButtonHeight,
                                  optionsNextButtonTextSize, (selected) {
                                    List<String> listSelectedRoomIds = [];
                                    for (var getRoom in listSelectedRooms) {
                                      listSelectedRoomIds.add(getRoom.roomId!);
                                    }

                                    if (listSelectedRooms.isNotEmpty) {
                                      alertRenameDeleteDialog(context, height, width, type, "", listSelectedRoomIds);
                                    } else if (selectedPlace != null) {
                                      alertRenameDeleteDialog(context, height, width, type, selectedPlace!.homeId ?? "", listSelectedRoomIds);
                                    } else {
                                      showToastFun(context, "Please select place or room");
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
              DialogNote(23, 439, type == "DELETE" ? "NOTE: SELECT 1 PLACE & MULTIPLE ROOM AT A TIME" : "NOTE: SELECT 1 PLACE & ROOM AT A TIME"),
            ],
          ),
        ),
      );
    });
  });
}

void alertRenameDeleteDialog(BuildContext context, double height, double width,
    String type, String selectedPlaceId, List<String> listSelectedRoomsIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        189.33,
        129.78,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(5, 20, listSelectedRoomsIds.isNotEmpty
                ? "ARE YOU SURE YOU WANT TO\n$type ROOM?"
                : "ARE YOU SURE YOU WANT TO\n$type PLACE?"),
            Positioned.fill(
                top: getY(height, optionsListTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      if (type == "DELETE") {
                        if (listSelectedRoomsIds.isNotEmpty) {
                          deleteMultipleRooms(
                              context, listSelectedRoomsIds);
                        } else if (selectedPlaceId != "") {
                          deletePlace(context, selectedPlaceId);
                        }
                      } else if (type == "RENAME") {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        if (listSelectedRoomsIds.isNotEmpty) {
                          renamePlaceRoomDialog(context, height, width,
                              "Room", "", listSelectedRoomsIds);
                        } else if (selectedPlaceId != "") {
                          renamePlaceRoomDialog(
                              context,
                              height,
                              width,
                              "Place",
                              selectedPlaceId,
                              listSelectedRoomsIds);
                        }
                      }
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

void renamePlaceRoomDialog(BuildContext context, double height, double width,
    String type, String selectedPlaceId, List<String> listSelectedRoomIds) {

  Utils.showDialog(context, (buildContext, animation, secondaryAnimation) {
    final GlobalKey<FormState> formkey = GlobalKey();
    TextEditingController controller = TextEditingController();

    return Center(
      child: CustomDialog(
        263.66,
        356.99,
        Form(
          key: formkey,
          child: Stack(
            children: [
              DialogTitle(20.57, 31.85, "RENAME", 12.0, "Roboto"),
              DialogCloseButton(15, 27, () {
                Navigator.pop(context);
              }),
              DialogTextField(
                66.02,
                112.8,
                138.02,
                28.86,
                hintText: "Enter $type Name",
                hintStyle: hintTextStyle(context),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "$type Name is required";
                  }
                },
                controller: controller,
              ),
              DialogButton("Done", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize, () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.validate();
                  if (type == "Place") {
                    renamePlace(buildContext, selectedPlaceId,
                        controller.text, width, height);
                  } else if (type == "Room") {
                    renameRoom(
                        buildContext,
                        listSelectedRoomIds[listSelectedRoomIds.length - 1],
                        controller.text,
                        width,
                        height);
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  });
}

Future<void> renamePlace(BuildContext context, String placeId,
    String placeNewName, double width, double height) async {
  RenamePlaceVM renamePlaceVM = RenamePlaceVM();

  RequestRenamePlace requestRenamePlace = RequestRenamePlace(
    id: placeId,
    applicationId: applicationId,
    name: placeNewName,
    appUserId: appUserId,
    updatedBy: appUserId,
    updatedDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseRenamePlace> renamePlaceData =
      await renamePlaceVM.renamePlace(requestRenamePlace);
  if (renamePlaceData.status == ApiStatus.COMPLETED) {
    ResponseRenamePlace responseRenamePlace = renamePlaceData.data!;
    showToastFun(context, responseRenamePlace.value!.meta!.message);
    if (responseRenamePlace.value!.meta!.code == 1) {
      Navigator.of(context).pop();
      renameDeleteSelectPlaceRoomDialog(context, height, width, "RENAME");
    } else {
      Navigator.of(context).pop();
    }
  }
}

Future<void> renameRoom(BuildContext context, String roomId, String roomNewName,
    double width, double height) async {
  RenameRoomVM renameRoomVM = RenameRoomVM();

  RequestRenameRoom requestRenameRoom = RequestRenameRoom(
    id: roomId,
    applicationId: applicationId,
    room: roomNewName,
    appUserId: appUserId,
    updatedBy: appUserId,
    updatedDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
  );

  ApiResponse<ResponseRenameRoom> renameRoomData =
      await renameRoomVM.renameRoom(requestRenameRoom);
  if (renameRoomData.status == ApiStatus.COMPLETED) {
    ResponseRenameRoom responseRenameRoom = renameRoomData.data!;
    showToastFun(context, responseRenameRoom.value!.meta!.message);
    if (responseRenameRoom.value!.meta!.code == 1) {
      Navigator.of(context).pop();
      renameDeleteSelectPlaceRoomDialog(context, height, width, "RENAME");
    } else {
      Navigator.of(context).pop();
    }
  }
}
