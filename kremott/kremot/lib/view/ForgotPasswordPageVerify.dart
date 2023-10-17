import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/view/ForgotPasswordPage.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../res/AppDimensions.dart';
import '../res/AppStyles.dart';

class ForgotPasswordVerifyPage extends StatefulWidget {
  const ForgotPasswordVerifyPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordVerifyPage> createState() =>
      _ForgotPasswordVerifyPagePageState();
}

class _ForgotPasswordVerifyPagePageState
    extends State<ForgotPasswordVerifyPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? showLoader = false;
  final GlobalKey<FormState> formkey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String numberData = "";
  String? isoCode;
  late String phoneNumber, verificationId;
  late String otp, authStatus = "";

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
                                    numberData = number.phoneNumber!;
                                    isoCode = number.isoCode;
                                  });
                                },
                                onInputValidated: (bool value) {},
                                //inputBorder:  OutlineInputBorder(borderSide: const BorderSide(color: Color(0x80eceded), width: 1),),
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
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderSide: const BorderSide(color: Color(0x80eceded), width: 1),
                                    // ),
                                    // disabledBorder: OutlineInputBorder(
                                    //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                                    // ),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                                    // ),
                                    // errorBorder: OutlineInputBorder(
                                    //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                                    // ),
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderSide: const BorderSide(color:  Color(0x80eceded), width: 1),
                                    // ),
                                    isDense: true,
                                    filled: true,
                                    hintText: "MOBILE NO",
                                    hintStyle: hintTextStyle(context),
                                    labelStyle: hintTextStyle(context),
                                errorStyle: TextStyle(fontSize: getAdaptiveTextSize(context, textFieldErrorTextFontSize))),
                                onSaved: (PhoneNumber number) {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(height, 20),
                        ),
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

  void onLoginButtonClick() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      if (!showLoader!) {
        setState(() {
          showLoader = true;
        });
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: numberData,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          setState(() {
            authStatus = "Your account is successfully verified";
            showLoader = false;
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          setState(() {
            authStatus = "Authentication failed";
            showLoader = false;
          });
        },
        codeSent: (String verId, int? forceCodeResent) {
          if (kDebugMode) {
            print(verId);
          }
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
                builder: (context) => ForgotPasswordPage(verificationId, _auth,
                    mobileController.text.toString(), isoCode!)),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
          setState(() {
            authStatus = "TIMEOUT";
            showLoader = false;
          });
        },
      );
    }
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
}
