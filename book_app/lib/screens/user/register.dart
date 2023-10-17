import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final auth= FirebaseAuth.instance;
  final userCollection= FirebaseFirestore.instance.collection("user");
  bool loading=false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Align(alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01,0,
                        MediaQuery.of(context).size.height * 0.09 ),

                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08 , 0, 0, 0),
                  child: Text("Sign Up"


                    ,
                    style: TextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.035
                    ),),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08 ,
                      MediaQuery.of(context).size.width * 0.04, 0,
                      MediaQuery.of(context).size.width * 0.1),
                  child: Text("Enter your credentials to continue",
                    style: TextStyle(color: Color(0xFF7C7C7C),
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.02
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08, 0, 0, 0),
                  child: Text("Name",

                    style: TextStyle(
                        color: Color(0xFf7C7C7C)
                    ),),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.08, 0,  MediaQuery.of(context).size.width * 0.12, 0),
                  child: TextField(
controller: nameController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
                      MediaQuery.of(context).size.height * 0.04, 0, 0),
                  child: Text("Phone No",
                    style: TextStyle(
                        color: Color(0xFf7C7C7C)
                    ),),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.08, 0,  MediaQuery.of(context).size.width * 0.12, 0),
                  child: TextField(
                      controller: phoneController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
                      MediaQuery.of(context).size.height * 0.04, 0, 0),
                  child: Text("Email",
                    style: TextStyle(
                        color: Color(0xFf7C7C7C)
                    ),),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.08, 0,  MediaQuery.of(context).size.width * 0.12, 0),
                  child: TextField(
controller: emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08,
                      MediaQuery.of(context).size.height * 0.04, 0, 0),
                  child: Text("Password",
                    style: TextStyle(
                        color: Color(0xFf7C7C7C)
                    ),),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.08,
                      0,  MediaQuery.of(context).size.width * 0.12, 0),
                  child: TextField(

                   controller: passController,
                  ),
                ),


                Padding(
                  padding: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width * 0.08,
                      MediaQuery.of(context).size.height * 0.07, 0, 0),
                  child: new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.83,
                      height: MediaQuery.of(context).size.height * 0.07,
                      //   height: 67,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading=true;
                            });
                            await  register();
                            setState(() {
                              loading=false;
                            });
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                          },
                          child: Text(
                            "Sign Up",
                            style:
                            TextStyle(fontSize: 16, color: Color(0xFFFFF9FF)),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF53B175),
                              ),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.0),
                                  ))))),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0,  MediaQuery.of(context).size.height * 0.01, 0, 0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an  account?"),
                      TextButton(  onPressed: () {
                       Navigator.of(context).pop();
                      }, child:
                      Text("Log In"))
                    ],
                  ),
                )
              ]
          ),
        )  );
  }
  _create() async {
    final curuser = auth.currentUser!;
    final docref = userCollection.doc(curuser.uid);
    await docref.set({
     "Name": nameController.text.toString(),
      "Phone No": phoneController.text.toString(),
      "Email": emailController.text.toString(),
      "Password": passController.text.toString(),
      "Id": docref.id,
      "UID": curuser.uid,
      "Created Date": DateTime.now(),
      "Admin":false
    });
  }
   register() async {

    //if (_formKey.currentState!.validate() ) {

      FirebaseAuth auth = await FirebaseAuth.instance;
      auth
          .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passController.text.toString(),
      )
          .then((value) async {
        await _create();


        Navigator.pop(context);

      }).onError((error, stackTrace) {
                  print(error.toString());
        Fluttertoast.showToast(
          msg:

          error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          fontSize: 16,
        );
        Navigator.pop(context);
      });
    }
emailSend()async{
  String username = "";
  String password = "";

  final smtpServer = gmail(username, password);
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add('dest@example.com') //recipent email
    ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
    ..text = 'This is the plain text.\nThis is line 2 of the text part.' ;//body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n'+ e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
}

}
