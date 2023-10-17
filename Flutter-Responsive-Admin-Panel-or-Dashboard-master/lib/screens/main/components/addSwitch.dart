import 'dart:io';
import 'package:admin/models/addSwitchModel.dart';
import 'package:intl/intl.dart';
import '../../../models/updateSwitchModel.dart';
import '../../../res.dart';
import 'package:path/path.dart' as path;
import 'package:admin/models/DeviceSwitchesModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api_services.dart';
import '../../../constants.dart';

class AddSwitch extends StatefulWidget {
  int? id, userId;
  List<DeviceSwitchesModel> DeviceSwitchList;
  bool isEditMode;
  String dropdownVal, prefix;

  AddSwitch(
      {required this.userId,
      required this.id,
      required this.DeviceSwitchList,
      required this.isEditMode,
      required this.dropdownVal,
      required this.prefix});

  @override
  State<AddSwitch> createState() => _AddSwitchState();
}

class _AddSwitchState extends State<AddSwitch> {
  String? companyImage;
  final _formKey = GlobalKey<FormState>();
  File? profileImage;
  String? filename;
  final prefixController = TextEditingController();
  int? switchId;
  List Switches = [];
  String dropdownValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.dropdownVal.toString();
    if (widget.prefix != "") {
      prefixController.text = widget.prefix;
    }
    _getData();
  }

  Future _getData() async {
    // DeviceSwitchList = (await ApiServices().getDeviceSwitches())! as List<DeviceSwitchesModel>;

    for (int i = 0;
        i < widget.DeviceSwitchList[0].value!.deviceListViewModel!.length;
        i++) {
      Switches.add(widget
          .DeviceSwitchList[0].value!.deviceListViewModel![i].type
          .toString());
    }
    if (widget.isEditMode) {
      for (int i = 0; i < Switches.length; i++) {
        if (Switches[i].toString() == widget.dropdownVal) {
          switchId = i;
        }
      }
      if(switchId==null){
        dropdownValue='';
      }
    }
    print("switchid" + switchId.toString());

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: DropdownButton<dynamic>(
            value: switchId!=null?Switches[switchId!]:dropdownValue.isEmpty?Switches[0]:dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: Switches.map<DropdownMenuItem<dynamic>>((items) {
              return DropdownMenuItem<dynamic>(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (newValue) {
              switchId = null;
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Form(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Prefix'),
                controller: prefixController,
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () async {
                    print(dropdownValue+prefixController.text);
                    String time = DateFormat('yyyy-MM-ddTHH:mm:SS')
                        .format(DateTime.now());

                    if (widget.isEditMode == false) {
                      AddSwitchModel request = AddSwitchModel(
                          switchName:
                              dropdownValue == "" ? Switches[0] : dropdownValue,
                          createdBy: 1,
                          prifix: prefixController.text.toString(),
                          applicationId: "abc",
                          buttonImage: "",
                          createdDateTime: time);
                      try {
                        ApiServices apiservices = ApiServices();
                        AddSwitchModel? response =
                            (await apiservices.addSwitches(request.toJson()));

                        if (response == null) {
                          print("res is null");
                        } else {
                          print("res is not null");
                        }
                      } catch (e) {
                        print("Exception" + e.toString());
                      }
                    } else {
                      print("update");
                      UpdateSwitchModel request = UpdateSwitchModel(
                          buttonImage: "",
                          applicationId: "abc",
                          prifix: prefixController.text.toString(),
                          id: widget.userId,
                          switchName: dropdownValue,
                          updatedBy: 2,
                          updatedDateTime: time);
                      try {
                        ApiServices apiservice = ApiServices();
                        UpdateSwitchModel? response =
                            (await apiservice.updateSwitch(request.toJson()));
                        if (response == null) {
                          print("res is null");
                        } else {
                          print("res is not null");
                        }
                      } catch (e) {
                        {
                          print("Exception" + e.toString());
                        }
                      }
                    }
                  },
                  child: Text(
                    widget.isEditMode ? "Update" : "Submit",
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
            ],
          ),
        )),
      ],
    )));
  }

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = File(image.path);

        filename = path.basename(profileImage!.path);
        companyImage = null;
      });
    } else {}
  }

  Future showImagePickerDialog() async {
    companyImage = null;
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: secondaryColor,
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(
                  style: const ButtonStyle(),
                  onPressed: () {
                    pickImage();

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Pick from Gallery',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    captureImage();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Capture using camera',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void captureImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image?.path != null) {
      setState(() {
        profileImage = File(image?.path ?? Res.default_company_logo);
        companyImage = null;
      });
    }
  }
}
