import 'package:book_app/screens/admin/addProduct.dart';
import 'package:flutter/material.dart';
import '../user/login.dart';
import 'showUser.dart';
import 'showProduct.dart';
import 'addCategory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();

}

class _AdminHomeState extends State<AdminHome> {
  int? data;
  List colors=[Colors.green, Colors.yellow, Colors.pink, Colors.cyan];
  List type=["User", "Product", "Add Category", "Add Product"];
  List navigation = [ShowUser(),ShowProduct(),AddCategory(), AddProduct()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Book App Admin            "),
            IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut().whenComplete(() => {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),

              )
              });

            }, icon: Icon(Icons.logout))
          ],
        ),
      ),
            body: Column(
              children: [
                // FutureBuilder(builder: (context, snap){})
//  Text(FirebaseAuth.instance.currentUser!.uid.toString()),
                GridView.builder(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03
                      ,top:  MediaQuery.of(context).size.height*0.02,
                  right: MediaQuery.of(context).size.width*0.03 ),
                  shrinkWrap: true,
                  itemCount: colors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing:  MediaQuery.of(context).size.width*0.05,
                    mainAxisSpacing: MediaQuery.of(context).size.width*0.05,
                ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => navigation[index],
                          )
                          );
                        },
                        child: Container(

                          decoration: BoxDecoration(
                          color: colors[index],borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width*0.05)),
                           border: Border.all(color: Colors.black)
                          ),
                          height: double.infinity/2,
                          width: double.infinity/2,
                          child: Center(
                            child:
                            type[index]=="User"?
                                Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(data.toString()=='null'?"Loading ...":data.toString(),
                              style: GoogleFonts.vesperLibre(fontSize: MediaQuery.of(context).size.width*0.05, color: Colors.white)
                          ),
                                    Text(type[index],
                                    style: GoogleFonts.vesperLibre(fontSize: MediaQuery.of(context).size.width*0.05, color: Colors.white)
                                    )
                                  ],
                                ):
                            Text(type[index],
                                style: GoogleFonts.vesperLibre(fontSize: MediaQuery.of(context).size.width*0.05, color: Colors.white)
                            ),
                          )
                        ),
                      );
                    },)
              ],
            ),
    );
  }
  Future countUser()async{
    final docSnap = await FirebaseFirestore.instance.collection("user").get();
    print(docSnap.docs.length);
   data= docSnap.docs.length;
  }
}
