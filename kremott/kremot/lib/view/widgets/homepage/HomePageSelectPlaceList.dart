import 'package:flutter/material.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../../../global/storage.dart';
import '../../../models/HomeListModel.dart';
import '../../../models/PlaceItem.dart';
import '../../../utils/Constants.dart';
import '../../../view_model/HomeVM.dart';
import '../widget.dart';

class HomePageSelectPlaceList extends StatefulWidget {
  double screenWidth;
  double screenHeight;

  HomePageSelectPlaceList(this.screenWidth, this.screenHeight, {Key? key}) : super(key: key);

  @override
  State<HomePageSelectPlaceList> createState() => _HomePageSelectPlaceListState();
}

class _HomePageSelectPlaceListState extends State<HomePageSelectPlaceList> {

  List<Widget> itemsHomeRemotePlaces = [];
  final HomeVM viewModelHome = HomeVM();
  bool isSelected=false;
  List<Map<String, dynamic>> listMapOptions = [];
  List<Map<String, dynamic>> listMapPlaces = [];
  String? homeId="";
  var placeList = [
    PlaceItem('HOME', "assets/images/listitem.png"),
    PlaceItem('OFFICE', "assets/images/listitem.png"),
    PlaceItem('SHOP', "assets/images/listitem.png"),
  ];
  final AutoScrollController controllerHomeRemotePlace = AutoScrollController();

  @override
  void initState() {
    getHome();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: controllerHomeRemotePlace,
        shrinkWrap: true,
        itemCount: listMapPlaces.length,
        itemBuilder: (context, index){
          return AutoScrollTag(
              key: ValueKey(index),
              controller: controllerHomeRemotePlace,
              index: index,
              child: GestureDetector(
                onTapDown: (TapDownDetails details) async{
                  Vibration.vibrate(duration: 100);

                    var homeId= listMapPlaces[index]['homeId'];
                  var name= listMapPlaces[index]['name'];
                  print("Jigarhomeselecte="+name.toString());
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('homeId', homeId);
                  prefs.setString('name', name);
                      for (int i = 0;
                      i < listMapPlaces.length;
                      i++) {
                        setState(() {
                          listMapPlaces[i]['selected']=false;
                        });
                      }
                  setState(() {
                  listMapPlaces[index]['selected']=true;
                  });
                    print("Tabb details"+details.toString());

                  },


                  // showToastFun(
                  //     context, '${placeList[index].getName()} is Apply');

                onTapUp: (TapUpDetails details) {
                  // setState(() {
                  //   placeList[index].setImage("assets/images/listitem.png");
                  // });
                },
                child: getHomeHorizontalItem(
                    context,
                    listMapPlaces[index]['selected'],
                    listMapPlaces[index]['name'],
                    widget.screenHeight,
                    widget.screenWidth,
                    getHeight(widget.screenHeight, optionsNextButtonHeight),
                    getWidth(widget.screenWidth, optionsNextButtonWidth)),
              ));
    }
    );
  }
  void getHome() async {
    applicationId = await LocalStorageService.getAppId();
    String? userId = await LocalStorageService.getUserId();
    print("called inside the method=================");
    print(applicationId);
    print(userId);
    // mobileNumber = await LocalStorageService.getMobileNumber();

    RequestHomeList requestHomeList =
    RequestHomeList(applicationId: applicationId, appuserId: userId);
    print(requestHomeList.toJson().toString());
    ResponseHomeList? responseHomeList =
    await viewModelHome.homeList(requestHomeList);
    if (responseHomeList!.value!.meta!.code == 1) {
      print("inside If");

      for (int i = 0;
      i < responseHomeList.value!.appUserAccessPermissions!.length;
      i++) {
        setState(() {
          Map<String, dynamic> mapPlace = {};
          mapPlace['name'] =
              responseHomeList.value!.appUserAccessPermissions![i].homeName;
          mapPlace['homeId'] =
              responseHomeList.value!.appUserAccessPermissions![i].homeId;
          mapPlace['selected'] = false;
          homeId = responseHomeList.value!.appUserAccessPermissions![0].homeId;

          debugPrint('Console Message Using Debug Print');
          listMapPlaces.add(mapPlace);

        });
      }
      print("homeid============="+homeId.toString());
    }

    // getRoom();
  }
}
