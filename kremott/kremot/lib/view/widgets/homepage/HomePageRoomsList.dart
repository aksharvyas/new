import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kremot/data/remote/response/ApiStatus.dart';
//import 'package:kremot/models/RoomsModel.dart';
import 'package:kremot/models/ScenesModel.dart';
import 'package:kremot/res/AppStyles.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/utils/Utils.dart';
import 'package:kremot/view/widgets/Loading.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/RoomsVM.dart';
import 'package:kremot/view_model/ScenesVM.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../../../global/storage.dart';
import '../../../models/RoomListModel.dart';
import '../../../models/SceneItem.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../view_model/RoomVM.dart';
import '../DialogCenterButton.dart';
import 'HomePageRoomsListView.dart';
import 'HomePageScenesList.dart';

class HomePageRoomsList extends StatefulWidget {
  double width;
  double height;
  RoomsVM roomsVM;
  ScenesVM scenesVM;
  bool isExpandPair;
  String homeId;
  Function roomLongPressCallback;

  HomePageRoomsList(this.width, this.height, this.roomsVM, this.scenesVM, this.isExpandPair, this.roomLongPressCallback,this.homeId, {Key? key}) : super(key: key);

  @override
  State<HomePageRoomsList> createState() => HomePageRoomsListState();
}

class HomePageRoomsListState extends State<HomePageRoomsList> {

  List<AppUserAccessPermissionsRoom>? listRooms = [];
  final RoomVM viewModelRoom = RoomVM();
  String homeIds="";
  String roomId="";
  int _currentFocusedIndex = 0;
  //List<Map<String, dynamic>> listMapRooms = [];
  List<Map<String, dynamic>> listMapOptions = [];
  AutoScrollController controllerRoom = AutoScrollController();

  @override
  void initState()  {
   // getPerferance();
  }

  String? previousHomeIds = '';

