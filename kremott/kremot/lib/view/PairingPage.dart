import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/models/HomeListModel.dart';
import 'package:kremot/models/HomeModel.dart';
import 'package:kremot/models/LightItem.dart';
import 'package:kremot/models/PairingModel.dart';
import 'package:kremot/models/RoomListModel.dart';
import 'package:kremot/models/RoomModel.dart';
import 'package:kremot/models/SceneItem.dart';
import 'package:kremot/protocol/Communication.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/view/HomePage.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/HomeVM.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vibration/vibration.dart';

import '../res/AppStyles.dart';
import '../view_model/RoomVM.dart';

class PairingPage extends StatefulWidget {
  final BluetoothDevice device;
  final List<BluetoothService> services;

  PairingPage(this.device, this.services, {Key? key}) : super(key: key);

  @override
  State<PairingPage> createState() => _PairingPageState();
}

class _PairingPageState extends State<PairingPage> {
  bool? showLoader = false;
  final AutoScrollController controller = AutoScrollController();
  final AutoScrollController controllerScene = AutoScrollController();
  final AutoScrollController controllerRoom = AutoScrollController();
  final AutoScrollController controllerPlace = AutoScrollController();
  final AutoScrollController controllerRoomPairing = AutoScrollController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController homeController = TextEditingController();

  final TextEditingController _wifiController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late List<Widget> items = [];
  late List<Widget> itemsPairing = [];
  late List<Widget> itemsRoom = [];
  late List<Widget> itemsPlace = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentFocusedIndex = 0;
  final HomeVM viewModelHome = HomeVM();
  final RoomVM viewModelRoom = RoomVM();

  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

  final Map<Guid, List<int>> readValues1 = <Guid, List<int>>{};
  final Map<Guid, List<int>> readValues2 = <Guid, List<int>>{};
  final Map<Guid, List<int>> readValues3 = <Guid, List<int>>{};
  var data;

  bool isPairingFirst = true;
  bool isPairingSecond = false;
  bool isPairingThird = false;
  bool isPairingFourth = false;
  bool isPairingFifth = false;
  late double _progressValue = 0.0;
  String? applicationId;
  GlobalKey globalKey = GlobalKey();

  var sceneList = [
    // SceneItem('SCENE 1', "assets/images/menuitem.png"),
    // SceneItem('SCENE 2', "assets/images/menuitem.png"),
    // SceneItem('SCENE 3', "assets/images/menuitem.png"),
    // SceneItem('SCENE 4', "assets/images/menuitem.png"),
    // SceneItem('SCENE 5', "assets/images/menuitem.png"),
    // SceneItem('SCENE 6', "assets/images/menuitem.png"),
    // SceneItem('SCENE 7', "assets/images/menuitem.png"),
    // SceneItem('SCENE 8', "assets/images/menuitem.png"),
  ];

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

  List<AppUserAccessPermissions> _placeList = [];

  String? homeId;
  String? roomId;

  List<AppUserAccessPermissionsRoom> _roomList = [];

  var placeList = [
    // SceneItem('Home', "assets/images/menuitem.png"),
    // SceneItem('Office', "assets/images/menuitem.png"),
    // SceneItem('Shop', "assets/images/menuitem.png"),
    // SceneItem('WorkPlace', "assets/images/menuitem.png"),
  ];

  final ItemScrollController itemScrollController = ItemScrollController();

  final testArray = [for (var i = 1; i < 9; i++) '$i'];

