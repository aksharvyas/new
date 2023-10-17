import 'package:flutter/material.dart';
import 'package:kremot/view/widgets/dialogs/place/RoomsListView.dart';
import 'package:provider/provider.dart';

import '../../../../data/remote/response/ApiStatus.dart';
import '../../../../models/RoomsModel.dart';
import '../../../../res/AppStyles.dart';
import '../../../../utils/Utils.dart';
import '../../../../view_model/RoomsVM.dart';
import '../../Loading.dart';

class RoomsList extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double buttonWidth;
  double buttonHeight;
  dynamic roomsVM;
  bool selectMultipleRooms;
  bool isPairingDialog;
  Function selectedRoomCallback;

  RoomsList(this.screenWidth, this.screenHeight, this.buttonWidth, this.buttonHeight, this.roomsVM, this.selectMultipleRooms, this.isPairingDialog, this.selectedRoomCallback, {Key? key}) : super(key: key);

  @override
  State<RoomsList> createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {

  selectedRoomCallback(roomsSelected){
    widget.selectedRoomCallback(roomsSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomsVM>(
      create: (BuildContext context) => widget.roomsVM,
      child: Consumer<RoomsVM>(
        builder: (context, viewModel, view) {
          switch (viewModel.roomsData.status) {
            case ApiStatus.LOADING:
              Utils.printMsg("RoomsList :: LOADING");
              return const Loading();
            case ApiStatus.ERROR:
              Utils.printMsg(
                  "RoomsList :: ERROR${viewModel.roomsData.message}");
              return Center(
                  child: Text(
                    "No Rooms found!",
                    style: apiMessageTextStyle(context),
                    textAlign: TextAlign.center,
                  ));
            case ApiStatus.COMPLETED:
              Utils.printMsg(
                  "RoomsList :: COMPLETED");
              if (viewModel.roomsData.data!.value!
                  .appUserAccessPermissionsRoom ==
                  null) {
                return Center(
                    child: Text(
                      "No Rooms found!",
                      style: apiMessageTextStyle(context),
                      textAlign: TextAlign.center,
                    ));
              } else {
                Utils.printMsg(
                    "RoomsList${viewModel.roomsData.data!.value!.appUserAccessPermissionsRoom!.length}");
                List<AppUserAccessPermissionsRoom>
                roomsList = viewModel
                    .roomsData
                    .data!
                    .value!
                    .appUserAccessPermissionsRoom!;
                return RoomsListView(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, roomsList, widget.selectMultipleRooms, selectedRoomCallback);
              }
            default:
          }
          return Center(
              child: Text(
                "No Rooms found!",
                style: apiMessageTextStyle(context),
                textAlign: TextAlign.center,
              ));
        },
      ),
    );
  }
}
