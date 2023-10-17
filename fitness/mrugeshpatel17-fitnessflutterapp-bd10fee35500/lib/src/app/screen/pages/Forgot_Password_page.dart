

import 'dart:developer';

import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/helper/storage.dart';
import 'package:fitness_ble_app/src/app/screen/helper/utility.dart';
import 'package:fitness_ble_app/src/app/screen/model/login_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/null_comman_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/ble_listing_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/dashboard_card_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/patient_list_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/reset_password_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/signup_page.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController =
  TextEditingController();


  FToast? fToast;
  bool showLoaderLogin = false;

  @override
  void initState() {
    //LocalStorageService.setLastScreen("/LoginPage");
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
                hintText: "Enter a email id",
                keyboardType: TextInputType.emailAddress, textInputAction: null, onEditingComplete: () {  }, onTap: () {  },
              ),
            ),

            SizedBox(
              height: 6,
            ),
            materialButtonWidget(
                text: "Forgot password",
                showLoader: showLoaderLogin,
                onPressed: () {
                  onClickLoginButton(context);
                }),
            SizedBox(
              height: 10,
            ),
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
      };
      ApiProvider apiProvider = ApiProvider();
      NullDataCommanModel response = (await apiProvider.forgotPassWord(request))!;

      if (response != null) {
        log("ResponseLoginModel ${response.meta!.code}");
        if (response.meta!.code == STATUS_SUCCESS) {
          setState(() {
            showLoaderLogin = false;
          });
          // showToastIconName(fToast,FontAwesomeIcons.thumbsUp,
          //     "");
          showToast(response.meta!.message);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return ResetPasswordPage(emailId: _emailController.text,);
              }));
        }
      } else {
        setState(() {
          showLoaderLogin = false;
        });
      }
    }
  }


  bool areValidFields() {
    if (_emailController.text.trim().length == 0) {
      showToast("Oops! You forgot to provide Email Id");
      return false;
    } else if (validateEmail(_emailController.text.trim()) != null) {
      showToast("Oops! You forgot to valid Email Id");
      return false;
    }  else {
      return true;
    }
  }

}
