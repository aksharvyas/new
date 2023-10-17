import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:vibration/vibration.dart';

import '../../../models/LightItem.dart';
import '../../../models/publishdata.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../widget.dart';
import 'HomePageACRemote.dart';
import 'HomePageACRemoteButtons.dart';
import 'HomePageHomeRemoteButtons.dart';
import 'HomePageSTBRemote.dart';
import 'HomePageSTBRemoteButtons.dart';
import 'HomePageTVRemote.dart';
import 'HomePageTVRemoteButtons.dart';

class HomePageBody extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double top6;
  double extendHeight;
  MqttServerClient client;
  HomePageBody(this.screenWidth, this.screenHeight, this.top6, this.extendHeight, this.client, {Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  var lightList = [
    // LightItem('SW 01', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 02', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 03', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 04', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 05', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 06', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // //LightItem('SW 07', lightAmpUnSelectedImage, false, false, false,  false, FocusNode()),
    // LightItem('SW 07', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 08', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 09', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 10', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 11', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 12', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 13', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 14', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 15', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 16', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 17', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 18', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 19', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 20', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 21', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 22', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 23', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 24', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 25', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 26', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 27', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 28', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 29', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 30', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 31', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
    // LightItem('SW 32', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
  ];

  final List<DraggableGridItem> _listOfDraggableGridItem = [];
  final FixedExtentScrollController _scrollController = FixedExtentScrollController(initialItem: 1);
  final FixedExtentScrollController _scrollController1 = FixedExtentScrollController(initialItem: 1);
  int selected = 4;
  int selected1 = 4;
  double itemWidth = 35.0;
  double itemWidth1 = 35.0;
  int itemCount = 9;
  int itemCount1 = 9;

  @override
  Widget build(BuildContext context) {

    double fanVerticalPosition = getNextFanControlPosition(lightList.length, 66, getHeight(widget.screenHeight, 35));

    return Positioned(
      top: getY(widget.screenHeight, widget.top6),
      left: getX(widget.screenWidth, 32.54),
      right: getX(widget.screenWidth, 32.54),
      child: SizedBox(
        width: getWidth(widget.screenWidth, widget.screenWidth),
        height: getHeight(widget.screenHeight, widget.extendHeight - 20),
        child: PageView.builder(
          // controller: _controller,
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, i) =>
          i == 0
              ? Stack(
            children: [
              ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                        width: getWidth(widget.screenWidth, widget.screenWidth),
                        //height: getHeight(height, 700),
                        height:
                        fanVerticalPosition + getHeight(widget.screenHeight, 100),
                        child: Stack(
                          children: [
                            SizedBox(
                              // width: getWidth(
                              //     width, width - 32.54 - 32.54),
                                width: getWidth(widget.screenWidth, widget.screenWidth),
                                //height: getHeight(height, 290),
                                child: DraggableGridViewBuilder(
                                  // padding: const EdgeInsets.only(
                                  //     top: 10.18),
                                    padding: EdgeInsets.only(
                                        top: getHeight(widget.screenHeight, 10.18)),
                                    physics:
                                    const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    // scrollDirection:
                                    //     Axis.vertical,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      //crossAxisSpacing: 10,
                                      mainAxisSpacing:
                                      getHeight(widget.screenHeight, 35),
                                      mainAxisExtent: 66,
                                      childAspectRatio: 4 / 1.5,
                                    ),
                                    dragCompletion:
                                        (List<DraggableGridItem> list,
                                        int beforeIndex,
                                        int afterIndex) {},
                                    children: getDragList(widget.screenWidth, widget.screenHeight),
                                    isOnlyLongPress: true,
                                    dragPlaceHolder:
                                        (List<DraggableGridItem> list,
                                        int index) {
                                      return PlaceHolderWidget(
                                          child: list[i].child);
                                    })),
                            Positioned(
                              // top: getY(height, 470.20) +
                              //     getNextFenControlPosition(
                              //         lightList.length, 53.06, 35),
                                top: fanVerticalPosition,
                                left: getX(widget.screenWidth, 95.99 - 32.54),
                                child: Text("FAN 1",
                                    style: TextStyle(
                                        color: const Color(0xffdededd),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter",
                                        fontStyle: FontStyle.normal,
                                        fontSize: getAdaptiveTextSize(
                                            context, 12.5)),
                                    textAlign: TextAlign.center)),
                            Positioned(
                              // top: getY(height, 470.20) +
                              //     getNextFenControlPosition(
                              //         lightList.length, 53.06, 35),
                                top: fanVerticalPosition,
                                left: getX(widget.screenWidth, 281.27 - 32.54),
                                child: Text("FAN 2",
                                    style: TextStyle(
                                        color: const Color(0xffdededd),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter",
                                        fontStyle: FontStyle.normal,
                                        fontSize: getAdaptiveTextSize(
                                            context, 12.5)),
                                    textAlign: TextAlign.center)),
                            Positioned(
                              // top: getY(height, 490.20) +
                              //     getNextFenControlPosition(
                              //         lightList.length, 53.06, 35),
                              top: fanVerticalPosition +
                                  getHeight(widget.screenHeight, 20),
                              left: getX(widget.screenWidth, 31.63 - 32.54),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image.asset(
                                      'assets/images/fanbutton.png',
                                      height: getHeight(widget.screenHeight, 53.64),
                                      width: getWidth(widget.screenWidth, 167.49),
                                      fit: BoxFit.fill),
                                  Positioned.fill(
                                      left: getX(widget.screenWidth, 5),
                                      right: getX(widget.screenWidth, 5),
                                      child: RotatedBox(
                                          quarterTurns: -1,
                                          child: ListWheelScrollView(
                                            magnification: 2.0,
                                            onSelectedItemChanged: (x) {
                                              setState(() {
                                                selected1 = x;
                                              });
                                            },
                                            controller:
                                            _scrollController1,
                                            itemExtent: getWidth(
                                                widget.screenWidth, itemWidth1),
                                            children: List.generate(
                                                itemCount1,
                                                    (x) =>
                                                    RotatedBox(
                                                        quarterTurns: 1,
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              top: getHeight(
                                                                  widget.screenHeight, 5),
                                                              bottom:
                                                              getHeight(
                                                                  widget.screenHeight,
                                                                  5)),
                                                          child:
                                                          AnimatedContainer(
                                                              decoration: x ==
                                                                  selected1
                                                                  ? const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/fanbackground.png'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      scale:
                                                                      1))
                                                                  : const BoxDecoration(),
                                                              duration: const Duration(
                                                                  milliseconds:
                                                                  400),
                                                              width: x ==
                                                                  selected1
                                                                  ? getWidth(
                                                                  widget.screenWidth,
                                                                  60)
                                                                  : getWidth(
                                                                  widget.screenWidth,
                                                                  50),
                                                              height: x ==
                                                                  selected1
                                                                  ? getHeight(
                                                                  widget.screenHeight,
                                                                  60)
                                                                  : getHeight(
                                                                  widget.screenHeight,
                                                                  50),
                                                              alignment:
                                                              Alignment
                                                                  .center,
                                                              child: Text(
                                                                (x + 1)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: x ==
                                                                        selected1
                                                                        ? getAdaptiveTextSize(
                                                                        context,
                                                                        18)
                                                                        : getAdaptiveTextSize(
                                                                        context,
                                                                        12)),
                                                              )),
                                                        ))),
                                          ))),
                                ],
                              ),
                            ),
                            Positioned(
                              // top: getY(height, 490.20) +
                              //     getNextFenControlPosition(
                              //         lightList.length, 53.64, 35),
                              top: fanVerticalPosition +
                                  getHeight(widget.screenHeight, 20),
                              left: getX(widget.screenWidth, 217.33 - 38.54),
                              child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Image.asset(
                                        'assets/images/fanbutton.png',
                                        height: getHeight(widget.screenHeight, 53.64),
                                        width: getWidth(widget.screenWidth, 167.49),
                                        fit: BoxFit.fill),
                                    Positioned.fill(
                                        left: getX(widget.screenWidth, 5),
                                        right: getX(widget.screenWidth, 5),
                                        child: RotatedBox(
                                            quarterTurns: -1,
                                            child: ListWheelScrollView(
                                              magnification: 2.0,
                                              onSelectedItemChanged: (x) {
                                                setState(() {
                                                  selected = x;
                                                });
                                              },
                                              controller:
                                              _scrollController,
                                              itemExtent: getWidth(
                                                  widget.screenWidth, itemWidth),
                                              children: List.generate(
                                                  itemCount,
                                                      (x) =>
                                                      RotatedBox(
                                                          quarterTurns: 1,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                top: getHeight(
                                                                    widget.screenHeight,
                                                                    5),
                                                                bottom:
                                                                getHeight(
                                                                    widget.screenHeight,
                                                                    5)),
                                                            child:
                                                            AnimatedContainer(
                                                                decoration: x ==
                                                                    selected
                                                                    ? const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/images/fanbackground.png'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        scale:
                                                                        1))
                                                                    : const BoxDecoration(),
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                    400),
                                                                width: x ==
                                                                    selected
                                                                    ? getWidth(
                                                                    widget.screenWidth,
                                                                    60)
                                                                    : getWidth(
                                                                    widget.screenWidth,
                                                                    50),
                                                                height: x ==
                                                                    selected
                                                                    ? getHeight(
                                                                    widget.screenHeight,
                                                                    60)
                                                                    : getHeight(
                                                                    widget.screenHeight,
                                                                    50),
                                                                alignment:
                                                                Alignment
                                                                    .center,

                                                                //color: Colors.white,
                                                                // decoration: BoxDecoration(
                                                                //     color: x == selected ? Colors.red : Colors.grey,
                                                                //     ),
                                                                child: Text(
                                                                  (x + 1)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: x ==
                                                                          selected
                                                                          ? getAdaptiveTextSize(
                                                                          context,
                                                                          18)
                                                                          : getAdaptiveTextSize(
                                                                          context,
                                                                          12)),
                                                                )),
                                                          ))),
                                            ))),
                                  ]),
                            ),
                          ],
                        )),
                  ])
            ],
          )
              // : i == 1
              // ? HomePageTVRemote(widget.screenWidth, widget.screenHeight)
              // : i == 2
              // ? HomePageTVRemoteButtons(widget.screenWidth, widget.screenHeight)
              // : i == 3
              // ? HomePageACRemote(widget.screenWidth, widget.screenHeight)
              // : i == 4
              // ? HomePageACRemoteButtons(widget.screenWidth, widget.screenHeight)
              // : i == 5
              // ? HomePageSTBRemote(widget.screenWidth, widget.screenHeight)
              // : i == 6
              // ? HomePageSTBRemoteButtons(widget.screenWidth, widget.screenHeight)
              // : i == 7
              // ? HomePageHomeRemoteButtons(widget.screenWidth, widget.screenHeight)
              : Container(),
        ),
      ),
    );
  }

  List<DraggableGridItem> getDragList(double width, double height) {
    _listOfDraggableGridItem.clear();

    for (int i = 0; i < lightList.length; i++) {
      if (i != 6) {
        _listOfDraggableGridItem.add(DraggableGridItem(
            child: buildItem(lightList[i], height, width), isDraggable: true));
      } else {
        _listOfDraggableGridItem.add(DraggableGridItem(
            child: buildItem3A(lightList[6], height, width),
            isDraggable: true));
      }
    }
    return _listOfDraggableGridItem;
  }

  Widget buildItem(LightItem lightItem, double height, double width) {
    return GestureDetector(
        onTap: () {
          Utils.vibrateSound();
          setState(() {
            if (lightItem.getImage() == "assets/images/lightunselect.png") {
              lightItem.setImage("assets/images/lightselect.png");
              lightItem.setSelectd(true);
            } else {
              lightItem.setImage("assets/images/lightunselect.png");
              lightItem.setSelectd(false);
            }
          });

          PublishMessage publishMessage = PublishMessage(
              homeId: "efd370fc-7701-48c7-8046-d58ecf2a88bc",
              cmacId: "BF67D391-88BC-4474-B4B4-176C0864BB62",
              appId: "2e6801d6-906c-4df0-8107-248ebe060c25",
              mobileNumber: "919998987238",
              commandCode: "55 0D 22 10 FD 07 01 04 FD AA",
              key: "L1",
              function: "SWITCH 1 ON");
          publish(payloadToJson1(publishMessage).toString(),
              'efd370fc-7701-48c7-8046-d58ecf2a88bc/OPERATE');
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(lightItem.getImage(),
                height: getHeight(height, 53.64),
                width: getWidth(width, 74.09),
                fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
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

  Widget buildItem3A(LightItem lightItem, double height, double width) {
    return GestureDetector(
        onTap: () {
          Utils.vibrateSound();
          setState(() {
            if (lightItem.getImage() == "assets/images/lightunselect.png") {
              lightItem.setImage("assets/images/lightselect.png");
              lightItem.setSelectd(true);
            } else {
              lightItem.setImage("assets/images/lightunselect.png");
              lightItem.setSelectd(false);
            }
          });
          ;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(lightItem.getImage(),
                height: getHeight(height, 65.78),
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

  Future<void> publish(String text, String topic) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(text.toString());

    print("clientPayloadBuilder 3" + builder.payload.toString());
    if (widget.client != null) {
      print("clientPayloadBuilder 4" + text.toString());
      widget.client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
    } else {
      print("inside client");
    }
  }

}
