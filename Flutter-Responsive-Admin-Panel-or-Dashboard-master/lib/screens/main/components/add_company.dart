import 'dart:io';

import 'package:admin/models/RecentFile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../constants.dart';
import '../../../res.dart';

class AddCompany extends StatefulWidget {
  final String? companyName;
  final String? companyImage;
  final int? index;
  const AddCompany({Key? key, this.companyName, this.companyImage, this.index}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  String? companyImage;
  final _formKey = GlobalKey<FormState>();
  bool isEditMode = false;
  File? profileImage;
  String? filename;

  TextEditingController _companyNameController = TextEditingController();

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

  void captureImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image?.path != null) {
      setState(() {
        profileImage = File(image?.path ?? Res.default_company_logo);
        companyImage = null;
      });
    }
  }

  @override
  void initState() {
    _companyNameController.text = widget.companyName ?? '';
    if (widget.companyImage != null) {
      companyImage = widget.companyImage;
      profileImage = File(widget.companyImage!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.companyName != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditMode ? 'Edit Company' : 'Add Company'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          child: ClipOval(
                            child: companyImage != null
                                ? Image.network(
                                    companyImage!,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    Res.default_company_logo,
                                    //height: MediaQuery.of(context).size.height * 0.15,
                                  ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.14,
                          left: MediaQuery.of(context).size.width * 0.11,
                          child: GestureDetector(
                            onTap: () {
                              print('touched');
                              showImagePickerDialog();
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [bgColor, primaryColor],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.edit, size: 15, //  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 15, 10.0, 10.0),
                      child: companyNameTextField(),
                    ),
                    height,
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: buildElevatedButton(context, isEditMode),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField companyNameTextField() {
    return TextFormField(
      controller: _companyNameController,
      decoration: InputDecoration(
        labelText: 'Company Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context, bool isEditMode) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
          if (isEditMode) {
            listOfCompany[widget.index!.toInt()] =
                CompanyListClass(name: _companyNameController.text, image: profileImage!.path);
          } else {
            listOfCompany.add(
              CompanyListClass(name: _companyNameController.text, image: profileImage!.path),
            );

            // showDialogBox(context, isEditMode);
          }
          Navigator.pop(context);
        }
      },
      child: Text(isEditMode ? 'Update' : 'Add'),
      style: TextButton.styleFrom(
        minimumSize: const Size(120, 40),
      ),
    );
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
}
