import 'package:book_app/screens/user/bottomNavBar/about.dart';
import 'package:book_app/screens/user/bottomNavBar/contract.dart';
import 'package:book_app/screens/user/bottomNavBar/deliveryAddress.dart';
import 'package:book_app/screens/user/bottomNavBar/mydetails.dart';
import 'package:book_app/screens/user/bottomNavBar/orders.dart';
import 'package:book_app/screens/user/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List icons = [
    "assets/order.png",
    "assets/details.png",



    "assets/about.png",
    "assets/contact.png"
  ];

  List text = [
    "Orders",
    "My Details",



    "About Us",
    "Contact Us"
  ];
  List files=[
      Orders(), MyDetails(), About(), Contact()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: Colors.green,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/spl2.png",
                      width: MediaQuery.of(context).size.width*0.1),
                  SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                  Text("ACCOUNT"),
                ],
              ),

              IconButton(onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              }, icon: Icon(Icons.logout_outlined))

            ],
          ),
        ),
        body: Column(
          children: [

            Divider(
              color: Color(0xFFE2E2E2),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: icons.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * 0.001,
                        MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * 0.01),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => files[index]),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(icons[index],
                              height: 25,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Text(
                                text[index],
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                    color: Color(0xFf181725)),
                              )
                            ],
                          ),
                          Image.asset("assets/next.png"),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFFE2E2E2),
                  )
                ],
              ),
            ),

          ],
        ));
  }
}