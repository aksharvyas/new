import 'package:device_information/device_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kremot/models/UserModel.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/view/VerifyOtpPage.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kremot/view_model/UserVM.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/app_model.dart';
import '../res/AppDimensions.dart';
import '../res/AppStyles.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool? showLoader = false;
  final GlobalKey<FormState> formkey = GlobalKey();
  String numberData="";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneNumber number = PhoneNumber(isoCode:'IN');

  late String phoneNumber, verificationId;
  late String otp, authStatus = "";

  final UserVM viewModel = UserVM();
  var uuid = Uuid();
  String? isoCode;
  String? imei;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestFilePermission();

  }

  void requestFilePermission() async {
    // PermissionStatus result;
    // // In Android we need to request the storage permission,
    // // while in iOS is the photos permission
    // if (Platform.isAndroid) {
    //   result = await Permission.phone.request();
    // }
    // if (result.isGranted) {
    //   imei= await DeviceInformation.deviceIMEINumber;
    //   return true;
    // }
    // return false;

    if (await Permission.phone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      imei= await DeviceInformation.deviceIMEINumber;
    }else{
      imei= await DeviceInformation.deviceIMEINumber;
      print("Location Permission is denied.");
    }

    // final status = await Permission.phone.request();
    // if (status == PermissionStatus.granted) {
    //   imei= await DeviceInformation.deviceIMEINumber;
    // } else if (status == PermissionStatus.denied) {
    //   await openAppSettings();
    //   print('Permission denied. Show a dialog and again ask for the permission');
    // } else if (status == PermissionStatus.permanentlyDenied) {
    //   print('Take the user to the settings page.');
    //   await openAppSettings();
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.resources.color.colorBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(height, 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kRemotButton(width, height),
                SizedBox(
                  height: getHeight(height, 20),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(context.resources.strings.labelWelcom,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: getAdaptiveTextSize(context, 16.0)),
                      textAlign: TextAlign.justify),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(height, 50),
            ),
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Container(
                      //   width: getWidth(width, textFieldWidth),
                      //   height: getHeight(height, mobileNoTextFieldBoxHeight),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //           color: const Color(0x80eceded), width: 1),
                      //       boxShadow: const [
                      //         BoxShadow(
                      //             offset: Offset(0.0, 3),
                      //             blurRadius: 2,
                      //             spreadRadius: 0)
                      //       ],
                      //       color: const Color(0xb81b1918)),
                      // ),
                      Container(
                        width: getWidth(width, textFieldWidth),
                        alignment: Alignment.topCenter,
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              numberData=number.phoneNumber!;
                              isoCode = number.isoCode;
                            });
                          },
                          onInputValidated: (bool value) {},
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            leadingPadding: getWidth(width, 10),
                            setSelectorButtonAsPrefixIcon: true,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: hintTextStyle(context),
                          initialValue: number,
                          formatInput: false,
                          spaceBetweenSelectorAndTextField: 0,
                          selectorButtonOnErrorPadding: 0,
                          maxLength: 10,
                          textStyle: hintTextStyle(context),
                          validator: validatePhoneNumber,
                          textFieldController: mobileController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                          inputBorder: const OutlineInputBorder(),
                          inputDecoration: InputDecoration(
                              border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
                              focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
                              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1)),
                              fillColor: context.resources.color.colorTextFieldBg,
                               // contentPadding:
                               //    EdgeInsets.only(top: getY(height, 15), bottom: getY(height, 15)),
                              contentPadding: EdgeInsets.only(top: getHeight(height, textFieldVerticalPadding), bottom: getHeight(height, textFieldVerticalPadding), left: 10),
                              isDense: true,
                              filled: true,
                              hintText: "MOBILE NO",
                              hintStyle: hintTextStyle(context),
                              labelStyle: hintTextStyle(context),
                          errorStyle: TextStyle(fontSize: getAdaptiveTextSize(context, textFieldErrorTextFontSize))),
                          onSaved: (PhoneNumber number) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getHeight(height, 20),
                  ),
                  SizedBox(
                      width: getWidth(width, textFieldWidth),
                      child: Container(
                        child: textFormField(
                          context,
                          hintText: "NAME",
                          hintStyle: hintTextStyle(context),
                          controller: nameController,
                          validator: validateName,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                            LengthLimitingTextInputFormatter(20),
                          ],
                          onFieldSubmitted1: (value) {},
                          textInputAction: TextInputAction.done,
                          verticalPadding: getHeight(height, textFieldVerticalPadding)
                        ),
                      )),
                  SizedBox(
                    height: getHeight(height, 20),
                  ),
                  SizedBox(
                      width: getWidth(width, textFieldWidth),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: textFormField(
                          context,
                          hintText: "EMAIL ID",
                          hintStyle: hintTextStyle(context),
                          controller: emailController,
                          validator: validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            LengthLimitingTextInputFormatter(30),
                          ],
                          onFieldSubmitted1: (value) {},
                          textInputAction: TextInputAction.next,
                            verticalPadding: getHeight(height, textFieldVerticalPadding)
                        ),
                      )),
                  SizedBox(
                    height: getHeight(height, 20),
                  ),
                  SizedBox(
                      width: getWidth(width, textFieldWidth),
                      //height: 51,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: textFormField(
                          context,
                          hintText: "PASSWORD",
                          hintStyle: hintTextStyle(context),
                          controller: passwordController,
                          obscureText: true,
                          validator: validatePassword,
                          keyboardType: TextInputType.visiblePassword,
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            LengthLimitingTextInputFormatter(20),
                          ],
                          onFieldSubmitted1: (value) {},
                          textInputAction: TextInputAction.next,
                            verticalPadding: getHeight(height, textFieldVerticalPadding)
                        ),
                      )),
                  SizedBox(
                    height: getHeight(height, 20),
                  ),
                  SizedBox(
                      width: getWidth(width, textFieldWidth),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: textFormField(
                          context,
                          hintText: "RE ENTER PASSWORD ",
                          hintStyle: hintTextStyle(context),
                          controller: confirmController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: validateConfirmPassword,
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            LengthLimitingTextInputFormatter(20),
                          ],
                          onFieldSubmitted1: (value) {},
                          // onEditingComplete: () => node.nextFocus(),
                          textInputAction: TextInputAction.done,
                            verticalPadding: getHeight(height, textFieldVerticalPadding)
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(height, 50),
            ),
            Column(
              children: <Widget>[
                getPrimaryButtonShowLoader(
                    context,
                    context.resources.strings.labelDone,
                    onLoginButtonClick,
                    showLoader,
                    getHeight(height, optionsButtonHeight),
                    getWidth(width, optionsNextButtonWidth), formkey.currentState?.validate() ?? false),
                SizedBox(
                  height: getHeight(height, 40),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Phone Number is required';
    } else if (value.length < 10) {
      return 'Phone Number is required at least 10 digits';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }



  String? validateConfirmPassword(String? value) {
    RegExp passValid =
        RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    } else if (value.length < 8) {
      return 'Confirm Password must be at least 8 characters';
    } else if (!passValid.hasMatch(value)) {
      return 'Confirm Password contains one Uppercase and one lowercase and one number';
    } else if (value != passwordController.text) {
      return 'Password and Confirm Password must be same';
    } else {
      return null;
    }
  }

  void onLoginButtonClick() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      context
          .read<AppModel>()
          .isoCode = isoCode!;
      context
          .read<AppModel>()
          .emaiId = emailController.text.toString();
      context
          .read<AppModel>()
          .password = passwordController.text.trim();
      context
          .read<AppModel>()
          .firstName = nameController.text.trim();
      context
          .read<AppModel>()
          .mobileNo = mobileController.text.trim();
      if (!showLoader!) {
        setState(() {
          showLoader = true;
        });
      }


      RequestMobile requestMobile = RequestMobile(
          contryCode: isoCode,
          applicationId: await DeviceInformation.deviceIMEINumber,
          mobileNo: mobileController.text.toString()
      );
      print(requestMobile.toJson().toString());

      ResponseMobile? responseMobile =
      await viewModel.verifyPhone(requestMobile);
      if (responseMobile!.value!.meta!.code == 1) {
        if (!mounted) return;
        await _auth.verifyPhoneNumber(
          phoneNumber: numberData,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) {
            setState(() {
              authStatus = "Your account is successfully verified";
            });
          },
          verificationFailed: (FirebaseAuthException authException) {
            setState(() {
              authStatus = "Authentication failed";
            });
          },
          codeSent: (String verId, int? forceCodeResent) {
            print(verId);
            verificationId = verId;
            setState(() {
              authStatus = "OTP has been successfully send";
            });
            setState(() {
              showLoader = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtpPage(verificationId, _auth)),
            );
          },
          codeAutoRetrievalTimeout: (String verId) {
            verificationId = verId;
            setState(() {
              authStatus = "TIMEOUT";
            });
            print("codeAutoRetrievalTimeout" + authStatus);
          },
        );
      } else {
        setState(() {
          showLoader = false;
        });
        if (!mounted) return;

        showAlertDialog(context, responseMobile.value!.meta!.message, () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
      }
    }




    }
  }

