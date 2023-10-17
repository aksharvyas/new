import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final searchController = TextEditingController();
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
              Text("USER DATA",
                style: TextStyle(
                    fontSize: 20
                ),)
            ],
          ),
        ),
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
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
            ),
            StreamBuilder(
              stream:  FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (

                  context, streamSnapshot){
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
          .get('Name')
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
    }).toList();
    }
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
            itemCount: docSnap.length,
          itemBuilder: (context, index) {
          return Card(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(docSnap[index]['Name'],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
                ),),
                SizedBox(
                    height: 5,
                ),
                Text(docSnap[index]['Phone No'],
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                  fontSize: 20
                ),),
                SizedBox(
                  height: 5,
                ),
                Text(docSnap[index]['Email'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                SizedBox(
                  height: 5,
                ),

              ],
            ),
          );
        },);

    })]),
      ));
  }
}
