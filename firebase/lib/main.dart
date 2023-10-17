import 'package:firebase/googleMap.dart';
import 'package:firebase/ui/login.dart';
import 'package:firebase/ui/view.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return MaterialApp(
      home: GoogleMaps(),

    //return MaterialApp(home: user!=null?ViewData():Login()

    );
  }

}
