import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:fitness_ble_app/src/app.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/GlobalBloc.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/bloc_provider.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/patientmodel_bloc.dart';
import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/add_patient_page.dart';
import 'package:fitness_ble_app/src/app/screen/model/add_patient_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/dashboard_card_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/login_page.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'ble_listing_page.dart';
import 'package:open_file/open_file.dart';

class PatientListPage extends StatefulWidget {
  ListPatientsData? listPatientsData;

  PatientListPage({this.listPatientsData});

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  @override
  void initState() {
    // TODO: implement initState
    LocalStorageService.setLastScreen("/PatientListPage");

    super.initState();

    // _sc.addListener(() {
    //   if (_sc.position.pixels == _sc.position.maxScrollExtent) {
    //     listPatient(page_number,currentlength);
    //   }
    // });
    listPatient(page_number, currentlength);
  }

  ScrollController _sc = new ScrollController();
  List<ListPatientsData> list = [];
  int currentlength = 10;
  int page_number = 1;
  listPatient(page, currentlength) async {
    var request = {
      "per_page": currentlength.toString(),
    };

    ApiProvider apiProvider = ApiProvider();
    ResponseListPatients response = (await apiProvider.patientsList(request))!;

    List<ListPatientsData> listActivity = [];
    for (int i = 0; i < response.data.length; i++) {
      listActivity.add(response.data[i]);
    }

    print("patients list $list and length ${list.length}");
    setState(() {
      list.clear();
      list.addAll(listActivity);
      print("after patients list $list and length ${list.length}");
      page_number++;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    list.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SizedBox(
          width: double.infinity,
          height: 130,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(appBarPng),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: new Text("Fitness App"),
                                    content: new Text(
                                      "Are you sure, you want to logout?",
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          child: Text('No'),
                                          onPressed: () => {
                                            Navigator.pop(context),
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          child: Text('Yes'),
                                          onPressed: () => {
                                            Navigator.pop(context),
                                            LocalStorageService.onLogout(),
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()),
                                                    (Route<dynamic> route) =>
                                                        false),
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                top: 40,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      // image: new DecorationImage(
                      //   image: new AssetImage("assets/images/bhupesh.jpg"),
                      // ),
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              height: 50,
              width: 150,
              child: materialButtonWidget(
                  text: "Add Patient",
                  showLoader: false,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddPatientPage();
                    }));
                  })),
          SizedBox(
            height: 10,
          ),
          list == null
              ? Center(
                  child: Container(
                  child: CircularProgressIndicator(),
                ))
              : list.isEmpty
                  ? Center(
                      child: Text("No data, plz add patient"),
                    )
                  : Expanded(
                      flex: 120,
                      child: ListView.builder(
                          controller: _sc,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return cardWidget(list[index], context);
                          }),
                    ),

          //cardWidget(a,"")
        ],
      ),
    );
  }

  cardWidget(ListPatientsData addPatientModel, context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DashBoardCardPage(
              patientsData: addPatientModel,
            );
          }));
          BlocProvider.of<GlobalBloc>(context)
              .patientModelBloc
              .onChangePatientModel(addPatientModel);
        },
        child: Card(
          color: Colors.white60,
          child: Column(children: [
            ListTile(
              // leading: Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: CircleAvatar(
              //       radius: 25,
              //       child: Container(
              //         color: Colors.white,
              //       )),
              // ),
              title: Text(
                "${addPatientModel.firstName} ${addPatientModel.lastName}",
                style: cardTextStyle.copyWith(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
