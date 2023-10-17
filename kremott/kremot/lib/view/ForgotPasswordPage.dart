import 'package:device_information/device_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kremot/models/LoginModel.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view/LoginPage.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/UserVM.dart';

import '../res/AppDimensions.dart';
import '../res/AppStyles.dart';

class ForgotPasswordPage extends StatefulWidget {
  String verificationId;
  FirebaseAuth auth;
  String mobile;
  String iso;

  ForgotPasswordPage(this.verificationId, this.auth, this.mobile, this.iso,
      {Key? key})
      : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  bool? showLoader = false;
  final UserVM viewModel = UserVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.resources.color.colorBlack,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(top: getHeight(height, 50)),
                  alignment: Alignment.topCenter,
                  child: kRemotButton(width, height),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: getWidth(width, textFieldWidth),
                            // height: 51,
                            // decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color: const Color(0x80eceded), width: 1),
                            //     boxShadow: const [
                            //       BoxShadow(
                            //           offset: Offset(0.0, 3),
                            //           blurRadius: 2,
                            //           spreadRadius: 0)
                            //     ],
                            //     color: const Color(0xb81b1918)),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: textFormField(context,
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
                                  // onEditingComplete: () => node.nextFocus(),
                                  textInputAction: TextInputAction.done,
                                  verticalPadding: getHeight(
                                      height, textFieldVerticalPadding)),
                            )),
                        SizedBox(
                          height: getHeight(height, 20),
                        ),
                        SizedBox(
                            width: getWidth(width, textFieldWidth),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: textFormField(context,
                                  hintText: "PASSWORD",
                                  hintStyle: hintTextStyle(context),
                                  controller: passwordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: validatePassword,
                                  inputFormatters: [
                                    NoLeadingSpaceFormatter(),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onFieldSubmitted1: (value) {},
                                  // onEditingComplete: () => node.nextFocus(),
                                  textInputAction: TextInputAction.done,
                                  verticalPadding: getHeight(
                                      height, textFieldVerticalPadding)),
                            )),
                        SizedBox(
                          height: getHeight(height, 20),
                        ),
                        SizedBox(
                            width: getWidth(width, textFieldWidth),
                            // height: 51,
                            // decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color: const Color(0x80eceded), width: 1),
                            //     boxShadow: const [
                            //       BoxShadow(
                            //           offset: Offset(0.0, 3),
                            //           blurRadius: 2,
                            //           spreadRadius: 0)
                            //     ],
                            //     color: const Color(0xb81b1918)),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: textFormField(context,
                                  hintText: "CONFIRM PASSWORD",
                                  hintStyle: hintTextStyle(context),
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  validator: validateConfirmPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  inputFormatters: [
                                    NoLeadingSpaceFormatter(),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onFieldSubmitted1: (value) {},
                                  // onEditingComplete: () => node.nextFocus(),
                                  textInputAction: TextInputAction.done,
                                  verticalPadding: getHeight(
                                      height, textFieldVerticalPadding)),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    getPrimaryButtonShowLoader(
                        context,
                        context.resources.strings.labelDone,
                        onLoginButtonClick,
                        showLoader,
                        getHeight(height, optionsNextButtonHeight),
                        getWidth(width, optionsNextButtonWidth), formkey.currentState?.validate() ?? false),
                    SizedBox(
                      height: getHeight(height, 40),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  String? validateOtp(String? value) {
    if (value!.isEmpty) {
      return 'Otp is required';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    RegExp passValid =
        RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
    if (value!.isEmpty) {
      return 'ConfirmPassword is required';
    } else if (value.length < 8) {
      return 'ConfirmPassword must be at least 8 characters';
    } else if (!passValid.hasMatch(value)) {
      return 'ConfirmPassword contains one Uppercase and one lowercase and one number';
    } else if (value != passwordController.text) {
      return 'Passwords and ConfirmPassword must b same';
    } else {
      return null;
    }
  }

  void onLoginButtonClick() async {
    String imei = await DeviceInformation.deviceIMEINumber;
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      String formattedDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
      DateTime dateTime = DateTime.parse("$formattedDate+05:30");

      if (!showLoader!) {
        setState(() {
          showLoader = true;
        });
      }

      RequestForgotPassword requestForgotPassword = RequestForgotPassword(
        mobileNo: widget.mobile,
        contryCode: widget.iso,
        password: passwordController.text.toString(),
        //updatedBy: imei,
        applicationId: imei,
        //updatedDateTime: "${dateTime.toLocal().toIso8601String()}+05:30"
        updatedDateTime:
            DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
      );

      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );
      final UserCredential user =
          await widget.auth.signInWithCredential(credential);
      final User currentUser = widget.auth.currentUser!;
      // assert(user.user?.uid == currentUser.uid);
      if (user.user?.uid == currentUser.uid) {
        ResponseForgotPassword? responseForgotPassword =
            await viewModel.forgotpassword(requestForgotPassword);
        if (responseForgotPassword!.value!.meta!.code == 1) {
          setState(() {
            showLoader = false;
          });
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
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
