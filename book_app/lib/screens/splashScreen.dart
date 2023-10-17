import 'dart:async';
import 'package:book_app/screens/user/bottomNavBar/bootomNavBar.dart';
import 'package:book_app/screens/user/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()
      ));
    });

  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(backgroundColor: Colors.green,
      body: Center(
          child:
          Hero(
              tag: 'logo',
              child: Image.asset('assets/spl2.png'))
      ),
    );
  }
}
