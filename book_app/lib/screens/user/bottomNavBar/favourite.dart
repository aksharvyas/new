
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_app/screens/user/bottomNavBar/showProductDetail.dart';
import 'package:get/get.dart';

class Favourite extends StatefulWidget {
  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {


  RxInt streamdata = 0.obs;




  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final docref = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .id;

    final userCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(docref)
        .collection('favourite');

    return Scaffold(

      appBar: AppBar( backgroundColor: Colors.green,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/spl2.png",
            width: MediaQuery.of(context).size.width*0.1),
        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
        Text("FAVOURITE")

      ],
    ),
    ),
      body: Container(
        height: double.infinity,
        child: Stack(children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                StreamBuilder(
                    stream: userCollection.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        streamdata.value = streamSnapshot.data!.docs.length;
                        return streamSnapshot.data!.docs.isEmpty ||
                            streamSnapshot.data!.docs.length == 0
                            ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                          child: Center(
                            child: Text(
                              "No Books!!",
                              style: TextStyle(
                                  color: Colors.red, fontSize: 40),
                            ),
                          ),
                        )
                            : SizedBox(
                          height: MediaQuery.of(context).size.height*0.68,
                              child: ListView.builder(
                             physics: BouncingScrollPhysics(),
                              itemCount: streamSnapshot.data!.docs.length,
                              padding: EdgeInsets.only(top: 0.0, bottom: MediaQuery.of(context).size.height * 0.03,),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final docSnap =
                                streamSnapshot.data!.docs[index];

                                return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.height *
                                          0.000,
                                      MediaQuery.of(context).size.width * 0.000,
                                      0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('category')
                                                .doc(docSnap['Category Name'])
                                                .collection(
                                                docSnap['Category Name'])
                                                .doc(docSnap.id)
                                                .snapshots(),
                                            builder:
                                                (context, streamSnapshots) {
                                              return !streamSnapshots.hasData
                                                  ? Center(
                                                child:
                                                Text("Loading......."),
                                              )
                                                  : InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(
                                                    MaterialPageRoute(
                                                        builder: (context) => ShowUSerProductDetail(
                                                            docSnap.id,
                                                            docref,
                                                            streamSnapshots
                                                                .data![
                                                            'Image URL'],
                                                            streamSnapshots
                                                                .data![
                                                            'Book Name'],
                                                            streamSnapshots
                                                                .data![
                                                            'MRP'],
                                                            streamSnapshots
                                                                .data![
                                                            'Discounted Price'],
                                                            docSnap[
                                                            'Category Name'],
                                                            streamSnapshots
                                                                .data![
                                                            'Authar Name'],
                                                            streamSnapshots
                                                                .data![
                                                            'Book Pages'],
                                                            streamSnapshots
                                                                .data![
                                                            'Language'],
                                                            streamSnapshots
                                                                .data![
                                                            'Quantity'])),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.02),
                                                  child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10)),
                                                      color: Colors
                                                          .grey[300],
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.fromLTRB(
                                                                        MediaQuery.of(context).size.width * 0.02,
                                                                        MediaQuery.of(context).size.height * 0.01,
                                                                        0,
                                                                        MediaQuery.of(context).size.height * 0.01),
                                                                    child:
                                                                    SizedBox(
                                                                      width:
                                                                      MediaQuery.of(context).size.width * 0.31,
                                                                      height:
                                                                      MediaQuery.of(context).size.height * 0.2,
                                                                      child:
                                                                      Card(
                                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                        child: Image.network(
                                                                          streamSnapshots.data!['Image URL'],
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.fromLTRB(
                                                                        MediaQuery.of(context).size.width * 0.05,
                                                                        MediaQuery.of(context).size.height * 0.02,

                                                                        0,
                                                                        0),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width * 0.47,
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            streamSnapshots.data!['Book Name'],
                                                                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.065, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height * 0.005,
                                                                          ),
                                                                          Text.rich(TextSpan(children: [
                                                                            TextSpan(
                                                                                text: 'Auther :  ',
                                                                                style: TextStyle(
                                                                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                                )),
                                                                            TextSpan(
                                                                                text: streamSnapshots.data!['Authar Name'],

                                                                                style: TextStyle(
                                                                                    fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                                    fontWeight: FontWeight.w500
                                                                                )),
                                                                          ])),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height * 0.005,
                                                                          ),
                                                                          Text.rich(TextSpan(children: [
                                                                            TextSpan(text: 'Price :  ', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold)),
                                                                            TextSpan(text: streamSnapshots.data!['MRP'], style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: MediaQuery.of(context).size.width * 0.04)),
                                                                            TextSpan(text: '    '),
                                                                            TextSpan(text: streamSnapshots.data!['Discounted Price'], style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold)),
                                                                          ])),


                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height * 0.005,
                                                                          ),
                                                                        Row(
                                                                          children: [
                                                                            Icon(Icons.language_outlined),
                                                                            SizedBox(width: 5,),
                                                                            Text(streamSnapshots.data!['Language'],
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: MediaQuery.of(context).size.width*0.05
                                                                            ),)
                                                                          ],
                                                                        ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height * 0.005,
                                                                          ),

                                                                          Text.rich(TextSpan(children: [
                                                                            TextSpan(
                                                                                text: 'Pages :  ',
                                                                                style: TextStyle(
                                                                                    fontSize: MediaQuery.of(context).size.width * 0.05,
                                                                                    fontWeight: FontWeight.w400
                                                                                )),
                                                                            TextSpan(
                                                                                text: streamSnapshots.data!['Book Pages'],
                                                                                style: TextStyle(
                                                                                    fontSize: MediaQuery.of(context).size.width * 0.055,
                                                                                    fontWeight: FontWeight.w500
                                                                                )),
                                                                          ])),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                  ),
                                                                  IconButton(onPressed: ()async {
                                                                    await FirebaseFirestore.instance.collection('user').doc(docref).collection('favourite').doc(docSnap.id).delete().then((e) {
                                                                      Fluttertoast.showToast(
                                                                        msg: 'Book Deleted Successfully',
                                                                        toastLength: Toast.LENGTH_LONG,
                                                                        gravity: ToastGravity.BOTTOM,
                                                                        textColor: Colors.white,
                                                                        backgroundColor: Colors.blueGrey,
                                                                        fontSize: 16,
                                                                      );
                                                                    }).onError((error, stackTrace) {
                                                                      Fluttertoast.showToast(
                                                                        msg: error.toString(),
                                                                        toastLength: Toast.LENGTH_LONG,
                                                                        gravity: ToastGravity.BOTTOM,
                                                                        textColor: Colors.white,
                                                                        backgroundColor: Colors.blueGrey,

                                                                        fontSize: 16,
                                                                      );
                                                                    });
                                                                  }, icon:Icon(Icons.close))
                                                                ],
                                                              ),
                                                            ],
                                                          ),


                                                        ],
                                                      )),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                      }

                      return const Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),
          // streamdata.value==0?Container():

        ]),
      ),
    );
  }




  Future<bool> checkList(
      String docref, String docSnap, String collaction) async {
    var a = await FirebaseFirestore.instance
        .collection('user')
        .doc(docref)
        .collection(collaction)
        .doc(docSnap)
        .get();

    if (a.exists) {
      return true;
    } else {
      return false;
    }
  }
}
