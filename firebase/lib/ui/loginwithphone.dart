import 'package:firebase/ui/verifyCode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: Column(
          children: [
            Form(
              child:
              TextFormField(
              controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              )
            ),
            ElevatedButton(onPressed: (){
              auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (_){

                  },
                  verificationFailed: (error){
                    Fluttertoast.showToast(
                      msg: error.toString(),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.blueGrey,
                      fontSize: 16,
                    );
                  },
                  codeSent: (String verification, int? token){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyCode()),
                    );
                  },
                  codeAutoRetrievalTimeout:(error){
                    Fluttertoast.showToast(
                      msg: error.toString(),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.blueGrey,
                      fontSize: 16,
                    );
                  });
            }, child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
