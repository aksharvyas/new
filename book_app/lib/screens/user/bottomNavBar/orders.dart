import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/spl2.png",
                width: MediaQuery.of(context).size.width*0.1),
            SizedBox(width: MediaQuery.of(context).size.width*0.03,),



            Text("ORDERS",
              style: TextStyle(
                  fontSize: 20
              ),
            ),


          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (v){
                setState(() {

                });
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Book',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('order').orderBy('Added Date', descending: false).snapshots(),
              builder: (context, streamSnapshot){

                if (streamSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(

                      ));
                }
                var docSnap =
                    streamSnapshot.data!.docs;
                if(searchController.text.length>0){
                  docSnap = docSnap.where((element) {
                    return element
                        .get('Book Name')
                        .toString()
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();
                }
                return ListView.builder(
                  itemCount: docSnap.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){

                  return  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Card(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text(DateFormat.yMMMMd().format(DateTime.parse(docSnap[index]['Added Date']))),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(docSnap[index]['Book Name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  Row(
                                    children: [
                                      Icon(Icons.currency_rupee,
                                          size: 20),
                                      SizedBox(width: 5,),
                                      Text(docSnap[index]['Price'].toString()),
                                      SizedBox(width: 5,),
                                      Text("X"),
                                      SizedBox(width: 5,),
                                      Text(docSnap[index]['Quantity'].toString())
                                    ],
                                  ),

                                ],
                              ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(docSnap[index]['Order Status'],
                              style: (
                              TextStyle(
                                color:docSnap[index]['Order Status']=="Success"?Colors.green:Colors.red,
                                fontWeight: FontWeight.bold
                              )
                              ),),
                              Text("TOTAL :  "+(int.parse(docSnap[index]['Price'])*int.parse(docSnap[index]['Quantity'])).toString())
                            ],
                          ),
                          docSnap[index]['Order Status']=="Success"?
                          Row(
                            children: [
                              Text("Payment Id:  "),
                              Text(docSnap[index]['Payment Id'])
                            ],
                          ):Container()
                        ],
                      ),
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }
}
