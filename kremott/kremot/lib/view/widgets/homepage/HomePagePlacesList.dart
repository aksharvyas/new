import 'package:flutter/material.dart';
import 'package:kremot/view/widgets/homepage/HomePagePlacesListView.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/PlacesWithOwnerPermissionsModel.dart';
import '../../../models/RoomsModel.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/RoomsVM.dart';
import '../Loading.dart';
import '../widget.dart';

class HomePagePlacesLayout extends StatefulWidget {
  double width;
  double height;
  PlacesWithOwnerPermissionsVM placesWithOwnerPermissionsVM;
  RoomsVM roomsVM;
  bool isExpandPair;
  HomePagePlacesLayout(this.width, this.height, this.placesWithOwnerPermissionsVM, this.roomsVM, this.isExpandPair, {Key? key}) : super(key: key);

  @override
  State<HomePagePlacesLayout> createState() => _HomePagePlacesLayoutState();
}

class _HomePagePlacesLayoutState extends State<HomePagePlacesLayout> {

  List<AppUserAccessOwnerPermissions>? listPlaces = [];
  int _currentFocusedIndex = 0;
  AutoScrollController controllerPlace = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Stack(
        children: [
          // Positioned(
          //   left: getX(widget.width, 10.01),
          //   top: getY(widget.height, 664),
          //   child: GestureDetector(
          //     onTap: () {
          //       _currentFocusedIndex--;
          //       if (_currentFocusedIndex < 0) {
          //         _currentFocusedIndex = listPlaces!.length - 1;
          //       }
          //
          //       controllerPlace.scrollToIndex(
          //           _currentFocusedIndex,
          //           preferPosition: AutoScrollPosition.begin);
          //
          //       setState(() {});
          //     },
          //     child: const Icon(
          //       Icons.arrow_left,
          //       size: 20,
          //       color: Color(0xffD9DADB),
          //     ),
          //   ),
          // ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: animatedDuration),
              top: getY(widget.height, 664),
              left: getX(widget.width, 30),
              right: getX(widget.width, 30),
              child: SizedBox(
                height: getHeight(widget.height, 38.55),
                child: ChangeNotifierProvider<PlacesWithOwnerPermissionsVM>.value(
                  value: widget.placesWithOwnerPermissionsVM,
                  child:
                  Consumer<PlacesWithOwnerPermissionsVM>(
                    builder: (context, viewModel, view) {
                      switch (viewModel
                          .placesWithOwnerPermissionsData
                          .status) {
                        case ApiStatus.LOADING:
                          Utils.printMsg(
                              "PlacesWithOwnerPermissionsList :: LOADING");
                          return const Loading();
                        case ApiStatus.ERROR:
                          Utils.printMsg(
                              "PlacesList :: ERROR${viewModel.placesWithOwnerPermissionsData.message}");
                          return Center(
                              child: Text(
                                "No Places found!",
                                style:
                                apiMessageTextStyle(context),
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
                                  style: apiMessageTextStyle(
                                      context),
                                  textAlign: TextAlign.center,
                                ));
                          } else {
                            Utils.printMsg(
                                "PlacesWithOwnerPermissionsList${listPlaces.length}");

                            if(listPlaces.isNotEmpty){
                              listPlaces[0].isSelected = true;

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
                            }

                            return HomePagePlacesListView(widget.width, widget.height, listPlaces, controllerPlace);
                          }
                        default:
                      }
                      return Container();
                    },
                  ),
                ),
              )),
          // Positioned(
          //   left: getX(widget.width, 400.48 - 10.01),
          //   top: getY(widget.height, 730.73),
          //   child: GestureDetector(
          //     onTap: () {
          //       _currentFocusedIndex--;
          //       if (_currentFocusedIndex < 0) {
          //         _currentFocusedIndex = listPlaces!.length - 1;
          //       }
          //       controllerPlace.scrollToIndex(
          //           _currentFocusedIndex,
          //           preferPosition: AutoScrollPosition.begin);
          //
          //       setState(() {});
          //     },
          //     child: const Icon(
          //       Icons.arrow_right,
          //       size: 20,
          //       color: Color(0xffD9DADB),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
