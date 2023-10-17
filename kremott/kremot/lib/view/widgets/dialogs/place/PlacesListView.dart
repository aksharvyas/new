import 'package:flutter/material.dart';
import '../../../../models/PlacesModel.dart';
import '../../../../view_model/RoomsVM.dart';
import 'PlaceDialog.dart';
import 'PlacesListViewItem.dart';

class PlacesListView extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  double buttonWidth;
  double buttonHeight;
  RoomsVM roomsVM;
  List<dynamic> placesList;
  Function selectedPlaceCallback;

  PlacesListView(this.screenWidth, this.screenHeight, this.buttonWidth, this.buttonHeight, this.roomsVM, this.placesList,this.selectedPlaceCallback, {Key? key}) : super(key: key);

  @override
  State<PlacesListView> createState() => _PlacesListViewState();
}

class _PlacesListViewState extends State<PlacesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        controller: controllerPlace,
        itemCount: widget.placesList.length,
        itemBuilder: (context, index) {
          return PlacesListViewItem(widget.screenWidth, widget.screenHeight, widget.buttonWidth, widget.buttonHeight, index, widget.placesList[index], widget.roomsVM, (){
            setState(() {
              for (int i=0;i<widget.placesList.length;i++) {
                widget.placesList[i].isSelected = false;
              }
              widget.placesList[index].isSelected = true;
            });
            if(widget.placesList[index].isSelected!){
              widget.selectedPlaceCallback(widget.placesList[index]);
            }
          });
          // return AutoScrollTag(
          //     key: ValueKey(index),
          //     controller: controllerPlace,
          //     index: index,
          //     child: GestureDetector(
          //       onTap: () {
          //         Vibration.vibrate(duration: 100);
          //         setState(() {
          //           widget.placesList[index].isSelected = true;
          //         });
          //
          //         RequestRooms requestRooms = RequestRooms(
          //             applicationId: "string",
          //             appuserId: "F4E182A3-A712-4249-A07D-1ACBD9A31F38",
          //             homeId: widget.placesList[index].homeId!);
          //         widget.roomsVM.getAllRooms(requestRooms);
          //       },
          //       child: Column(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Stack(
          //             alignment: Alignment.topCenter,
          //             children: [
          //               Image.asset(
          //                   widget.placesList[index].isSelected!
          //                       ? "assets/images/menuitemselect.png"
          //                       : "assets/images/menuitem.png",
          //                   height: getHeight(widget.height, 41),
          //                   width: getWidth(widget.width, 78.02),
          //                   fit: BoxFit.fill),
          //               Positioned.fill(
          //                 child: Align(
          //                   //alignment: Alignment.topCenter,
          //                     child: Text(widget.placesList[index].homeName!,
          //                         style: const TextStyle(
          //                             color: Color(0xffffffff),
          //                             fontWeight: FontWeight.w400,
          //                             fontFamily: "Inter",
          //                             fontStyle: FontStyle.normal,
          //                             decoration: TextDecoration.none,
          //                             fontSize: 10.3),
          //                         textAlign: TextAlign.center)),
          //               ),
          //             ],
          //           ),
          //           const SizedBox(
          //             height: 8,
          //           ),
          //         ],
          //       ),
          //     ));
        });
  }
}
