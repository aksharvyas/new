import 'dart:ui';

import 'package:device_information/device_information.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/models/LoginModel.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/view/ForgotPasswordPageVerify.dart';
import 'package:kremot/view/HomePage.dart';
import 'package:kremot/view/RegistrationPage.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kremot/view_model/UserVM.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../res/AppDimensions.dart';
import '../res/AppStyles.dart';
import '../utils/Constants.dart';
import 'PairingPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? showLoader = false;
  final GlobalKey<FormState> formkey = GlobalKey();
  String numberData = "";
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  final UserVM viewModel = UserVM();
  var uuid = const Uuid();
  String? isoCode;
  String? imei;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestFilePermission();
    checkInternet();
  }
  Future<void> checkInternet()
  async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    print("internet test========"+isConnected.toString());
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
    await LocalStorageService.setAppId(imei.toString());
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
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(top: getY(height, 50)),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          kRemotButton(width, height),
                          SizedBox(
                            height: getHeight(height, 20),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(context.resources.strings.labelLogin,
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
                    ],
                  ),
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
                            )
                          ],
                        ),
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
                              alignment: Alignment.topLeft,
                              child: textFormField(
                                context,
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
                                  verticalPadding: getHeight(height, textFieldVerticalPadding)
                              ),
                            )),
                        SizedBox(
                          height: getHeight(height, 20),
                        ),
                        GestureDetector(child:Container(
                          margin: EdgeInsets.only(right: getWidth(width, 40)),
                          alignment: Alignment.topRight,
                          child: Text(context.resources.strings.labelForget,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.underline,
                                  decorationColor: textColor,
                                  decorationThickness: 1.5,
                                  fontSize: getAdaptiveTextSize(context, 12.0)), textAlign: TextAlign.center),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) =>
                          const ForgotPasswordVerifyPage()));
                        },),
                        SizedBox(
                          height: getHeight(height, 40),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: getadaptiveTextSize(context, 12.0)),
                              text: context.resources.strings.alreadySignup),
                          TextSpan(
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.underline,
                                  decorationColor: textColor,
                                  decorationThickness: 1.5,
                                  fontSize: getAdaptiveTextSize(context, 12.0)),
                              text: context.resources.strings.labelSignup,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationPage()),
                                  );
                                })
                        ]))
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
                        context.resources.strings.labelNext,
                        onLoginButtonClick,
                        showLoader,
                        getHeight(height, optionsButtonHeight),
                        getWidth(width, optionsNextButtonWidth),
                        formkey.currentState?.validate() ?? false),
                    SizedBox(height: getHeight(height, 40),),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
  late final NordicNrfMesh nordicNrfMesh = NordicNrfMesh();
  void onLoginButtonClick() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      if (!showLoader!) {
        setState(() {
          showLoader = true;
        });
      }
      RequestLogin requestLogin = RequestLogin(
          contryCode: isoCode,
          applicationId:imei,

          mobileNo: mobileController.text.toString(),
          password: passwordController.text.toString());

      ResponseLogin? responseLogin = await viewModel.login(requestLogin);

      if (responseLogin!.value!.meta!.code == 1) {
        setState(() {
          showLoader = false;
        });
        if (!mounted) return;

        String token = responseLogin.value!.refereshTokenViewModel!.jwtToken!;
        LocalStorageService.getInstance()!.setString(LocalStorageService.PREF_TOKEN, token);
        print("TOKEN    "+token+"    TOKENEND");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HomePage(nordicNrfMesh)),
        );
      } else {
        setState(() {
          showLoader = false;
        });
        if (!mounted) return;

        showAlertDialog(context, responseLogin.value!.meta!.message, () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
      }
    }
  }


}
