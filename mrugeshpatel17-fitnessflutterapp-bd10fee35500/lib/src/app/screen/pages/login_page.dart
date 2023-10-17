import 'dart:developer';

import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';
import 'package:fitness_ble_app/src/app/screen/helper/utility.dart';
import 'package:fitness_ble_app/src/app/screen/model/login_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/Forgot_Password_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/ble_listing_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/dashboard_card_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/patient_list_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/signup_page.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController =
      TextEditingController();
  TextEditingController _passwordController =
      TextEditingController();

  FToast? fToast;
  bool showLoaderLogin = false;

  @override
  void initState() {
    LocalStorageService.setLastScreen("/LoginPage");
    super.initState();
    fToast = FToast();
    fToast!.init(context);

  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                controller: _emailController,
                hintText: "Email id",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(), onTap: () {  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => node.unfocus(), onTap: () {  },
              ),
            ),
            SizedBox(
              height: 6,
            ),
            materialButtonWidget(
                text: "SignIn",
                showLoader: showLoaderLogin,
                onPressed: () {
                  onClickLoginButton(context);
                }),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return ForgotPasswordPage();
                    }));
              },
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Forgot Password ?",
                      style: cardTextStyle,
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 206,
              height: 50,
              child: RaisedButton.icon(
                  onPressed: () {
                    loginWithFacebook(context);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.facebookSquare,
                    color: Colors.white,
                  ),
                  color: Colors.blue[600],
                  label: Text(
                    "Login With Facebook",
                    style: cardTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              child: RaisedButton.icon(
                  onPressed: () {
                    loginWithTwitter(context);
                  },
                  color: Colors.lightBlueAccent,
                  icon: FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Login With Twitter",
                    style: cardTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            materialButtonWidget(
                text: "SignUp",
                showLoader: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpPage();
                  }));
                }),
          ],
        ),
      ),
    );
  }




  void onClickLoginButton(BuildContext context) async {
    if (areValidFields()) {
      if (!showLoaderLogin) {
        setState(() {
          showLoaderLogin = true;
        });
      }
      log("showLoader ${showLoaderLogin}");
      Map<String, dynamic> request = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      ApiProvider apiProvider = ApiProvider();
      ResponseLoginModel response = (await apiProvider.login(request))!;

      if (response != null) {
        log("ResponseLoginModel ${response.meta.code}");
        if (response.meta.code == STATUS_SUCCESS) {
          setState(() {
            showLoaderLogin = false;
          });
          showToastIconName(fToast!, FontAwesomeIcons.thumbsUp,
              "You are successfully logged in");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return PatientListPage();
          }));
        }
      } else {
        setState(() {
          showLoaderLogin = false;
        });
      }
    }
  }

  void loginWithFacebook(BuildContext context) {}

  bool areValidFields() {
    if (_emailController.text.trim().length == 0) {
      showToast("Oops! You forgot to provide Email Id");
      return false;
    } else if (validateEmail(_emailController.text.trim()) != null) {
      showToast("Oops! You forgot to valid Email Id");
      return false;
    } else if (_passwordController.text.trim().length == 0) {
      showToast("Oops! You forgot to provide Password");
      return false;
    } else {
      return true;
    }
  }

  void loginWithTwitter(BuildContext context) {}
}
