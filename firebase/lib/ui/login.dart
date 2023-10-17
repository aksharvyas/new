import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loginwithphone.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        // errorText: nameErrorText,
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        login();
                      },
                      child: loading == true
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : Text("Login")),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You Dont have Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text("Sign Up")),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginWithPhone()),
                        );
                      },
                      child: Text(""
                          "Login with Phone Number"))
                ],
              )),
        ),
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passController.text.toString())
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewData()),
        );
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });

        Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
      });
    }
  }
}