  double itemWidth = 35.0;
  int itemCount = 9;
  int selected = 4;
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 1);

  double itemWidth1 = 35.0;
  int itemCount1 = 9;
  int selected1 = 4;
  String? mobileNumber;
  String? wifiUsername;
  String? wifiPassword;

  final FixedExtentScrollController _scrollController1 =
      FixedExtentScrollController(initialItem: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getHome();
    // getRoom();

    // _generateImageData();
  }

  void _updateProgress() {
    const oneSec = Duration(seconds: 60);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          t.cancel();
          return;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: context.resources.color.colorBlack,
        //resizeToAvoidBottomInset: false,
        drawer: Container(
          margin: EdgeInsets.only(top: getHeight(height, 20)),
          width: getWidth(width, 125),
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: const [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: Text('google.com'),
                ),
                ListTile(
                  title: Text('yahoo.com'),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(children: [
              Expanded(
                  child: SizedBox(
                      height: height,
                      width: width,
                      child: Stack(children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Positioned(
                                top: getY(height, 77.28),
                                left: getX(width, 32.3),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('assets/images/menuselect.png',
                                        height: getHeight(height, 38.27),
                                        width: getWidth(width, 73.55),
                                        fit: BoxFit.fill),
                                    Positioned(
                                      child: Image.asset(
                                        'assets/images/menu.png',
                                        height: getHeight(height, 12.01),
                                        width: getWidth(width, 26.53),
                                      ),
                                    ),
                                  ],
                                )),
                            Positioned(
                                left: getX(width, 216.26),
                                top: getY(height, 74.09),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Image.asset('assets/images/menuselect.png',
                                        height: getHeight(height, 42.3),
                                        width: getWidth(width, 165.7),
                                        fit: BoxFit.fill),
                                    Positioned(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              style: TextStyle(
                                                  color: context.resources.color
                                                      .colorWhite,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: getAdaptiveTextSize(
                                                      context, 26)),
                                              text: "K"),
                                          TextSpan(
                                              style: TextStyle(
                                                  color: context.resources.color
                                                      .colorWhite,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: getAdaptiveTextSize(
                                                      context, 20)),
                                              text: "REMOT")
                                        ])),
                                      ),
                                    ),
                                  ],
                                )),
                            Positioned(
                                top: getY(height, 140.17),
                                left: getX(width, 32.54),
                                right: getX(width, 25.54),
                                child: SizedBox(
                                  height: getHeight(height, 38.55),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    controller: controllerScene,
                                    children:
                                        getSceneList(context, width, height),
                                  ),
                                )),
                            Positioned(
                              top: getY(height, 154.69),
                              left: getX(width, 11.51),
                              child: GestureDetector(
                                onTap: () {
                                  _currentFocusedIndex--;
                                  if (_currentFocusedIndex < 0) {
                                    _currentFocusedIndex = items.length - 1;
                                  }

                                  controllerScene.scrollToIndex(
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
                            Positioned(
                              left: getX(width, 401.99 - 11.51),
                              top: getY(height, 154.51),
                              child: GestureDetector(
                                onTap: () {
                                  _currentFocusedIndex++;
                                  if (_currentFocusedIndex > items.length) {
                                    _currentFocusedIndex = 0;
                                  }
                                  controllerScene.scrollToIndex(
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
                            Positioned(
                              top: getY(height, 201.99),
                              left: getX(width, 32.54),
                              child: SizedBox(
                                height: getHeight(height, 38.55),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  controller: controller,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   isWithoutPairingVisible=false;
                                          //   isPairingVisible=true;
                                          // });
                                        },
                                        child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Image.asset(
                                                  'assets/images/listitem.png',
                                                  height:
                                                      getHeight(height, 38.55),
                                                  width: getWidth(width, 74.09),
                                                  fit: BoxFit.fill),
                                              Positioned.fill(
                                                child: Align(
                                                    child: Text("PAIR DEVICE",
                                                        style: TextStyle(
                                                            color: textColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "Inter",
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize:
                                                                getAdaptiveTextSize(
                                                                    context,
                                                                    8.3)),
                                                        textAlign:
                                                            TextAlign.center)),
                                              )
                                            ])),
                                    SizedBox(
                                      width: getWidth(width, 15),
                                    ),
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            'assets/images/listitem.png',
                                            height: getHeight(height, 38.55),
                                            width: getWidth(width, 74.09),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                              child: Text("DEMO",
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Inter",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 8.3)),
                                                  textAlign: TextAlign.center)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: getWidth(width, 15),
                                    ),
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            'assets/images/listitem.png',
                                            height: getHeight(height, 38.55),
                                            width: getWidth(width, 74.09),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                              child: Text("ALLOW",
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Inter",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 8.3)),
                                                  textAlign: TextAlign.center)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: getWidth(width, 15),
                                    ),
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            'assets/images/listitem.png',
                                            height: getHeight(height, 38.55),
                                            width: getWidth(width, 74.09),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                              child: Text("ALL OFF",
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Inter",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 8.3)),
                                                  textAlign: TextAlign.center)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: getWidth(width, 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                top: getY(height, 261.82),
                                child: Container(
                                    width: getWidth(width, 414),
                                    height: getHeight(height, 2.002),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffdededd),
                                            width: 2.0024185180664062)))),
                            // Positioned(
                            //   left: getX(width, 386.47),
                            //   top: getY(height, 283.34),
                            //   child: GestureDetector(
                            //     child: const Icon(
                            //       Icons.arrow_drop_up,
                            //       size: 20,
                            //       color: arrowColor,
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: getX(width, 10.01),
                            //   top: getY(height, 470.07),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       _currentFocusedIndex--;
                            //       if (_currentFocusedIndex < 0) {
                            //         _currentFocusedIndex = items.length - 1;
                            //       }
                            //
                            //       controller.scrollToIndex(_currentFocusedIndex,
                            //           preferPosition: AutoScrollPosition.begin);
                            //
                            //       setState(() {});
                            //     },
                            //     child: const Icon(
                            //       Icons.arrow_left,
                            //       size: 20,
                            //       color: arrowColor,
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: getX(width, 400.48 - 10.01),
                            //   top: getY(height, 470.07),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       _currentFocusedIndex--;
                            //       if (_currentFocusedIndex < 0) {
                            //         _currentFocusedIndex = items.length - 1;
                            //       }
                            //
                            //       controller.scrollToIndex(_currentFocusedIndex,
                            //           preferPosition: AutoScrollPosition.begin);
                            //
                            //       setState(() {});
                            //     },
                            //     child: const Icon(
                            //       Icons.arrow_right,
                            //       size: 20,
                            //       color: arrowColor,
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                                left: 0,
                                top: getY(height, 700),
                                child: Container(
                                    width: getWidth(width, 414),
                                    height: getHeight(height, 2.002),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffdededd),
                                            width: 2.0024185180664062)))),
                            Positioned(
                                top: getY(height, 721.73),
                                left: getX(width, 32.54),
                                right: getX(width, 25.54),
                                child: SizedBox(
                                  height: getHeight(height, 38.55),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    controller: controller,
                                    children:
                                        getRoomList(context, width, height),
                                  ),
                                )),
                            Positioned(
                              left: getX(width, 10.01),
                              top: getY(height, 730.73),
                              child: GestureDetector(
                                onTap: () {
                                  _currentFocusedIndex--;
                                  if (_currentFocusedIndex < 0) {
                                    _currentFocusedIndex = itemsRoom.length - 1;
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
                            Positioned(
                              left: getX(width, 400.48 - 10.01),
                              top: getY(height, 730.73),
                              child: GestureDetector(
                                onTap: () {
                                  _currentFocusedIndex--;
                                  if (_currentFocusedIndex < 0) {
                                    _currentFocusedIndex = itemsRoom.length - 1;
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
                            // Positioned(
                            //     left: getX(width, 32.54),
                            //     top: getY(height, 310.87),
                            //     right: getX(width, 32.54),
                            //     child: PageView.builder(
                            //   // controller: _controller,
                            //   physics: const BouncingScrollPhysics(),
                            //   itemCount: 2,
                            //   itemBuilder: (context, i) => i == 0
                            //       ? Stack(
                            //     children: [
                            //       Positioned(
                            //           left: getX(width, 32.54),
                            //           top: getY(height, 310.87),
                            //           right: getX(width, 32.54),
                            //           child: SizedBox(
                            //             width: getWidth(width, width),
                            //             height: getHeight(height, 290),
                            //             child:
                            //             DraggableGridViewBuilder(
                            //                 padding: const EdgeInsets
                            //                     .symmetric(
                            //                     horizontal: 0,
                            //                     vertical: 0),
                            //                 physics:
                            //                 const ClampingScrollPhysics(),
                            //                 shrinkWrap: true,
                            //                 scrollDirection:
                            //                 Axis.vertical,
                            //                 gridDelegate:
                            //                 SliverGridDelegateWithFixedCrossAxisCount(
                            //                   crossAxisCount: 4,
                            //                   //crossAxisSpacing: 10,
                            //                   mainAxisSpacing:
                            //                   getHeight(height, 35),
                            //                   mainAxisExtent: 40,
                            //                   childAspectRatio: 4 / 1.5,
                            //                 ),
                            //                 // itemCount: lightList.length,
                            //                 // primary: false,
                            //                 // itemBuilder:
                            //                 //     (context, index) => GestureDetector(
                            //                 //     onTap: () {
                            //                 //       Vibration.vibrate(
                            //                 //           duration: 100);
                            //                 //       setState(() {
                            //                 //         if (lightList[index]
                            //                 //             .getImage() ==
                            //                 //             "assets/images/listitem.png") {
                            //                 //           lightList[index].setImage(
                            //                 //               "assets/images/select.png");
                            //                 //           lightList[index]
                            //                 //               .setSelectd(true);
                            //                 //         } else {
                            //                 //           lightList[index].setImage(
                            //                 //               "assets/images/listitem.png");
                            //                 //           lightList[index]
                            //                 //               .setSelectd(false);
                            //                 //         }
                            //                 //       });
                            //                 //     },
                            //                 //     child:
                            //                 //     Stack(
                            //                 //       alignment:
                            //                 //       Alignment
                            //                 //           .topCenter,
                            //                 //       children: [
                            //                 //         Image.asset(
                            //                 //             lightList[index]
                            //                 //                 .getImage(),
                            //                 //             height: getHeight(
                            //                 //                 height,
                            //                 //                 53.06),
                            //                 //             width: getWidth(
                            //                 //                 width,
                            //                 //                 74.09),
                            //                 //             fit: BoxFit
                            //                 //                 .fill),
                            //                 //         Positioned.fill(
                            //                 //           child: Align(
                            //                 //               child: Text(
                            //                 //                   lightList[index]
                            //                 //                       .getName(),
                            //                 //                   style: const TextStyle(
                            //                 //                       color: Color(0xffffffff),
                            //                 //                       fontWeight: FontWeight.w400,
                            //                 //                       fontFamily: "Inter",
                            //                 //                       fontStyle: FontStyle.normal,
                            //                 //                       fontSize: 10.3),
                            //                 //                   textAlign: TextAlign.center)),
                            //                 //         ),
                            //                 //       ],
                            //                 //     )
                            //                 //
                            //                 // ), dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
                            //
                            //                 // },
                            //                 dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
                            //
                            //                 },
                            //                 children: getDragList(width,height),
                            //                 isOnlyLongPress: false,
                            //                 dragPlaceHolder: (List<DraggableGridItem> list, int index) {
                            //                   return PlaceHolderWidget(child:  list[i].child);
                            //                 }
                            //
                            //             ),
                            //           )),
                            //
                            //       Positioned(
                            //           top: getY(height, 600.16),
                            //           left: getX(width, 95.99),
                            //           child: const Text("FAN 1",
                            //               style: TextStyle(
                            //                   color: Color(0xffdededd),
                            //                   fontWeight: FontWeight.w700,
                            //                   fontFamily: "Inter",
                            //                   fontStyle: FontStyle.normal,
                            //                   fontSize: 12.5),
                            //               textAlign: TextAlign.center)),
                            //       Positioned(
                            //           top: getY(height, 600.16),
                            //           left: getX(width, 281.27),
                            //           child: const Text("FAN 2",
                            //               style: TextStyle(
                            //                   color:
                            //                   const Color(0xffdededd),
                            //                   fontWeight: FontWeight.w700,
                            //                   fontFamily: "Inter",
                            //                   fontStyle: FontStyle.normal,
                            //                   fontSize: 12.5),
                            //               textAlign: TextAlign.center)),
                            //       Positioned(
                            //         top: getY(height, 627.7),
                            //         left: getX(width, 31.63),
                            //         child: Stack(
                            //           alignment: Alignment.topCenter,
                            //           children: [
                            //             Image.asset(
                            //                 'assets/images/select.png',
                            //                 height:
                            //                 getHeight(height, 53.64),
                            //                 width:
                            //                 getWidth(width, 167.49),
                            //                 fit: BoxFit.fill),
                            //             Positioned.fill(
                            //                 left: 5,
                            //                 right: 5,
                            //                 child: RotatedBox(
                            //                     quarterTurns: -1,
                            //                     child:
                            //                     ListWheelScrollView(
                            //                       magnification: 2.0,
                            //                       onSelectedItemChanged:
                            //                           (x) {
                            //                         setState(() {
                            //                           selected1 = x;
                            //                         });
                            //                         print(selected1);
                            //                       },
                            //                       controller:
                            //                       _scrollController1,
                            //                       itemExtent: itemWidth1,
                            //                       children: List.generate(
                            //                           itemCount1,
                            //                               (x) => RotatedBox(
                            //                               quarterTurns: 1,
                            //                               child:
                            //                               AnimatedContainer(
                            //                                   duration: const Duration(
                            //                                       milliseconds:
                            //                                       400),
                            //                                   width: x ==
                            //                                       selected1
                            //                                       ? 60
                            //                                       : 50,
                            //                                   height: x ==
                            //                                       selected1
                            //                                       ? 60
                            //                                       : 50,
                            //                                   alignment:
                            //                                   Alignment
                            //                                       .center,
                            //                                   child:
                            //                                   Text(
                            //                                     (x + 1)
                            //                                         .toString(),
                            //                                     style: TextStyle(
                            //                                         color: Colors.white,
                            //                                         fontSize: x == selected1 ? 18 : 12),
                            //                                   )))),
                            //                     ))),
                            //           ],
                            //         ),
                            //       ),
                            //       Positioned(
                            //         top: getY(height, 627.7),
                            //         left: getX(width, 217.33),
                            //         child: Stack(
                            //             alignment: Alignment.topCenter,
                            //             children: [
                            //               Image.asset(
                            //                   'assets/images/select.png',
                            //                   height: getHeight(
                            //                       height, 53.64),
                            //                   width:
                            //                   getWidth(width, 167.49),
                            //                   fit: BoxFit.fill),
                            //               Positioned.fill(
                            //                   left: 5,
                            //                   right: 5,
                            //                   child: RotatedBox(
                            //                       quarterTurns: -1,
                            //                       child:
                            //                       ListWheelScrollView(
                            //                         magnification: 2.0,
                            //                         onSelectedItemChanged:
                            //                             (x) {
                            //                           setState(() {
                            //                             selected = x;
                            //                           });
                            //                           print(selected);
                            //                         },
                            //                         controller:
                            //                         _scrollController,
                            //                         itemExtent: itemWidth,
                            //                         children: List.generate(
                            //                             itemCount,
                            //                                 (x) => RotatedBox(
                            //                                 quarterTurns: 1,
                            //                                 child: AnimatedContainer(
                            //                                     duration: const Duration(milliseconds: 400),
                            //                                     width: x == selected ? 60 : 50,
                            //                                     height: x == selected ? 60 : 50,
                            //                                     alignment: Alignment.center,
                            //
                            //                                     //color: Colors.white,
                            //                                     // decoration: BoxDecoration(
                            //                                     //     color: x == selected ? Colors.red : Colors.grey,
                            //                                     //     ),
                            //                                     child: Text(
                            //                                       (x + 1)
                            //                                           .toString(),
                            //                                       style: TextStyle(
                            //                                           color: Colors
                            //                                               .white,
                            //                                           fontSize: x == selected
                            //                                               ? 18
                            //                                               : 12),
                            //                                     )))),
                            //                       ))),
                            //             ]),
                            //       ),
                            //     ],
                            //   )
                            //       : Container(),
                            // ))
                          ],
                        ),
                        Visibility(
                          visible: isPairingFirst,
                          child: Positioned(
                            top: getY(height, 270.32),
                            left: getX(width, 35.71),
                            right: getX(width, 35.71),
                            child: Container(
                              // color: context.resources.color.colorBlack,
                              width: getWidth(width, 356.63),
                              height: getHeight(height, 426.20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  border: Border.all(
                                      color: const Color(0xff9c9e9f),
                                      width: 0.9298010468482971),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(7.438408374786377,
                                            7.438408374786377),
                                        blurRadius: 8.368210792541504,
                                        spreadRadius: 0)
                                  ],
                                  color: const Color(0xff484949)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 147.89),
                                      child: Text("PAIRING",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 15.1)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      top: getY(height, 27.9),
                                      left: getX(width, 50.82),
                                      child: Text("SELECT PLACE",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 12.6)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      top: getY(height, 27.9),
                                      left: getX(width, 200.8),
                                      child: Text("SELECT ROOM",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 12.6)),
                                          textAlign: TextAlign.center)),
                                  _placeList.isNotEmpty
                                      ? Positioned(
                                          top: getY(height, 30.9),
                                          left: getX(width, 50.82),
                                          child: SizedBox(
                                            width: getWidth(width, 74.44),
                                            height: getHeight(height, 435.20),
                                            child: ListView(
                                              padding: EdgeInsets.only(
                                                  top: getY(height, 30.9)),
                                              scrollDirection: Axis.vertical,
                                              controller: controllerPlace,
                                              children: getPlaceList(
                                                  context, width, height),
                                            ),
                                          ))
                                      : Positioned(
                                          top: getY(height, 60.9),
                                          left: getX(width, 50.82),
                                          child: GestureDetector(
                                            onTap: () {
                                              onCreateHome(
                                                  context, height, width);
                                            },
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Image.asset(
                                                    "assets/images/menuitem.png",
                                                    height: getHeight(
                                                        height, 38.96),
                                                    width:
                                                        getWidth(width, 74.89),
                                                    fit: BoxFit.fill),
                                                Positioned.fill(
                                                  child: Align(
                                                      //alignment: Alignment.topCenter,
                                                      child: Text("+",
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize:
                                                                  getAdaptiveTextSize(
                                                                      context,
                                                                      12.3)),
                                                          textAlign: TextAlign
                                                              .center)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // child: SizedBox(
                                          //   width: 74.44,
                                          //   height: getHeight(height, 435.20),
                                          //   child: ListView(
                                          //     padding: EdgeInsets.only(
                                          //         top: getY(height, 30.9)),
                                          //     scrollDirection: Axis.vertical,
                                          //     controller: controllerRoomPairing,
                                          //     children: getRoomList1(width, height),
                                          //   ),
                                          // ),
                                        ),
                                  _roomList.isNotEmpty
                                      ? Positioned(
                                          top: getY(height, 30.9),
                                          left: getX(width, 200.8),
                                          child: SizedBox(
                                            width: getWidth(width, 74.44),
                                            height: getHeight(height, 435.20),
                                            child: ListView(
                                              padding: EdgeInsets.only(
                                                  top: getY(height, 30.9)),
                                              scrollDirection: Axis.vertical,
                                              controller: controllerRoom,
                                              children:
                                                  getRoomList1(context, width, height),
                                            ),
                                          ))
                                      : Positioned(
                                          top: getY(height, 60.9),
                                          left: getX(width, 200.8),
                                          child: GestureDetector(
                                            onTap: () {
                                              onCreateRoom(
                                                  context, height, width);
                                            },
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Image.asset(
                                                    "assets/images/menuitem.png",
                                                    height: getHeight(
                                                        height, 38.96),
                                                    width:
                                                        getWidth(width, 74.89),
                                                    fit: BoxFit.fill),
                                                Positioned.fill(
                                                  child: Align(
                                                      //alignment: Alignment.topCenter,
                                                      child: Text("+",
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize:
                                                                  getAdaptiveTextSize(
                                                                      context,
                                                                      12.3)),
                                                          textAlign: TextAlign
                                                              .center)),
                                                ),
                                              ],
                                            ),
                                          )),
                                  Positioned(
                                      top: getNextFenControlPosition(
                                          _roomList.length, 38.96, 10),
                                      left: getX(width, 200.12),
                                      child: GestureDetector(
                                        onTap: () {
                                          onCreateRoom(context, height, width);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: getWidth(width, 5)),
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Image.asset(
                                                  "assets/images/menuitem.png",
                                                  height:
                                                      getHeight(height, 38.96),
                                                  width: getWidth(width, 74.89),
                                                  fit: BoxFit.fill),
                                              Positioned.fill(
                                                child: Align(
                                                    //alignment: Alignment.topCenter,
                                                    child: Text("+",
                                                        style: TextStyle(
                                                            color: textColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "Inter",
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize:
                                                                getAdaptiveTextSize(
                                                                    context,
                                                                    12.3)),
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    top: getNextFenControlPosition(
                                        _placeList.length, 38.96, 10),
                                    left: getX(width, 50.82),
                                    child: GestureDetector(
                                        onTap: () {
                                          onCreateHome(context, height, width);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: getWidth(width, 5)),
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Image.asset(
                                                  "assets/images/menuitem.png",
                                                  height:
                                                      getHeight(height, 38.96),
                                                  width: getWidth(width, 74.89),
                                                  fit: BoxFit.fill),
                                              Positioned.fill(
                                                child: Align(
                                                    //alignment: Alignment.topCenter,
                                                    child: Text("+",
                                                        style: TextStyle(
                                                            color: textColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: "Inter",
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize:
                                                                getAdaptiveTextSize(
                                                                    context,
                                                                    12.3)),
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ],
                                          ),
                                        )),
                                    // child: SizedBox(
                                    //   width: 74.44,
                                    //   height: getHeight(height, 435.20),
                                    //   child: ListView(
                                    //     padding: EdgeInsets.only(
                                    //         top: getY(height, 30.9)),
                                    //     scrollDirection: Axis.vertical,
                                    //     controller: controllerRoomPairing,
                                    //     children: getRoomList1(width, height),
                                    //   ),
                                    // ),
                                  ),
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 318.98),
                                      right: getY(height, 5.78),
                                      child: Container(
                                        width: getWidth(width, 15.09),
                                        height: getHeight(height, 15.09),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          // border: Border.all(color: Colors.red),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.clear,
                                          color: Color(0xffdededd),
                                          size: 12,
                                        ),
                                      )),
                                  Positioned(
                                    top: getY(height, 330.12),
                                    left: getX(width, 100.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 40.73),
                                            width: getWidth(width, 130.71),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("EXISTING PLACE",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 380.12),
                                    left: getX(width, 130.73),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isPairingFirst = false;
                                          isPairingSecond = false;
                                          isPairingThird = true;
                                          isPairingFourth = false;
                                          isPairingFifth = false;
                                        });
                                      },
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Image.asset(
                                              "assets/images/menuitem.png",
                                              height: getHeight(height, 32.7),
                                              width: getWidth(width, 74.44),
                                              fit: BoxFit.fill),
                                          Positioned.fill(
                                            child: Align(
                                              //alignment: Alignment.topCenter,
                                              child: Text("NEXT",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xffdededd),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 11.1)),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPairingSecond,
                          child: Positioned(
                            top: getY(height, 270.32),
                            left: getX(width, 35.71),
                            right: getX(width, 35.71),
                            child: Container(
                              // color: context.resources.color.colorBlack,
                              width: getWidth(width, 356.63),
                              height: getHeight(height, 426.20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  border: Border.all(
                                      color: const Color(0xff9c9e9f),
                                      width: 0.9298010468482971),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(7.438408374786377,
                                            7.438408374786377),
                                        blurRadius: 8.368210792541504,
                                        spreadRadius: 0)
                                  ],
                                  color: const Color(0xff484949)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 40.89),
                                      child: Text("PAIRING",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 15.1)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      top: getY(height, 50.9),
                                      left: getX(width, 140.82),
                                      child: Text("TURN ON",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 12.6)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 318.98),
                                      right: getY(height, 5.78),
                                      child: Container(
                                        width: getWidth(width, 15.09),
                                        height: getHeight(height, 15.09),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          // border: Border.all(color: Colors.red),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.clear,
                                          color: Color(0xffdededd),
                                          size: 12,
                                        ),
                                      )),
                                  Positioned(
                                    top: getY(height, 100.9),
                                    left: getX(width, 130.73),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 41.06),
                                            width: getWidth(width, 90.10),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("BLUETOOTH",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 160.9),
                                    left: getX(width, 130.73),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 41.06),
                                            width: getWidth(width, 90.10),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("WIFI",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 220.9),
                                    left: getX(width, 130.73),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 41.06),
                                            width: getWidth(width, 90.10),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("LOCATION",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 300.9),
                                    left: getX(width, 70.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 41.06),
                                            width: getWidth(width, 72),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("ALLOW",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 300.9),
                                    left: getX(width, 200.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 41.06),
                                            width: getWidth(width, 72),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("DENY",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPairingThird,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              margin: EdgeInsets.only(
                                top: getY(height, 270.32),
                                left: getX(width, 35.71),
                                right: getX(width, 35.71),
                              ),
                              // color: context.resources.color.colorBlack,
                              width: getWidth(width, 356.63),
                              height: getHeight(height, 426.20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  border: Border.all(
                                      color: const Color(0xff9c9e9f),
                                      width: 0.9298010468482971),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(7.438408374786377,
                                            7.438408374786377),
                                        blurRadius: 8.368210792541504,
                                        spreadRadius: 0)
                                  ],
                                  color: const Color(0xff484949)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 40.89),
                                      child: Text("PAIRING",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 15.1)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      top: getY(height, 50.9),
                                      left: getX(width, 150.82),
                                      child: const Icon(
                                        Icons.wifi,
                                        size: 30,
                                        color: Color(0xffdededd),
                                      )),
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 318.98),
                                      right: getY(height, 5.78),
                                      child: Container(
                                        width: getWidth(width, 15.09),
                                        height: getHeight(height, 15.09),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          // border: Border.all(color: Colors.red),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.clear,
                                          color: Color(0xffdededd),
                                          size: 12,
                                        ),
                                      )),
                                  Positioned(
                                    top: getY(height, 100.9),
                                    left: getX(width, 70.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 35.06),
                                            width: getWidth(width, 70),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("20GHZ",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 100.9),
                                    left: getX(width, 200.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 35.06),
                                            width: getWidth(width, 70),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("50GHZ",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: getY(height, 150.9),
                                      left: getX(width, 90.73),
                                    ),
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 150.9),
                                    left: getX(width, 225.73),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        getX(width, 30.73),
                                        getY(height, 200.9),
                                        getX(width, 30.73),
                                        0),
                                    child: Container(
                                        width: getWidth(width, 341),
                                        height: getHeight(height, 45.62),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0x80eceded),
                                                width: 1),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0.0, 3),
                                                  blurRadius: 2,
                                                  spreadRadius: 0)
                                            ],
                                            color: const Color(0xb81b1918)),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: textFormField(
                                            context,
                                            onTap: () async {
                                              await Future.delayed(
                                                  Duration(milliseconds: 500));
                                              RenderObject? object = globalKey
                                                  .currentContext!
                                                  .findRenderObject();
                                              object!.showOnScreen();
                                            },
                                            hintText: "WiFi",
                                            hintStyle: hintTextStyle(context),
                                            controller: _wifiController,
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              NoLeadingSpaceFormatter(),
                                              //LengthLimitingTextInputFormatter(10),
                                            ],
                                            onFieldSubmitted1: (value) {},
                                            // onEditingComplete: () => node.nextFocus(),
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    top: getY(height, 270.9),
                                    left: getX(width, 30.73),
                                    right: getX(width, 30.73),
                                    child: Container(
                                        width: getWidth(width, 341),
                                        height: getHeight(height, 45.62),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0x80eceded),
                                                width: 1),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0.0, 3),
                                                  blurRadius: 2,
                                                  spreadRadius: 0)
                                            ],
                                            color: const Color(0xb81b1918)),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: textFormField(
                                            context,
                                            hintText: "Password",
                                            hintStyle: hintTextStyle(context),
                                            controller: _passwordController,
                                            obscureText: true,
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              NoLeadingSpaceFormatter(),
                                              //LengthLimitingTextInputFormatter(10),
                                            ],
                                            onFieldSubmitted1: (value) {},
                                            // onEditingComplete: () => node.nextFocus(),
                                            textInputAction:
                                                TextInputAction.done,
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    top: getY(height, 350.12),
                                    left: getX(width, 240.73),
                                    right: getX(width, 30.73),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_wifiController.text != "" &&
                                            _passwordController.text != "") {
                                          await LocalStorageService.setWifi(
                                              _wifiController.text.toString());
                                          await LocalStorageService
                                              .setWifiPassword(
                                                  _passwordController.text
                                                      .toString());
                                          setState(() {
                                            isPairingFirst = false;
                                            isPairingSecond = false;
                                            isPairingThird = false;
                                            isPairingFourth = true;
                                            isPairingFifth = false;
                                          });
                                        } else {
                                          showAlertDialog(context,
                                              "Please Provide Wifi And Password",
                                              () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                          });
                                        }
                                      },
                                      child: Stack(
                                        key: globalKey,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Image.asset(
                                              "assets/images/menuitem.png",
                                              height: getHeight(height, 35.7),
                                              width: getWidth(width, 74.44),
                                              fit: BoxFit.fill),
                                          Positioned.fill(
                                            child: Align(
                                              //alignment: Alignment.topCenter,
                                              child: Text("NEXT",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xffdededd),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 11.1)),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPairingFourth,
                          child: Positioned(
                            top: getY(height, 270.32),
                            left: getX(width, 35.71),
                            right: getX(width, 35.71),
                            child: Container(
                              // color: context.resources.color.colorBlack,
                              width: getWidth(width, 356.63),
                              height: getHeight(height, 426.20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  border: Border.all(
                                      color: const Color(0xff9c9e9f),
                                      width: 0.9298010468482971),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(7.438408374786377,
                                            7.438408374786377),
                                        blurRadius: 8.368210792541504,
                                        spreadRadius: 0)
                                  ],
                                  color: const Color(0xff484949)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: getY(height, 5.78),
                                      left: getX(width, 40.89),
                                      child: Text("PAIRING",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 15.1)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      top: getY(height, 70.9),
                                      left: getX(width, 90.82),
                                      child: Text("CONNECTING. . . . ",
                                          style: TextStyle(
                                              color: const Color(0x5effffff),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 20.9)),
                                          textAlign: TextAlign.justify)),
                                  Positioned(
                                    top: getY(height, 200.12),
                                    left: getX(width, 130.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 35.7),
                                            width: getWidth(width, 74.44),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("RETRY",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 350.12),
                                    left: getX(width, 240.73),
                                    right: getX(width, 30.73),
                                    child: GestureDetector(
                                      onTap: () {
                                        _progressValue = 0.0;
                                        _updateProgress();
                                        sendFastblikling();
                                        setState(() {
                                          isPairingFirst = false;
                                          isPairingSecond = false;
                                          isPairingThird = false;
                                          isPairingFourth = false;
                                          isPairingFifth = true;
                                        });
                                      },
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Image.asset(
                                              "assets/images/menuitem.png",
                                              height: getHeight(height, 35.7),
                                              width: getWidth(width, 74.44),
                                              fit: BoxFit.fill),
                                          Positioned.fill(
                                            child: Align(
                                              //alignment: Alignment.topCenter,
                                              child: Text("NEXT",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xffdededd),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize:
                                                          getAdaptiveTextSize(
                                                              context, 11.1)),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPairingFifth,
                          child: Positioned(
                            top: getY(height, 270.32),
                            left: getX(width, 35.71),
                            right: getX(width, 35.71),
                            child: Container(
                              // color: context.resources.color.colorBlack,
                              width: getWidth(width, 356.63),
                              height: getHeight(height, 426.20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  border: Border.all(
                                      color: const Color(0xff9c9e9f),
                                      width: 0.9298010468482971),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(7.438408374786377,
                                            7.438408374786377),
                                        blurRadius: 8.368210792541504,
                                        spreadRadius: 0)
                                  ],
                                  color: const Color(0xff484949)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: getY(height, 15.78),
                                      left: getX(width, 30.82),
                                      child: Text("PAIRING",
                                          style: TextStyle(
                                              color: const Color(0xffdededd),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontStyle: FontStyle.normal,
                                              fontSize: getAdaptiveTextSize(
                                                  context, 15.1)),
                                          textAlign: TextAlign.center)),
                                  Positioned(
                                      left: getX(width, 50.82),
                                      right: getX(width, 20.82),
                                      child: SizedBox(
                                        height: getHeight(height, 300),
                                        width: getWidth(width, width),
                                        child: GridView(
                                            padding: EdgeInsets.only(
                                                top: getY(height, 70.51)),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing:
                                                  getHeight(height, 35),
                                              mainAxisExtent: 30,
                                              childAspectRatio: 5 / 1.5,
                                            ),
                                            children:
                                                getPairingList(width, height)),
                                      )),
                                  Positioned(
                                    top: getY(height, 330.82),
                                    right: getX(width, 30.82),
                                    left: getX(width, 30.82),
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.cyanAccent,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.red),
                                      value: _progressValue,
                                    ),
                                  ),
                                  Positioned(
                                    top: getY(height, 350.12),
                                    left: getX(width, 100.73),
                                    right: getX(width, 100.73),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Image.asset(
                                            "assets/images/menuitem.png",
                                            height: getHeight(height, 40.7),
                                            width: getWidth(width, 100.44),
                                            fit: BoxFit.fill),
                                        Positioned.fill(
                                          child: Align(
                                            //alignment: Alignment.topCenter,
                                            child: Text("CONFIGURED",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffdededd),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize:
                                                        getAdaptiveTextSize(
                                                            context, 11.1)),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ])))
            ]),
          ),
        ));
  }

  List<Widget> getSceneList(BuildContext context, double width, double height) {
    return items = List.generate(
      sceneList.length,
      (index) => AutoScrollTag(
          key: ValueKey(index),
          controller: controller,
          index: index,
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              Vibration.vibrate(duration: 100);
              setState(() {
                sceneList[index].setImage("assets/images/menuitemselect.png");
              });

              showToastFun(context, '${sceneList[index].getName()} is Apply');
            },
            onTapUp: (TapUpDetails details) {
              setState(() {
                sceneList[index].setImage("assets/images/menuitem.png");
              });
            },
            child: getHomeHorizontalItem(
                context,
                false,
                sceneList[index].getName(),
                height,
                width,
                getHeight(height, optionsNextButtonHeight),
                getWidth(width, optionsNextButtonWidth)),
          )),
    );
  }

  List<Widget> getPairingList(double width, double height) {
    return itemsPairing = List.generate(
      1,
      (index) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/device1.png',
            width: getWidth(width, 60.21),
            height: getHeight(height, 60.01),
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: getWidth(width, 10),
          ),
          SizedBox(
            height: getHeight(height, 19.51),
            width: getWidth(width, 19.51),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.yellow,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              value: _progressValue,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getPlaceList(
      BuildContext context, double screenWidth, double screenHeight) {
    return itemsPlace = List.generate(
      _placeList.length,
      (index) => AutoScrollTag(
          key: ValueKey(index),
          controller: controllerRoom,
          index: index,
          child: GestureDetector(
            onTap: () {
              setState(() {
                homeId = _placeList[index].homeId;
              });
              getRoom();
            },
            // onTapDown: (TapDownDetails details) {
            //   Vibration.vibrate(duration: 100);
            //   setState(() {
            //     placeList[index].setImage("assets/images/menuitemselect.png");
            //   });
            //
            //   showToastFun(context, '${placeList[index].getName()} is Apply');
            // },
            // onTapUp: (TapUpDetails details) {
            //   setState(() {
            //     placeList[index].setImage("assets/images/menuitem.png");
            //   });
            // },
            child: getHomeHorizontalItem1(
                context,
                false,
                _placeList[index].homeName!,
                screenHeight,
                screenWidth,
                getHeight(screenHeight, optionsNextButtonHeight),
                getWidth(screenWidth, optionsNextButtonWidth)),
          )),
    );
  }

  List<Widget> getRoomList1(
      BuildContext context, double screenWidth, double screenHeight) {
    return itemsRoom = List.generate(
        _roomList.length,
        (index) => AutoScrollTag(
              key: ValueKey(index),
              controller: controllerRoom,
              index: index,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      roomId = _roomList[index].roomId;
                    });
                  },
                  child: getHomeHorizontalItem1(
                      context,
                      false,
                      _roomList[index].roomName!,
                      screenHeight,
                      screenWidth,
                      getHeight(screenHeight, optionsNextButtonHeight),
                      getWidth(screenWidth, optionsNextButtonWidth)),
                  //   child: getHomeHorizontalItem(
                  //       roomList[index].getImage(),
                  //       roomList[index].getName(),
                  //       height,
                  //       width,
                  //       getHeight(height, 38.96),
                  //       getWidth(width, 74.89)),
                  // )
                  ),
            ));
  }

  List<Widget> getRoomList(
      BuildContext context, double screenWidth, double screenHeight) {
    return itemsRoom = List.generate(
      4,
      (index) => AutoScrollTag(
          key: ValueKey(index),
          controller: controllerRoom,
          index: index,
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              Vibration.vibrate(duration: 100);
              setState(() {
                roomList[index].setImage("assets/images/menuitemselect.png");
              });

              showToastFun(context, '${roomList[index].getName()} is Apply');
            },
            onTapUp: (TapUpDetails details) {
              setState(() {
                roomList[index].setImage("assets/images/menuitem.png");
              });
            },
            child: getHomeHorizontalItem1(
                context,
                false,
                roomList[index].getName(),
                screenHeight,
                screenWidth,
                getHeight(screenHeight, 38.96),
                getWidth(screenWidth, 74.44)),
          )),
    );
  }

  // List<Widget> getIRList() {
  //   return itemsIR = List.generate(
  //     irList.length,
  //     (index) => AutoScrollTag(
  //         key: ValueKey(index),
  //         controller: controllerIR,
  //         index: index,
  //         child: GestureDetector(
  //           onTapDown: (TapDownDetails details) {
  //             Vibration.vibrate(duration: 100);
  //             setState(() {
  //               irList[index].setImage("assets/images/select.png");
  //             });
  //             showToastFun(context, '${irList[index].getName()} is Apply');
  //           },
  //           onTapUp: (TapUpDetails details) {
  //             setState(() {
  //               irList[index].setImage("assets/images/listitem.png");
  //             });
  //           },
  //           child: getHomeHorizontalItem(
  //               irList[index].getImage(), irList[index].getName()),
  //         )),
  //   );
  // }

  // List<Widget> getSwitchList() {
  //   return itemsSwitch = List.generate(
  //     switchList.length,
  //     (index) => AutoScrollTag(
  //         key: ValueKey(index),
  //         controller: controllerSwitch,
  //         index: index,
  //         child: GestureDetector(
  //           onTapDown: (TapDownDetails details) {
  //             Vibration.vibrate(duration: 100);
  //             setState(() {
  //               switchList[index].setImage("assets/images/select.png");
  //             });
  //             showToastFun(context, '${switchList[index].getName()} is Apply');
  //           },
  //           onTapUp: (TapUpDetails details) {
  //             setState(() {
  //               switchList[index].setImage("assets/images/listitem.png");
  //             });
  //           },
  //           child: getHomeHorizontalItem(
  //               switchList[index].getImage(), switchList[index].getName()),
  //         )),
  //   );
  // }

  double getWidth(double swidth, double cwidth) {
    return ((swidth * cwidth) / 411.42857142857144);
  }

  double getHeight(double sheight, double cheight) {
    return (sheight * cheight) / 843.4285714285714;
  }

  double getX(double swidth, double componetXPos) {
    return ((swidth * componetXPos) / 411.42857142857144);
  }

  double getY(double sheight, double componentYPos) {
    return (sheight * componentYPos) / 843.4285714285714;
  }

  double getNextFenControlPosition(
      int listLength, double controlHeight, double controlSpace) {
    return ((controlHeight * ((listLength % 5) + 1)) +
        ((listLength % 4) * controlSpace));
  }

  Widget buildItem(LightItem lightItem, double height, double width) {
    return GestureDetector(
        onTap: () {
          Vibration.vibrate(duration: 100);
          setState(() {
            if (lightItem.getImage() == "assets/images/lightunselect.png") {
              lightItem.setImage("assets/images/lightselect.png");
              lightItem.setSelectd(true);
            } else {
              lightItem.setImage("assets/images/lightunselect.png");
              lightItem.setSelectd(false);
            }
          });
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(lightItem.getImage(),
                height: getHeight(height, 53.06),
                width: getWidth(width, 74.09),
                fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                  child: Text(lightItem.getName(),
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          fontSize: getAdaptiveTextSize(context, 10.3)),
                      textAlign: TextAlign.center)),
            ),
          ],
        ));
  }

  void openDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      //barrierColor: Colors.black38,
      barrierLabel: 'Label',
      barrierDismissible: true,
      pageBuilder: (_, __, ___) => Center(
        child: Material(
          color: Colors.transparent,
          child: Text(
            'Dialog',
            style: TextStyle(
                color: Colors.black,
                fontSize: getAdaptiveTextSize(context, 40)),
          ),
        ),
      ),
    );
  }

  void onCreateRoom(BuildContext context, double height, double width) {
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
            // Aligns the container to center
            child: Container(
          width: getWidth(width, 235),
          height: getHeight(height, 210),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(14.86390495300293)),
              border: Border.all(
                  color: const Color(0xffeceded), width: 1.0617074966430664),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(5.308538436889648, 5.308538436889648),
                    blurRadius: 6.370244979858398,
                    spreadRadius: 0)
              ],
              color: const Color(0xff484949)),
