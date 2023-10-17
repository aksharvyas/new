import 'package:book_app/screens/splashScreen.dart';
import 'package:book_app/screens/user/bottomNavBar/bootomNavBar.dart';
import 'package:flutter/material.dart';
import 'screens//admin/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? curuser = await FirebaseAuth.instance.currentUser;
  if (curuser == null) {
    runApp(MyApp());
  } else {
    final a = await FirebaseFirestore.instance
        .collection("user")
        .doc(curuser.uid)
        .get();
    final b = await FirebaseFirestore.instance
        .collection("admin")
        .doc(curuser.uid)
        .get();
    if (a.exists) {
      runApp(const Users());
    } else if (b.exists) {
      runApp(Admin());
    } else {
      runApp(MyApp());
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AdminHome());
  }
}

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
