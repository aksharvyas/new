import 'package:book_app/screens/admin/home.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bottomNavBar/bootomNavBar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("user");
  bool loading = false;
  bool isvisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                0,
                MediaQuery.of(context).size.height * 0.01,
                0,
                MediaQuery.of(context).size.height * 0.09),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.08, 0, 0, 0),
          child: Row(
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  "assets/spl2.png",
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.08,
              MediaQuery.of(context).size.width * 0.04,
              0,
              MediaQuery.of(context).size.width * 0.1),
          child: Text(
            "Enter your email and password",
            style: TextStyle(
                color: Color(0xFF7C7C7C),
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.02),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.08, 0, 0, 0),
          child: Text(
            "Email",
            style: TextStyle(color: Color(0xFf7C7C7C)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
              0, MediaQuery.of(context).size.width * 0.12, 0),
          child: TextField(
            controller: emailController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
              MediaQuery.of(context).size.height * 0.04, 0, 0),
          child: Text(
            "Password",
            style: TextStyle(color: Color(0xFf7C7C7C)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
              0, MediaQuery.of(context).size.width * 0.12, 0),
          child: TextField(
            controller: passController,
            obscureText: !isvisible,
            decoration: (InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                    child: isvisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)))),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.58, 0, 0, 0),
          child: TextButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please Enter Email id",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  fontSize: 16,
                );
              } else {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(
                        email: emailController.text.toString())
                    .then((value) =>
                        Fluttertoast.showToast(msg: "Email Successfull Sent"))
                    .onError((error, stackTrace) =>
                        Fluttertoast.showToast(msg: error.toString()));
              }
            },
            child: Text("Forgot Password?"),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
              MediaQuery.of(context).size.height * 0.01, 0, 0),
          child: new SizedBox(
              width: MediaQuery.of(context).size.width * 0.83,
              height: MediaQuery.of(context).size.height * 0.07,
              //   height: 67,
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    login();
                  },
                  child: loading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Sign in",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFFFF9FF)),
                        ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFF53B175),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19.0),
                      ))))),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.01, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an  account?"),
              TextButton(
                  onPressed: () {
                    emailController.clear();
                    passController.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Register()));
                  },
                  child: Text("Sign Up"))
            ],
          ),
        )
      ]),
    ));
  }

  login() async {
    bool admin = false;
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) async {
      final uid = auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection("admin")
          .doc(uid)
          .snapshots()
          .forEach((element) {
        if (element.data()?['Email'] == emailController.text.toString() &&
            element.data()?['Password'] == passController.text.toString() &&
            element.data()?['Admin'] == true) {
          admin = true;
        }
        if (admin == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
          );
        }
      });
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        fontSize: 16,
      );
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        fontSize: 16,
      );
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }
}
