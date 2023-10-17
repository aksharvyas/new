import 'package:admin/models/DeviceSwitchesModel.dart';
import 'package:admin/models/deleteSwitchModel.dart';
import 'package:admin/models/updateSwitchModel.dart';
import 'package:admin/screens/main/components/addSwitch.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../api_services.dart';
import '../../../constants.dart';
import '../../../controllers/MenuAppController.dart';
import '../../../controllers/routes.dart';
import '../../../models/SwitchesModel.dart';
import '../../../responsive.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Switches extends StatefulWidget {
  const Switches({Key? key}) : super(key: key);

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  initState() {
    super.initState();
    _getData();
  }

  List<DeviceSwitchesModel> DeviceSwitchList = [];
  List<SwitchesModel> SwitchList = [];
  int? id;
  void _getData() async {
    DeviceSwitchList =
        (await ApiServices().getDeviceSwitches())! as List<DeviceSwitchesModel>;
    SwitchList = (await ApiServices().getSwitches())! as List<SwitchesModel>;
    SwitchList[0]
        .value!
        .switchViewModel!
        .sort((a, b) => a.id!.compareTo(b.id!));
    print(SwitchList[0].value!.switchViewModel!.length);
    for (int i = 0; i < SwitchList[0].value!.switchViewModel!.length; i++) {
      id = SwitchList[0].value!.switchViewModel![i].id!;
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  final GlobalKey<ScaffoldState> sca = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: sca,
        drawer: SideMenu(),
        body: DeviceSwitchList.isEmpty || SwitchList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: defaultPadding, right: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  sca.currentState!.openDrawer();
                                },
                              ),
                              Text(
                                "Device Switches",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 0.5,
                                vertical: defaultPadding /
                                    (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddSwitch(
                                        DeviceSwitchList: DeviceSwitchList,
                                        dropdownVal: "",
                                        id: id!,
                                        isEditMode: false,
                                        prefix: "",
                                        userId: null,
                                      )));
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.875,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: SwitchList[0].value!.switchViewModel!.length,
                        itemBuilder: (BuildContext context, int index) {
                          double containerSize =
                              MediaQuery.of(context).size.height * 0.06;
                          double imageSize = containerSize * 0.6;

                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: (SwitchList[0]
                                                .value!
                                                .switchViewModel!
                                                .length) -
                                            1 ==
                                        index
                                    ? 0
                                    : MediaQuery.of(context).size.height *
                                        0.015),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: containerSize,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: imageSize,
                                          height: imageSize,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: EdgeInsets.all(0),
                                          child: ClipOval(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                child: CachedNetworkImage(
                                                  imageUrl: SwitchList[0]
                                                      .value!
                                                      .switchViewModel![index]
                                                      .buttonImage!,
                                                )

                                                // SwitchList[0].value!.switchViewModel![index].buttonImage!.isEmpty?
                                                // Center(
                                                //     child: Icon(Icons.error, color: Colors.red,size: containerSize*0.4,)
                                                // ):
                                                //
                                                // Image.network(
                                                //   SwitchList[0].value!.switchViewModel![index].buttonImage!,
                                                //
                                                //   width: imageSize,
                                                //   height: imageSize,
                                                //   fit: BoxFit.fill,
                                                // )

                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            SwitchList[0]
                                                .value!
                                                .switchViewModel![index]
                                                .switchName!,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(getrescode(SwitchList[0]
                                                .value!
                                                .switchViewModel![index]
                                                .buttonImage!
                                                .isEmpty
                                                .toString())
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddSwitch(
                                                        DeviceSwitchList:
                                                            DeviceSwitchList,
                                                        dropdownVal: SwitchList[
                                                                0]
                                                            .value!
                                                            .switchViewModel![
                                                                index]
                                                            .switchName
                                                            .toString(),
                                                        id: id!,
                                                        isEditMode: true,
                                                        prefix: SwitchList[0]
                                                            .value!
                                                            .switchViewModel![
                                                                index]
                                                            .prifix!,
                                                        userId: SwitchList[0]
                                                            .value!
                                                            .switchViewModel![
                                                                index]
                                                            .id!,
                                                      )));
                                        },
                                        icon: Icon(Icons.edit, size: 20),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          String time =
                                              DateFormat('yyyy-MM-ddTHH:mm:SS')
                                                  .format(DateTime.now());
                                          DeleteSwitchModel request =
                                              DeleteSwitchModel(
                                                  id: SwitchList[0]
                                                      .value!
                                                      .switchViewModel![index]
                                                      .id,
                                                  deletedBy: 3,
                                                  deletedDateTime: time,
                                                  applicationId: "abc");
                                          try {
                                            ApiServices apiservices =
                                                ApiServices();
                                            DeleteSwitchModel? response =
                                                (await apiservices.deleteSwitch(
                                                    request.toJson()));

                                            if (response == null) {
                                              print("res is null");
                                            } else {
                                              print("res is not null");
                                            }
                                          } catch (e) {
                                            print("Exception" + e.toString());
                                          }
                                        },
                                        icon: Icon(Icons.delete, size: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        // separatorBuilder: (BuildContext context, int index) {
                        //   return Divider();
                        // },
                      ),
                    )
                  ],
                ),
              ));
  }

  Future<bool> getrescode(String imageurl) async {
    try {
      final response = await http.get(Uri.parse(imageurl));
      return true;
    } catch (e) {
      return false;
    }
  }
}
