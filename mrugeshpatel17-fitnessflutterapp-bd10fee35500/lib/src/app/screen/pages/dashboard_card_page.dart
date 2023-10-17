

import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/googlemap_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/record_page.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/widgets.dart';
import 'package:fitness_ble_app/src/app/screen/pages/ble_listing_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/activity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'ble_listing_page.dart';


///2 (second screen)
class DashBoardCardPage extends StatefulWidget {
  ListPatientsData? patientsData;
  DashBoardCardPage({ this.patientsData});
  @override
  _DashBoardCardPageState createState() => _DashBoardCardPageState(patientsData!);
}

class _DashBoardCardPageState extends State<DashBoardCardPage> {

  ListPatientsData patientsData;
  _DashBoardCardPageState(this.patientsData);
  showDisconnect(String messages, BluetoothDevice d) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: new Text(messages),
            actions: <Widget>[

              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  d.disconnect();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return FitnessBLEApp();
                  }));

                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: GestureDetector(
            onTap: ()async{

              },
            child: Container(
              decoration:
              BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appBarPng),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text("${patientsData.firstName} ${patientsData.lastName}",style: appbarTextStyle,),
          //centerTitle: true,
          leadingWidth: 25,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
              },
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Image.asset(backButtonPng,),
            ),
          ),
        actions: [
          // FlatButton.icon(
          //   onPressed: (){
          //
          //
          //
          //
          //
          //
          //   },label: Text("Disconnect"),
          //   icon: Icon(Icons.bluetooth_disabled),
          //  ),
          // StreamBuilder<BluetoothDeviceState>(
          //   stream: widget.device.state,
          //   initialData: BluetoothDeviceState.connecting,
          //   builder: (c, snapshot) {
          //     VoidCallback onPressed;
          //     String text;
          //
          //     return FlatButton(
          //         onPressed: (){
          //           widget.device.disconnect();
          //           showDisconnect("Are you confirm to disconnect this device ${widget.device.name}",widget.device);
          //
          //
          //         },
          //         child: Text(
          //           'DISCONNECT',
          //           style: Theme.of(context)
          //               .primaryTextTheme
          //               .button
          //               .copyWith(color: Colors.white),
          //         ));
          //   },
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(tabBarPng),
                      fit: BoxFit.fill
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return  RecordPage(patientsData);
                      }));
                    },child: Text(recordText,style: tabbarTextStyle,)),
                    VerticalDivider(color: Colors.white,indent: 10,endIndent: 10,),
                    FlatButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return  ActivityPage();
                      }));


                    },child: Text(activityText,style: tabbarTextStyle)),
                    VerticalDivider(color: Colors.white,indent: 10,endIndent: 10,),
                    FlatButton(onPressed: (){ },child: Text(healthText,style: tabbarTextStyle)),
                  ],
                ),
              ),
              Container(
                child: Column(
                   children: [
                     Container(
                       padding: EdgeInsets.fromLTRB(15,10,15,15),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               SizedBox(width: 6,),
                               assetCircleImage(imageName: trainingModeIconPng),
                               SizedBox(width: 10,),
                               Text(trainingModeText,style: cardTextStyle,)
                             ],
                           ),
                           SizedBox(height: 8,),
                           InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return GoogleMapPage(patientsData);
                                 }));
                             },
                             child: Container(
                               width: MediaQuery.of(context).size.width * 0.9,
                               height: 180,
                               decoration: BoxDecoration(
                                 shape: BoxShape.rectangle,
                                 border: Border.all(color: Colors.blueAccent),
                                 borderRadius:BorderRadius.circular(20),
                                 image: DecorationImage(
                                     image: AssetImage(bicyclePng),
                                     fit: BoxFit.fill
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.fromLTRB(15,0,15,15),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               SizedBox(width: 6,),
                               assetCircleImage(imageName: monitoringModeIconPng),
                               SizedBox(width: 10,),
                               Text(monitoringModeText,style: cardTextStyle,)
                             ],
                           ),
                           SizedBox(height: 8,),
                           Container(
                             width: MediaQuery.of(context).size.width * 0.9,
                             height: 180,
                             decoration: BoxDecoration(
                               shape: BoxShape.rectangle,
                               border: Border.all(color: Colors.blueAccent),
                               borderRadius:BorderRadius.circular(20),
                               image: DecorationImage(
                                   image: AssetImage(joggingPng),
                                   fit: BoxFit.fill
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.fromLTRB(15,0,15,15),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               SizedBox(width: 6,),
                               assetCircleImage(imageName: managePastRecordingIconPng),
                               SizedBox(width: 10,),
                               Text(managePastRecordingText,style: cardTextStyle,)
                             ],
                           ),
                           SizedBox(height: 8,),
                           Container(
                             width: MediaQuery.of(context).size.width * 0.9,
                             height: 180,
                             decoration: BoxDecoration(
                               shape: BoxShape.rectangle,
                               border: Border.all(color: Colors.blueAccent),
                               borderRadius:BorderRadius.circular(20),
                               image: DecorationImage(
                                   image: AssetImage(cyclistPng),
                                   fit: BoxFit.fill
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