//color: Colors.white,

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.clear,
                    color: Colors.red,
                    size: 20,
                  )
                ],
              ),
              SizedBox(
                height: getHeight(height, 20),
              ),
              Container(
                  width: getWidth(width, 341),
                  height: getHeight(height, 45.62),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0x80eceded), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 3),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xb81b1918)),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: textFormField(
                      context,
                      hintText: "Enter Room Name",
                      controller: roomController,
                      hintStyle: hintTextStyle(context),
                      // obscureText: true,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                        //LengthLimitingTextInputFormatter(10),
                      ],
                      onFieldSubmitted1: (value) {},
                      // onEditingComplete: () => node.nextFocus(),
                      textInputAction: TextInputAction.done,
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  addRoomFun();
                },
                child: Container(
                    margin: EdgeInsets.only(top: getHeight(height, 10)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset("assets/images/select.png",
                            height: getHeight(height, 41),
                            width: getWidth(width, 78.02),
                            fit: BoxFit.fill),
                        Positioned.fill(
                          child: Align(
//alignment: Alignment.topCenter,
                              child: Text("DONE",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize:
                                          getAdaptiveTextSize(context, 10.3)),
                                  textAlign: TextAlign.center)),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: getHeight(height, 10),
              ),
            ],
          ),
        )),
      ),
    );
  }

  onCreateHome(BuildContext context, double height, double width) {
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
            // Aligns the container to center
            child: Container(
          width: getWidth(width, 235),
          height: getHeight(height, 210),
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(width, 10), vertical: getHeight(height, 10)),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(14.86390495300293)),
              border: Border.all(
                  color: const Color(0xffeceded), width: 1.0617074966430664),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(5.308538436889648, 5.308538436889648),
                    blurRadius: 6.370244979858398,
                    spreadRadius: 0)
              ],
              color: const Color(0xff484949)),