  Future<void> getPerferance()
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? homeIds = await prefs.getString('homeId');
    if(homeIds != previousHomeIds) {
      previousHomeIds = homeIds;
      getRoom(homeIds);
    }
    //listMapRooms
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // set your stuff here
    print("Mrugesh didChangeDependencies");
  }

  @override
  void didUpdateConfig(){
    print("Mrugesh didUpdateConfig");
  }

  static var roomList=[
    HomePageRoomItem('ROOM 1', "111", unSelectedButtonImage, false, FocusNode())
  ];

  void getRoom(String? tempids) async {
    roomList.clear();
    String? userId = await LocalStorageService.getUserId();
    RequestRoomList requestRoomList = RequestRoomList(
      appuserId: userId,
      applicationId: applicationId,
      homeId: tempids,
    );

    ResponseRoomList? responseRoomList =
    await viewModelRoom.roomList(requestRoomList);
    if (responseRoomList!.value!.meta!.code == 1) {
      roomList.clear();
      for (int i = 0;
      i < responseRoomList.value!.appUserAccessPermissionsRoom!.length;
      i++) {
        setState(() {
          // Map<String, dynamic> mapRoom = {};
          // mapRoom['name'] =
          //     responseRoomList.value!.appUserAccessPermissionsRoom![i].roomName;
          // mapRoom['roomId'] =
          //     responseRoomList.value!.appUserAccessPermissionsRoom![i].roomId;
          // mapRoom['selected'] = false;
          // roomId =  responseRoomList.value!.appUserAccessPermissionsRoom![i].roomId!;
          // listMapRooms.add(mapRoom);

          print("Data Mrugesh : " + responseRoomList.value!.appUserAccessPermissionsRoom![i].roomName.toString());

          roomList.add(HomePageRoomItem(responseRoomList.value!.appUserAccessPermissionsRoom![i].roomName.toString(),responseRoomList.value!.appUserAccessPermissionsRoom![i].roomId.toString(), unSelectedButtonImage, false, FocusNode()));
        });
      }
      roomList[0]._image = selectedButtonImage;
print("roomList. Mrugesh : " + roomList.length.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: animatedDuration),
          left: getX(widget.width, 11),
          top: getY(widget.height, widget.isExpandPair ? 617 : 726),
          child: GestureDetector(
            onTap: () {
              _currentFocusedIndex--;
              if (_currentFocusedIndex < 0) {
                _currentFocusedIndex = listRooms!.length - 1;
              }

              controllerRoom.scrollToIndex(
                  _currentFocusedIndex,
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
            top: getY(widget.height, widget.isExpandPair ? 609 : 718),
            left: getX(widget.width, 30),
            right: getX(widget.width, 30),

            child: SizedBox(
              height: getHeight(widget.height, 38.55),
              child: PageView.builder(
                padEnds: false,
                controller: PageController(viewportFraction: 1/3.8),
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () {
                      Utils.vibrateSound();
                      if(roomList.length>0) {
                        for (int i = 0;
                        i < roomList.length;
                        i++) {
                          setState(() {
                            roomList[i]._image = unSelectedButtonImage;
                          });
                        }
                        roomList[index]._image = selectedButtonImage;
                        Navigator.of(context).pop();
                      }
                      // setState(() {
                      //   if(listMapRooms[index % listMapRooms.length]._image == selectedButtonImage){
                      //     //roomList[index]._image = "assets/images/next_off.png";
                      //   } else{
                      //     for(HomePageRoomItem roomItem in listMapRooms){
                      //       roomItem._image = unSelectedButtonImage;
                      //     }
                      //     listMapRooms[index % listMapRooms.length]._image = selectedButtonImage;
                      //   }
                      // });

                      //showToastFun(context, '${roomList[index].getName()} is Apply');
                    },
                    onLongPress: (){
                      widget.roomLongPressCallback();
                      renameDialog(context, widget.height, widget.width, index % (roomList.length == 0 ? 1 : roomList.length), roomList[index % (roomList.length == 0 ? 1 : roomList.length)]._name);
                    },
                    child: getRoomsinfo(index),
                  );
                },
              ),
            )),
        // Positioned(
        //     top: getY(widget.height, widget.isExpandPair ? 609 : 718),
        //     left: getX(widget.width, 30),
        //     right: getX(widget.width, 30),
        //     child: SizedBox(
        //       height: getHeight(widget.height, 38.55),
        //       child: ChangeNotifierProvider<RoomsVM>(
        //         create: (BuildContext context) =>
        //         widget.roomsVM,
        //         child:
        //         Consumer<RoomsVM>(
        //           builder: (context, viewModel, view) {
        //             switch (viewModel
        //                 .roomsData
        //                 .status) {
        //               case ApiStatus.LOADING:
        //                 Utils.printMsg(
        //                     "RoomsList :: LOADING");
        //                 return const Loading();
        //               case ApiStatus.ERROR:
        //                 Utils.printMsg(
        //                     "RoomsList :: ERROR${viewModel.roomsData.message}");
        //                 return Center(
        //                     child: Text(
        //                       "No Rooms found!",
        //                       style:
        //                       apiMessageTextStyle(context),
        //                       textAlign: TextAlign.center,
        //                     ));
        //               case ApiStatus.COMPLETED:
        //                 Utils.printMsg(
        //                     "RoomsList :: COMPLETED");
        //
        //                 listRooms = viewModel
        //                     .roomsData
        //                     .data!
        //                     .value!
        //                     .appUserAccessPermissionsRoom!;
        //
        //                 if (listRooms == null ||
        //                     listRooms!.isEmpty) {
        //                   return Center(
        //                       child: Text(
        //                         "No Rooms found!",
        //                         style: apiMessageTextStyle(
        //                             context),
        //                         textAlign: TextAlign.center,
        //                       ));
        //                 } else {
        //                   Utils.printMsg(
        //                       "RoomsList${listRooms!.length}");
        //
        //                   if(listRooms!.isNotEmpty){
        //                     listRooms![0].isSelected = true;
        //
        //                     Future.delayed(Duration.zero,
        //                             () async {
        //                           RequestScenes requestScenes =
        //                           RequestScenes(
        //                               applicationId: applicationId,
        //                               roomId: listRooms![0].roomId
        //                           );
        //                           widget.scenesVM.getScenes(requestScenes);
        //                         });
        //                   }
        //
        //                   return HomePageRoomsListView(widget.width, widget.height, listRooms!, controllerRoom);
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
          top: getY(widget.height, widget.isExpandPair ? 617 : 726),
          child: GestureDetector(
            onTap: () {
              _currentFocusedIndex--;
              if (_currentFocusedIndex < 0) {
                _currentFocusedIndex = listRooms!.length - 1;
              }
              controllerRoom.scrollToIndex(
                  _currentFocusedIndex,
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
  Widget getRoomsinfo(int index)
  {
    getPerferance();
    return roomList.length >0 ?getHomeHorizontalItem(
        context,
        roomList[index % (roomList.length == 0 ? 1 : roomList.length)]._image,
        roomList[index % (roomList.length == 0 ? 1 : roomList.length)]._name,
        widget.height,
        widget.width,
        getHeight(widget.height, homePageListButtonHeight),
        getWidth(widget.width, homePageListButtonWidth), index % (roomList.length == 0 ? 1 : roomList.length)):Container();

  }



  List<Widget> getRoomList(
      BuildContext context, double screenWidth, double screenHeight) {

    return List.generate(
      roomList.length,
          (index) => AutoScrollTag(
          key: ValueKey(index),
          controller: controllerRoom,
          index: index,
          child: GestureDetector(
            onTap: () {
              Utils.vibrateSound();
              setState(() {
                if(roomList[index]._image == selectedButtonImage){
                  //roomList[index]._image = "assets/images/next_off.png";
                } else{
                  for(HomePageRoomItem roomItem in roomList){
                    roomItem._image = unSelectedButtonImage;
                  }
                  roomList[index]._image = selectedButtonImage;
                }
              });

              //showToastFun(context, '${roomList[index].getName()} is Apply');
            },
            onLongPress: (){
              widget.roomLongPressCallback();
              renameDialog(context, screenHeight, screenWidth, index, roomList[index]._name);
            },
            child:roomList.length>0 ?getHomeHorizontalItem(
                context,
                roomList[index]._image,
                roomList[index]._name,
                screenHeight,
                screenWidth,
                getHeight(screenHeight, homePageListButtonHeight),
                getWidth(screenWidth, homePageListButtonWidth), index):Container(),
          )),
    );
  }


  Widget getHomeHorizontalItem(BuildContext context, String image, String name, double screenHeight, double screenWidth, double height, double width, int selectedRoomIndex) {
    TextEditingController editingController = TextEditingController();
    editingController.text = name;
    editingController.selection = TextSelection.fromPosition(TextPosition(offset: editingController.text.length));

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(image,
                height: height, width: width, fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: TextField(
                  enableInteractiveSelection: false,
                  cursorColor: dialogTitleColor,
                  focusNode: roomList[selectedRoomIndex]._focusNode,
                  //autofocus: true,
                  controller: editingController,
                  enabled: roomList[selectedRoomIndex].isEditable,
                  onSubmitted: (text) {
                    if(text.isNotEmpty) {
                      setState(() {
                        editingController.text = text.toUpperCase();
                        roomList[selectedRoomIndex]._name = text.toUpperCase();
                        roomList[selectedRoomIndex].isEditable = false;
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
                      fontSize: getAdaptiveTextSize(
                          context, homePageButtonTextSize)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(textFieldMaxLength),
                  ],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: getWidth(screenWidth, homePageItemHorizontalMargin),)
      ],
    );
  }

  void renameDialog(BuildContext context, double height, double width, int selectedPos, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {

          return Align(
            alignment: const Alignment(0, 0.7),
            child: Container(
              width: getWidth(width, renameDialogWidth),
              height: getHeight(height, renameDialogHeight),
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
                    image: AssetImage(alertDialogBg),
                    fit: BoxFit.fill
                ),
              ),
//color: Colors.white,

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
                        fontSize: getAdaptiveTextSize(
                            context,
                            12.0)),
                  ),
                  DialogCenterButton(
                      "RENAME",
                      optionsButtonWidth,
                      optionsButtonHeight,
                      optionsButtonTextSize,
                          (selected) {
                        Navigator.pop(context);
                        setState(() {
                          for(int i=0;i<roomList.length;i++){
                            roomList[i].isEditable = false;
                          }
                          roomList[selectedPos].isEditable = true;

                          Future.delayed(const Duration(milliseconds: 100), () async {
                            FocusManager.instance.primaryFocus?.requestFocus(roomList[selectedPos]._focusNode);
                          });
                        });
                      }),
                ],
              ),
            ),
          );
        });
  }

}

class HomePageRoomItem extends ChangeNotifier {
  late String _name;
  late String _roomId;
  late String _image;
  late bool isEditable;
  late FocusNode _focusNode;


  HomePageRoomItem(this._name,this._roomId, this._image, this.isEditable, this._focusNode);
}

