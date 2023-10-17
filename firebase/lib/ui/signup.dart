import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  TextEditingController passController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
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
                    controller: nameController,
                    decoration: InputDecoration(
                        // errorText: nameErrorText,
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                      } else if (!EmailValidator.validate(value, true)) {
                        return "Invalid Email Address";
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
                      } else if (value.length <= 7) {
                        return 'Password Contain Minimum 8 Character';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        signUp();
                        // Navigator.pop(context);
                      },
                      child: loading == true
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : Text("Sign Up")),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do you have already an Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Login"))
                    ],
                  ),

                ],
              )),
        ),
      ),
    );
  }

  Future _create() async {
    final usercollection = FirebaseFirestore.instance.collection("signup");
    final docref = usercollection.doc();
    await docref.set({
      "name": nameController.text.toString(),
      "email": emailController.text.toString(),
      "password": passController.text.toString(),
      "UID": docref.id,
      "date": DateTime.now(),
      //  "email": "aksa"
    });
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passController.text.toString())
          .then((value) async {
        await _create();
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(
          msg:
              '${emailController.text.toString()} account is already used by another user please try another account',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
        Navigator.pop(context);
      });
    }
  }
}