//color: Colors.white,

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.clear,
                    color: Colors.red,
                    size: 20,
                  )
                ],
              ),
              SizedBox(
                height: getHeight(height, 20),
              ),
              Container(
                  width: getWidth(width, 341),
                  height: getHeight(height, 45.62),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0x80eceded), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 3),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xb81b1918)),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: textFormField(
                      context,
                      hintText: "Enter Home Name",
                      hintStyle: hintTextStyle(context),
                      // obscureText: true,
                      controller: homeController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                        //LengthLimitingTextInputFormatter(10),
                      ],
                      onFieldSubmitted1: (value) {},
                      // onEditingComplete: () => node.nextFocus(),
                      textInputAction: TextInputAction.done,
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  addhomeFun();
                },
                child: Container(
                    margin: EdgeInsets.only(top: getHeight(height, 10)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset("assets/images/select.png",
                            height: getHeight(height, 41),
                            width: getWidth(width, 78.02),
                            fit: BoxFit.fill),
                        Positioned.fill(
                          child: Align(
//alignment: Alignment.topCenter,
                              child: Text("DONE",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize:
                                          getAdaptiveTextSize(context, 10.3)),
                                  textAlign: TextAlign.center)),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: getHeight(height, 10),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void addhomeFun() async {
    String? appuserId = await LocalStorageService.getUserId();
    String? appId = await LocalStorageService.getAppId();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
    DateTime dateTime = DateTime.parse("$formattedDate+05:30");

    String? token = await LocalStorageService.getToken();
    print(token);
    print(appuserId);
    print(appId);

    RequestHome requestHome = RequestHome(
        applicationId: appId,
        name: homeController.text.toString(),
        appUserId: appuserId,
        createdBy: appuserId,
        createdDateTime: "${dateTime.toLocal().toIso8601String()}+05:30");

    print(requestHome.toJson().toString());

    ResponseHome? responseHome = await viewModelHome.addHome(requestHome);
    if (responseHome!.value!.meta!.code == 1) {
      Navigator.pop(context);
      homeController.clear();
      getHome();
    }
  }

  void addRoomFun() async {
    String? appuserId = await LocalStorageService.getUserId();
    String? appId = await LocalStorageService.getAppId();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
    DateTime dateTime = DateTime.parse("$formattedDate+05:30");

    RequestRoom requestRoome = RequestRoom(
      applicationId: appId,
      homeId: homeId,
      roomName: roomController.text.toString(),
      appUserId: appuserId,
      createdDateTime: "${dateTime.toLocal().toIso8601String()}+05:30",
      createdBy: appuserId,
    );
    print(requestRoome.toJson().toString());

    ResponseRoom? responseRoom = await viewModelRoom.addRoom(requestRoome);
    if (responseRoom!.value!.meta!.code == 1) {
      Navigator.pop(context);
      roomController.clear();
      getRoom();
    }
  }

  void sendFastblikling() async {
    wifiUsername = await LocalStorageService.getWifi();
    wifiPassword = await LocalStorageService.getWifiPassword();
    await widget.device.requestMtu(500);
    for (BluetoothService service in widget.services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          characteristic.write(utf8.encode(pairingKey()),
              withoutResponse: true);
          getreaddata();
        }
      }
    }
  }

  Future<void> createMeshWithHomeId() async {
    print("Inside Mesh");
    await widget.device.requestMtu(500);
    for (BluetoothService service in widget.services) {
      print("Inside For Mesh");
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          print("Inside If Mesh");
          // await characteristic.write(utf8.encode(ledStopBlink()),
          //     withoutResponse: true);

          //await getMeshWithHomeIdRead();
        }
      }
    }
  }

  Future<void> createWifiRouterCommand() async {
    print("Inside WIFI");
    await widget.device.requestMtu(500);
    for (BluetoothService service in widget.services) {
      print("Inside WIFI");
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          print("Inside WIFI");
          await characteristic.write(utf8.encode(appSendsSsidPassword()),
              withoutResponse: true);
        }
      }
    }
  }

  Future<void> createLedStopCommand() async {
    print("Inside LedStop");
    await widget.device.requestMtu(500);
    for (BluetoothService service in widget.services) {
      print("Inside For LedStop");
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          print("Inside If LedStop");
          // await characteristic.write(utf8.encode(ledStopBlink1()),
          //     withoutResponse: true);
        }
      }
    }
  }

  String appSendsSsidPassword() {
    CommunicationCommand communicationCommand = CommunicationCommand(
        key: "NO KEY",
        commandCode:
            "55 0D DD DD FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA",
        ssidOfWifiRouter: wifiUsername,
        password: wifiPassword);
    return jsonEncode(communicationCommand);
  }

  Future<void> createHomeStatus() async {
    print("Inside Status");
    await widget.device.requestMtu(500);
    for (BluetoothService service in widget.services) {
      print("Inside For Status");
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          print("Inside If Status");
          await characteristic.write(utf8.encode(homeStatus()),
              withoutResponse: true);

          // await getStatusToRead();
        }
      }
    }
  }

  String homeStatus() {
    HomeStatus homeStatus = HomeStatus(
        key: "NO KEY",
        commandCode:
            "55 0D FF FF FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA",
        mobileNumber: mobileNumber,
        appId: applicationId,
        roomId: roomId);

    return jsonEncode(homeStatus);
  }

  // String ledStopBlink() {
  //   LedStopBlinking ledStopBlinking = LedStopBlinking(
  //       key: "NO KEY",
  //       commandCode:
  //           "55 0D CC CC FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA",
  //       homeId: homeId,
  //       roomId: roomId,
  //       mobileNumber: mobileNumber,
  //       appId: applicationId);
  //
  //   return jsonEncode(ledStopBlinking);
  // }

  // String ledStopBlink1() {
  //   LedStopBlinking ledStopBlinking = LedStopBlinking(
  //       key: "NO KEY",
  //       commandCode:
  //           "55 05 EE EE FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA",
  //       homeId: homeId,
  //       roomId: roomId,
  //       mobileNumber: mobileNumber,
  //       appId: applicationId);
  //
  //   return jsonEncode(ledStopBlinking);
  // }

  String pairingKey() {
    CommunicationCommandPairing communicationCommand =
        CommunicationCommandPairing(
      CMID: "PAIRING",
      commandCode:
          "55 0D BB BB FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA",
    );

    return jsonEncode(communicationCommand);
  }

  late final NordicNrfMesh nordicNrfMesh = NordicNrfMesh();
  void getreaddata() async {
    for (BluetoothService service in widget.services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          characteristic.value.listen((value) async {
            setState(() {
              readValues[characteristic.uuid] = value;
            });

            print("getreaddata ${utf8.decode(value)}");
            if (value.isNotEmpty) {
              String data = utf8.decode(value);

              Map<String, dynamic> map =
                  jsonDecode(data); // import 'dart:convert';

              String commandCode = map['COMMAND CODE'];

              String firstByte =
                  commandCode.replaceAll(' ', '').substring(0, 2);

              String lastByte = commandCode
                  .replaceAll(' ', '')
                  .substring(commandCode.replaceAll(' ', '').length - 2);

              String secondByte =
                  commandCode.replaceAll(' ', '').substring(2, 4);

              String thirdByte =
                  commandCode.replaceAll(' ', '').substring(4, 6);

              String fourthByte =
                  commandCode.replaceAll(' ', '').substring(6, 8);

              print("firstTwo ${firstByte}");
              print("lastTwo ${lastByte}");
              print("Second ${secondByte}");
              print("Third ${thirdByte}");
              print("Fourth ${fourthByte}");

              if (firstByte == "44" && lastByte == "BB") {
                if (thirdByte == "BB" && fourthByte == "BB") {
                  await createMeshWithHomeId();
                } else if (thirdByte == "CC" && fourthByte == "CC") {
                  await createWifiRouterCommand();
                } else if (thirdByte == "DD" && fourthByte == "DD") {
                  await createLedStopCommand();
                } else if (thirdByte == "EE" && fourthByte == "EE") {
                  await createHomeStatus();
                } else if (thirdByte == "FF" && fourthByte == "FF") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(nordicNrfMesh)),
                  );
                }
              }
            }
          });
          await characteristic.setNotifyValue(true);
        }
      }
    }

  }

  void getHome() async {
    applicationId = await LocalStorageService.getAppId();
    String? userId = await LocalStorageService.getUserId();
    mobileNumber = await LocalStorageService.getMobileNumber();

    RequestHomeList requestHomeList =
        RequestHomeList(applicationId: applicationId, appuserId: userId);
    ResponseHomeList? responseHomeList =
        await viewModelHome.homeList(requestHomeList);
    if (responseHomeList!.value!.meta!.code == 1) {
      print("inside If");
      setState(() {
        _placeList = responseHomeList.value!.appUserAccessPermissions!;
        homeId = _placeList[0].homeId;
      });
      getRoom();
    }
  }

  void getRoom() async {
    String? userId = await LocalStorageService.getUserId();
    RequestRoomList requestRoomList = RequestRoomList(
      appuserId: userId,
      applicationId: applicationId,
      homeId: homeId,
    );

    ResponseRoomList? responseRoomList =
        await viewModelRoom.roomList(requestRoomList);
    if (responseRoomList!.value!.meta!.code == 1) {
      setState(() {
        _roomList = responseRoomList.value!.appUserAccessPermissionsRoom!;
        roomId = _roomList[0].roomId;
      });
    }
  }
}

class Item extends StatelessWidget {
  final String itemName;
  final bool selectedItem;
  final VoidCallback navigationHandler;

  Item(this.itemName, this.selectedItem, this.navigationHandler);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: 10,
      child: TextButton(
        onPressed: navigationHandler,
        child: Text(
          itemName,
          style: selectedItem
              ? Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 14,
                  )
              : Theme.of(context).textTheme.headline6?.copyWith(
                    color: const Color(0xff707070),
                    fontSize: 14,
                  ),
        ),
      ),
    );
  }
}
