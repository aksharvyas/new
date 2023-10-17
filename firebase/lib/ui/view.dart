import 'dart:io';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          FirebaseAuth.instance.signOut().then((value) => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          )
          }

           );
        }, child: Text("log out")),
      ),
    );
  }
}
