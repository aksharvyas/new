import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/helper/utility.dart';
import 'package:fitness_ble_app/src/app/screen/model/null_comman_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/signup_model.dart';
import 'package:fitness_ble_app/src/app/screen/pages/add_patient_page.dart';
import 'package:fitness_ble_app/src/app/screen/pages/login_page.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key,required this.emailId}) : super(key: key);
  final String emailId;
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                controller: _OTPController,
                hintText: "Enter a OTP",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(), onTap: () {  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                obscureText: true,
                controller: _passwordController,
                hintText: "Password",
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(), onTap: () {  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: textFieldWidget(
                obscureText: true,
                controller: _confirmPassWordController,
                hintText: "Confirm Password",
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => node.unfocus(), onTap: () {  },
              ),
            ),
            SizedBox(
              height: 6,
            ),
            materialButtonWidget(
                text: "Reset Password",
                showLoader: showLoader,
                onPressed: () {

                  signUp(context);
                }),
            SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    );
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassWordController = TextEditingController();
  TextEditingController _OTPController = TextEditingController();
  var token1 = "nothing..............";


  FToast? fToast;
  bool showLoader = false;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }



  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //
  //
  // void firebaseCloudMessaging_Listeners() {
  //   _firebaseMessaging.getToken().then((token) {
  //     token1 = token;
  //     print(token1);
  //   });
  //
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('on message $message');
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print('on resume $message');
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print('on launch $message');
  //     },
  //   );
  // }

  void signUp(BuildContext context) async {

    if(areValidFields()) {
      if (!showLoader) {
        setState(() {
          showLoader = true;
        });
      }

      Map<String, dynamic> request = {
        "password": _passwordController.text,
        "otp": _OTPController.text,
      };
      ApiProvider apiProvider = ApiProvider();
      NullDataCommanModel response = (await apiProvider.resetPassWord(request))!;


      if(response != null){
        if (response.meta!.code == STATUS_SUCCESS) {
          setState(() {
            showLoader = false;
          });
          // showToastIconName(
          //     fToast, FontAwesomeIcons.thumbsUp, "Successfully signup");
          showToast(response.meta!.message);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return LoginPage();
          }));
        } else{
          showToast("${response.meta!.message}");
        }
      }
    }
    setState(() {
      showLoader = false;
    });
  }

  bool areValidFields() {
    if (_OTPController.text
        .trim()
        .length == 0) {
      showToast("Oops! You forgot to provide OTP");
      return false;
    }  else if (_passwordController.text
        .trim()
        .length == 0) {
      showToast("Oops! You forgot to provide Password");
      return false;
      // } else if (validatePassword(_passwordController.text.trim()) != null) {
      //   showToast("Oops! You forgot to valid Password");
      //   return false;
      // }
    }else if (_passwordController.text.trim() !=
        _confirmPassWordController.text.trim()) {
      showToast("Password and Confirm Password must be same");
      return false;
    } else {
      return true;
    }
  }


}

