import 'dart:developer';

import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/helper/utility.dart';
import 'package:fitness_ble_app/src/app/screen/pages/patient_list_page.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/app_widget.dart';
import 'package:flutter/material.dart';

import 'package:fitness_ble_app/src/app/screen/model/add_patient_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {


  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();

  List gender=["Male","Female","Other"];



  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child:  SizedBox(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                controller: _firstNameController,
                hintText: "First Name",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(), onTap: () {  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                controller: _lastNameController,
                hintText: "Last Name",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(), onTap: () {  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                  controller: _emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(), onTap: () {  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                  controller: _phoneController,
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(), onTap: () {  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 20, 0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Gender',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                children: <Widget>[
                  addRadioButton(0, 'Male'),
                  addRadioButton(1, 'Female'),
                  addRadioButton(2, 'Others'),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            //   child: textFieldWidget(
            //     controller: _genderController,
            //     hintText: "Gender",
            //     keyboardType: TextInputType.text,
            //     textInputAction: TextInputAction.next,
            //     onEditingComplete: () => node.nextFocus(),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                controller: _birthDateController,
                onTap: (){
                  birthDatePicker();
                },
                 readOnly: true,
                hintText: "Birth Date",
                textInputAction: TextInputAction.done,
                onEditingComplete: () => node.unfocus(),
                keyboardType: null,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 140,
                    child:
                        materialButtonWidget(text: "Cancel",showLoader: false, onPressed: () {
                          Navigator.pop(context);
                        })),
                Container(
                    height: 50,
                    width: 140,
                    child: materialButtonWidget(
                        text: "Add",
                        showLoader: showLoader,
                        onPressed: ()  async {
                          if(areValidFields()){
                            if (!showLoader) {
                              setState(() {
                                showLoader = true;
                              });
                            }

                            AddPatientModel request = AddPatientModel(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                birthDate: _birthDateController.text,
                                email: _emailController.text,
                                gender: selectGender,
                                phone: _phoneController.text);


                            ApiProvider apiProvider = ApiProvider();
                            ResponseAddPatient response = (await apiProvider.addEditPatient(request.toJson()))!;
                            if (response != null) {
                              log("ResponseLoginModel ${response.meta!.code}");
                              if (response.meta!.code == STATUS_SUCCESS) {
                                setState(() {
                                  showLoader = false;
                                });
                                showToastIconName(fToast!, FontAwesomeIcons.thumbsUp,
                                    "Patient has been added successfully.");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return PatientListPage();
                                    }));
                              }
                            } else {
                              setState(() {
                                showLoader = false;
                              });
                            }
                          }

                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FToast? fToast;
  bool showLoader = false;
  String? selectGender;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }


  birthDatePicker() async{
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1901),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    ))!;
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _birthDateController.text =  DateFormat("dd-MM-yyyy").format(picked);
      });
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<String>(

          onChanged: (value){
            setState(() {

              selectGender=value.toString();
            });
          },
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: selectGender,

        ),
        Text(title)
      ],
    );
  }


  bool areValidFields() {
    if (_firstNameController.text.trim().length == 0) {
      showToast("Oops! You forgot to provide first name");
      return false;
    } else  if (_lastNameController.text.trim().length == 0) {
    showToast("Oops! You forgot to provide last name");
    return false;
    }  else  if (_birthDateController.text.trim().length == 0) {
    showToast("Oops! You forgot to provide birth date");
    return false;
    } else  if (_emailController.text.trim().length == 0) {
    showToast("Oops! You forgot to provide email Id");
    return false;
    } else  if (selectGender!.trim().length == 0) {
    showToast("Oops! You forgot to provide gender");
    return false;
    } else  if (_phoneController.text.trim().length == 0) {
    showToast("Oops! You forgot to provide phone no");
    return false;
    } else {
      return true;
    }
  }
}
