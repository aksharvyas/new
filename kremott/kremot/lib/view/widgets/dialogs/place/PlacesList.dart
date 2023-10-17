import 'package:flutter/material.dart';
import 'package:kremot/models/PlacesWithAdditionalAdminPermissionsModel.dart';
import 'package:kremot/models/PlacesWithGuestPermissionsModel.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import 'package:kremot/view/widgets/dialogs/place/PlacesListView.dart';
import 'package:kremot/view_model/PlacesWithAddionalAdminPermissionsVM.dart';
import 'package:kremot/view_model/PlacesWithGuestPermissionsVM.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:provider/provider.dart';

import '../../../../data/remote/response/ApiStatus.dart';
import '../../../../models/PlacesModel.dart';
import '../../../../models/RoomsModel.dart';
import '../../../../res/AppStyles.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/Utils.dart';
import '../../../../view_model/PlacesVM.dart';
import '../../../../view_model/RoomsVM.dart';
import '../../Loading.dart';

class PlacesList extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double buttonWidth;
  double buttonHeight;
  dynamic placesVM;
  RoomsVM roomsVM;
  Function selectedPlaceCallback;

  PlacesList(this.screenWidth, this.screenHeight, this.buttonWidth, this.buttonHeight, this.placesVM, this.roomsVM, this.selectedPlaceCallback, {Key? key}) : super(key: key);

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {

  selectedPlaceCallback(placeSelected){
    widget.selectedPlaceCallback(placeSelected);
  }

  @override
  Widget build(BuildContext context) {

    return widget.placesVM is PlacesWithOwnerPermissionsVM ? ChangeNotifierProvider<PlacesWithOwnerPermissionsVM>(
      create: (BuildContext context) => widget.placesVM,
      child: Consumer<PlacesWithOwnerPermissionsVM>(
        builder: (context, viewModel, view) {
          switch (viewModel.placesWithOwnerPermissionsData.status) {
            case ApiStatus.LOADING:
              Utils.printMsg("PlacesWithOwnerPermissionsList :: LOADING");
              return const Loading();
            case ApiStatus.ERROR:
              Utils.printMsg(
                  "PlacesWithOwnerPermissionsList :: ERROR${viewModel.placesWithOwnerPermissionsData.message}");
              return Center(
                  child: Text(
                    "No Places found!",
                    style: apiMessageTextStyle(context),
                    textAlign: TextAlign.center,
                  ));
            case ApiStatus.COMPLETED:
              Utils.printMsg(
                  "PlacesWithOwnerPermissionsList :: COMPLETED");

              List<AppUserAccessOwnerPermissions>?
              listPlaces = viewModel
                  .placesWithOwnerPermissionsData
                  .data!
                  .value!
                  .appUserAccessPermissions;

              if (listPlaces == null ||
                  listPlaces.isEmpty) {
                return Center(
                    child: Text(
                      "No Places found!",
                      style: apiMessageTextStyle(context),
                      textAlign: TextAlign.center,
                    ));
              } else {
                Utils.printMsg(
                    "PlacesWithOwnerPermissionsList${listPlaces.length}");

                Future.delayed(Duration.zero,
                        () async {
                      RequestRooms requestRooms =
                      RequestRooms(
                        applicationId: applicationId,
                        appuserId: appUserId,
                        homeId: listPlaces[0].homeId!
                        // homeId:
                        // "0DE75DB7-7651-4306-B1DA-904874793930",
                      );
                      widget.roomsVM.getAllRooms(requestRooms);
                    });

                if(listPlaces.isNotEmpty){
                  listPlaces[0].isSelected = true;
                  widget.selectedPlaceCallback(listPlaces[0]);
                }

                return PlacesListView(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, widget.roomsVM, listPlaces, selectedPlaceCallback);
              }
            default:
          }
          return const Loading();
        },
      ),
    ) : widget.placesVM is PlacesWithGuestPermissionsVM ? ChangeNotifierProvider<PlacesWithGuestPermissionsVM>(
      create: (BuildContext context) => widget.placesVM,
      child: Consumer<PlacesWithGuestPermissionsVM>(
        builder: (context, viewModel, view) {
          switch (viewModel.placesWithGuestPermissionsData.status) {
            case ApiStatus.LOADING:
              Utils.printMsg("PlacesWithGuestPermissionsList :: LOADING");
              return const Loading();
            case ApiStatus.ERROR:
              Utils.printMsg(
                  "PlacesList :: ERROR${viewModel.placesWithGuestPermissionsData.message}");
              return Center(
                  child: Text(
                    "No Places found!",
                    style: apiMessageTextStyle(context),
                    textAlign: TextAlign.center,
                  ));
            case ApiStatus.COMPLETED:
              Utils.printMsg(
                  "PlacesWithGuestPermissionsList :: COMPLETED");

              List<AppUserAccessGuestPermissions>?
              listPlaces = viewModel
                  .placesWithGuestPermissionsData
                  .data!
                  .value!
                  .appUserAccessPermissions;

              if (listPlaces == null ||
                  listPlaces.isEmpty) {
                return Center(
                    child: Text(
                      "No Places found!",
                      style: apiMessageTextStyle(context),
                      textAlign: TextAlign.center,
                    ));
              } else {
                Utils.printMsg("PlacesWithGuestPermissionsList${listPlaces.length}");

                Future.delayed(Duration.zero,
                        () async {
                      RequestRooms requestRooms =
                      RequestRooms(
                          applicationId: applicationId,
                          appuserId: appUserId,
                          homeId: listPlaces[0].homeId!
                      );
                      widget.roomsVM.getAllRooms(requestRooms);
                    });

                if(listPlaces.isNotEmpty){
                  listPlaces[0].isSelected = true;
                  widget.selectedPlaceCallback(listPlaces[0]);
                }

                return PlacesListView(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, widget.roomsVM, listPlaces, selectedPlaceCallback);
              }
            default:
          }
          return Center(
              child: Text(
                "No Places found!",
                style: apiMessageTextStyle(context),
                textAlign: TextAlign.center,
              ));
        },
      ),
    ) : widget.placesVM is PlacesWithAdditionalAdminPermissionsVM ? ChangeNotifierProvider<PlacesWithAdditionalAdminPermissionsVM>(
      create: (BuildContext context) => widget.placesVM,
      child: Consumer<PlacesWithAdditionalAdminPermissionsVM>(
        builder: (context, viewModel, view) {
          switch (viewModel.placesWithAdditionalAdminPermissionsData.status) {
            case ApiStatus.LOADING:
              Utils.printMsg("PlacesWithAdditionalAdminPermissionsList :: LOADING");
              return const Loading();
            case ApiStatus.ERROR:
              Utils.printMsg(
                  "PlacesList :: ERROR${viewModel.placesWithAdditionalAdminPermissionsData.message}");
              return Center(
                  child: Text(
                    "No Places found!",
                    style: apiMessageTextStyle(context),
                    textAlign: TextAlign.center,
                  ));
            case ApiStatus.COMPLETED:
              Utils.printMsg(
                  "PlacesWithAdditionalAdminPermissionsList :: COMPLETED");

              List<AppUserAccessAdditionalAdminPermissions>?
              listPlaces = viewModel
                  .placesWithAdditionalAdminPermissionsData
                  .data!
                  .value!
                  .appUserAccessPermissions;

              if (listPlaces == null ||
                  listPlaces.isEmpty) {
                return Center(
                    child: Text(
                      "No Places found!",
                      style: apiMessageTextStyle(context),
                      textAlign: TextAlign.center,
                    ));
              } else {
                Utils.printMsg(
                    "PlacesWithAdditionalAdminPermissionsList${listPlaces.length}");

                Future.delayed(Duration.zero,
                        () async {
                      RequestRooms requestRooms =
                      RequestRooms(
                          applicationId: applicationId,
                          appuserId: appUserId,
                          homeId: listPlaces[0].homeId!
                        // homeId:
                        // "0DE75DB7-7651-4306-B1DA-904874793930",
                      );
                      widget.roomsVM.getAllRooms(requestRooms);
                    });

                if(listPlaces.isNotEmpty){
                  listPlaces[0].isSelected = true;
                  widget.selectedPlaceCallback(listPlaces[0]);
                }

                return PlacesListView(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, widget.roomsVM, listPlaces, selectedPlaceCallback);
              }
            default:
          }
          return const Loading();
        },
      ),
    ) : ChangeNotifierProvider<PlacesVM>(
      create: (BuildContext context) => widget.placesVM,
      child: Consumer<PlacesVM>(
        builder: (context, viewModel, view) {
          switch (viewModel.placesData.status) {
            case ApiStatus.LOADING:
              Utils.printMsg("PlacesList :: LOADING");
              return const Loading();
            case ApiStatus.ERROR:
              Utils.printMsg(
                  "PlacesList :: ERROR${viewModel.placesData.message}");
              return Center(
                  child: Text(
                    "No Places found!",
                    style: apiMessageTextStyle(context),
                    textAlign: TextAlign.center,
                  ));
            case ApiStatus.COMPLETED:
              Utils.printMsg(
                  "PlacesList :: COMPLETED");

              List<AppUserAccessPermissions>?
              listPlaces = viewModel
                  .placesData
                  .data!
                  .value!
                  .appUserAccessPermissions;

              if (listPlaces == null ||
                  listPlaces.isEmpty) {
                return Center(
                    child: Text(
                      "No Places found!",
                      style: apiMessageTextStyle(context),
                      textAlign: TextAlign.center,
                    ));
              } else {
                Utils.printMsg(
                    "PlacesList${listPlaces.length}");

                Future.delayed(Duration.zero,
                        () async {
                      RequestRooms requestRooms =
                      RequestRooms(
                          applicationId: applicationId,
                          appuserId: appUserId,
                          homeId: listPlaces[0].homeId!
                        // homeId:
                        // "0DE75DB7-7651-4306-B1DA-904874793930",
                      );
                      widget.roomsVM.getAllRooms(requestRooms);
                    });

                if(listPlaces.isNotEmpty){
                  listPlaces[0].isSelected = true;
                  widget.selectedPlaceCallback(listPlaces[0]);
                }

                return PlacesListView(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, widget.roomsVM, listPlaces, selectedPlaceCallback);
              }
            default:
          }
          return const Loading();
        },
      ),
    );
  }
}
