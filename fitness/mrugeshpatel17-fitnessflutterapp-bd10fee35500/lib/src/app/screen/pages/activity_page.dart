import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:fitness_ble_app/src/app/screen/pages/rest_datepicker_page.dart';

///5
class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: GestureDetector(
            onTap: () async {},
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appBarPng),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            activityText,
            style: appbarTextStyle,
          ),
          //centerTitle: true,
          leadingWidth: 25,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Image.asset(
                backButtonPng,
              ),
            ),
          )),
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
                      image: AssetImage(tabBarPng), fit: BoxFit.fill),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RestDatePickerPage();
                          }));
                        },
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Text(
                            restText,
                            style: tabbarTextStyle,
                          ),
                        ))),
                    VerticalDivider(
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(walkText, style: tabbarTextStyle),
                    )),
                    VerticalDivider(
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(
                        runText,
                        style: tabbarTextStyle,
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [Text("radio dialar chart")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
