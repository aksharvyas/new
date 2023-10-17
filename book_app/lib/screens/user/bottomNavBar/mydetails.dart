import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
class MyDetails extends StatefulWidget {
  const MyDetails({Key? key}) : super(key: key);

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  bool loading=false;
  @override
  void initState(){
   func();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/spl2.png",
                width: MediaQuery.of(context).size.width * 0.1),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text("MY DETAILS",
              style: TextStyle(
                  fontSize: 20
              ),)
          ],
        ),
      ),
      body: SafeArea(

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.08,
          vertical: Get.height*0.04),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              TextField(
                readOnly: true,
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              TextField(

                maxLines: 5,
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.83,
                  height: MediaQuery.of(context).size.height * 0.07,
                  //   height: 67,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                      await FirebaseFirestore.instance.collection('user').doc(await FirebaseAuth.instance.currentUser!.uid).update({
                        "Name": nameController.text,
                        "Email": emailController.text,
                        "Phone No":phoneController.text,
                        "Address":addressController.text,
                      });
                        setState(() {
                          loading = false;
                        });
                      },
                      child: loading == true
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        "Update",
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
            ],
          ),
        ),
      ),
    );
  }
  func()async{
    var userData=await FirebaseFirestore.instance.collection('user').doc(await FirebaseAuth.instance.currentUser!.uid).get();
    nameController.text=userData['Name'];
    phoneController.text=userData['Phone No'];
    emailController.text=userData['Email'];
    userData['Address'].toString()==null?addressController.text='':addressController.text=userData['Address'];

  }
}
