import 'dart:io';

import 'package:device_information/device_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kremot/models/UserModel.dart';
import 'package:kremot/models/app_model.dart';
import 'package:kremot/repository/HomeRepo.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/view/HomePage.dart';
import 'package:kremot/view/PairingPage.dart';
import 'package:kremot/view/widgets/AuthService.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/UserVM.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../res/AppDimensions.dart';
import '../res/AppStyles.dart';


class VerifyOtpPage extends StatefulWidget {
  String verificationId;
  FirebaseAuth auth;
   VerifyOtpPage(this.verificationId, this. auth, {Key? key}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late final NordicNrfMesh nordicNrfMesh = NordicNrfMesh();
  TextEditingController otpController = TextEditingController();
  bool? showLoader = false;
  final authService = AuthService();
  final UserVM viewModel = UserVM();
  String contryCode="";
  String emaiId="";
  String firstName="";
  String password="";
  String mobileNo="";
  String? imei;
  final GlobalKey<FormState> formkey = GlobalKey();


  var uuid = Uuid();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // requestFilePermission();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    contryCode= context.select((AppModel m) => m.isoCode);
    emaiId= context.select((AppModel m) => m.emaiId);
    firstName= context.select((AppModel m) => m.firstName);
    password= context.select((AppModel m) => m.password);
    mobileNo= context.select((AppModel m) => m.mobileNo);

    return Scaffold(
      backgroundColor: context.resources.color.colorBlack,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned(
              top: getHeight(height, 50),
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kRemotButton(width, height),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        context.resources.strings.labelVerifyOtp,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: getAdaptiveTextSize(context, 16.0),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: getWidth(width, textFieldWidth),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: textFormField(
                            context,
                            hintText: "ENTER OTP",
                            hintStyle: hintTextStyle(context),
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            validator: validateOtp,
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                              LengthLimitingTextInputFormatter(6),
                            ],
                            onFieldSubmitted1: (value) {},
                            textInputAction: TextInputAction.done,
                            verticalPadding: getHeight(
                              height,
                              textFieldVerticalPadding,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getHeight(height, 30)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            getPrimaryButtonShowLoader(
                              context,
                              "VERIFY\nOTP",
                              onLoginButtonClick,
                              showLoader,
                              getHeight(height, optionsNextButtonHeight),
                              getWidth(width, optionsNextButtonWidth),
                              formkey.currentState?.validate() ?? false,
                            ),
                            SizedBox(height: getHeight(height, 40)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );


    // orignal code


    // return Scaffold(
    //   backgroundColor: context.resources.color.colorBlack,
    //   body:
    //      SizedBox(
    //       height: height,
    //       width: width,
    //       child: Stack(
    //         children: [
    //           Positioned(
    //             child: Container(
    //               margin: EdgeInsets.only(top: getHeight(height, 50)),
    //               alignment: Alignment.topCenter,
    //               child: Column(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       kRemotButton(width, height),
    //                       const SizedBox(
    //                         height: 20,
    //                       ),
    //                       Container(
    //                         alignment: Alignment.center,
    //                         child: Text(
    //                             context.resources.strings.labelVerifyOtp,
    //                             style: TextStyle(
    //                                 color: textColor,
    //                                 fontWeight: FontWeight.w400,
    //                                 fontFamily: "Roboto",
    //                                 fontStyle: FontStyle.normal,
    //                                 fontSize: getAdaptiveTextSize(context, 16.0)),
    //                             textAlign: TextAlign.justify),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Form(
    //                 key: formkey,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     SizedBox(
    //                         width: getWidth(width, textFieldWidth),
    //                         // height: 51,
    //                         // decoration: BoxDecoration(
    //                         //     border: Border.all(
    //                         //         color: const Color(0x80eceded), width: 1),
    //                         //     boxShadow: const [
    //                         //       BoxShadow(
    //                         //           offset: Offset(0.0, 3),
    //                         //           blurRadius: 2,
    //                         //           spreadRadius: 0)
    //                         //     ],
    //                         //     color: const Color(0xb81b1918)),
    //                         child: Container(
    //                           alignment: Alignment.centerLeft,
    //                           child: textFormField(
    //                             context,
    //                             hintText: "ENTER OTP",
    //                             hintStyle: hintTextStyle(context),
    //                             controller: otpController,
    //                             keyboardType: TextInputType.number,
    //                             validator: validateOtp,
    //                             inputFormatters: [
    //                               NoLeadingSpaceFormatter(),
    //                               LengthLimitingTextInputFormatter(6),
    //                             ],
    //                             onFieldSubmitted1: (value) {},
    //                             // onEditingComplete: () => node.nextFocus(),
    //                             textInputAction: TextInputAction.done,
    //                               verticalPadding: getHeight(height, textFieldVerticalPadding)
    //                           ),
    //                         )),
    //                     SizedBox(
    //                       height: getHeight(height, 30),
    //                     ),
    //
    // Positioned(
    //                         child: Align(
    //                           alignment: Alignment.bottomCenter,
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             children: <Widget>[
    //                               getPrimaryButtonShowLoader(
    //                                   context,
    //                                   "VERIFY\nOTP",
    //                                   onLoginButtonClick,
    //                                   showLoader, getHeight(height, optionsNextButtonHeight), getWidth(width, optionsNextButtonWidth),
    //                                   formkey.currentState?.validate() ?? false),
    //                               SizedBox(
    //                                 height: getHeight(height, 40),
    //                               ),
    //                             ],
    //                           ),
    //                         ))
    //                     // Container(
    //                     //   margin: const EdgeInsets.only(right: 40),
    //                     //   alignment: Alignment.topRight,
    //                     //   child: Text(context.resources.strings.labelForget,
    //                     //       style: subTextStyle, textAlign: TextAlign.center),
    //                     // ),
    //                     // const SizedBox(
    //                     //   height: 40,
    //                     // ),
    //                     // RichText(
    //                     //     text: TextSpan(children: [
    //                     //       TextSpan(
    //                     //           style: mainTextStyle,
    //                     //           text: context.resources.strings.alreadySignup),
    //                     //       TextSpan(
    //                     //           style: subTextStyle,
    //                     //           text: context.resources.strings.labelSignup)
    //                     //     ]))
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //
    // );
  }

  String? validateOtp(String? value) {
    if (value!.isEmpty) {
      return 'Otp is required';
    }
    return null;
  }

  // void requestFilePermission() async {
  //   // PermissionStatus result;
  //   // // In Android we need to request the storage permission,
  //   // // while in iOS is the photos permission
  //   // if (Platform.isAndroid) {
  //   //   result = await Permission.phone.request();
  //   // }
  //   // if (result.isGranted) {
  //   //   imei= await DeviceInformation.deviceIMEINumber;
  //   //   return true;
  //   // }
  //   // return false;
  //
  //   if (await Permission.phone.request().isGranted) {
  //     // Either the permission was already granted before or the user just granted it.
  //     imei= await DeviceInformation.deviceIMEINumber;
  //   }else{
  //     imei= await DeviceInformation.deviceIMEINumber;
  //     print("Location Permission is denied.");
  //   }
  //
  //   // final status = await Permission.phone.request();
  //   // if (status == PermissionStatus.granted) {
  //   //   imei= await DeviceInformation.deviceIMEINumber;
  //   // } else if (status == PermissionStatus.denied) {
  //   //   await openAppSettings();
  //   //   print('Permission denied. Show a dialog and again ask for the permission');
  //   // } else if (status == PermissionStatus.permanentlyDenied) {
  //   //   print('Take the user to the settings page.');
  //   //   await openAppSettings();
  //   // }
  // }

  void onLoginButtonClick() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      String formattedDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
      DateTime dateTime = DateTime.parse("$formattedDate+05:30");
      int os;
      if (Platform.isAndroid) {
        os = 1;
      } else {
        os = 2;
      }
      RequestRegister requestRegister = RequestRegister(
          mobileNo: mobileNo,
          applicationId:  await DeviceInformation.deviceIMEINumber,
          contryCode: contryCode,
          emaiId: emaiId,
          firstName: firstName,
          imei:  await DeviceInformation.deviceIMEINumber,
          lastName: "qbc",
          notification: true,
          os: os,
          password: password,
          tapSound: true,
          themeId: 1,
          vibration: true,
          createdDateTime: "${dateTime.toLocal().toIso8601String()}+05:30");



      if (!showLoader!) {
        setState(() {
          showLoader = true;
        });
      }


      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );
      final UserCredential user = await widget.auth.signInWithCredential(
          credential);
      final User currentUser = widget.auth.currentUser!;
      // assert(user.user?.uid == currentUser.uid);
      if (user.user?.uid == currentUser.uid) {
        ResponseRegister? responseUser =
        await viewModel.register(requestRegister);
        if (responseUser!.value!.meta!.code == 1) {
          setState(() {
            showLoader = false;
          });
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  HomePage(nordicNrfMesh)),
          );
        } else {
          setState(() {
            showLoader = false;
          });
          if (!mounted) return;

          showAlertDialog(context, "Invalid Login", () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
        }
      } else {
        setState(() {
          showLoader = false;
        });
        if (!mounted) return;

        showAlertDialog(context, "Invalid Code", () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
      }
    }
  }

  }









