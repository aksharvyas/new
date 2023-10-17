import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_app/screens/user/bottomNavBar/showProductDetail.dart';
import 'package:get/get.dart';
class ShowProductDetail extends StatefulWidget {
  String categoryName;
  @override
  State<ShowProductDetail> createState() => _ShowProductDetailState();

  ShowProductDetail(this.categoryName);
}

class _ShowProductDetailState extends State<ShowProductDetail> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final docref = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .id;

    final userCollection = FirebaseFirestore.instance
        .collection("category")
        .doc(widget.categoryName)
        .collection(widget.categoryName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/spl2.png",
                width: MediaQuery.of(context).size.width * 0.1),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text("BOOK DETAIL")
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                stream: userCollection.snapshots(),

                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                  return Column(
                              children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: docSnap.length,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowUSerProductDetail(
                                                              docSnap[index].id,
                                                              docref,
                                                              docSnap[index][
                                                                  'Image URL'],
                                                              docSnap[index][
                                                                  'Book Name'],
                                                              docSnap[index]['MRP'],
                                                              docSnap[index][
                                                                  'Discounted Price'],
                                                              widget
                                                                  .categoryName,
                                                              docSnap[index][
                                                                  'Authar Name'],
                                                              docSnap[index][
                                                                  'Book Pages'],
                                                              docSnap[index][
                                                                  'Language'],
                                                              docSnap[index][
                                                                  'Quantity'])),
                                                );
                                              },
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  color: Colors.grey[300],
                                                  child: Row(
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
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child: Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.3,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.21,
                                                                  child: Image
                                                                      .network(
                                                                    docSnap[index][
                                                                        'Image URL'],
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ))),
                                                          Padding(
                                                            padding: EdgeInsets.fromLTRB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                0,
                                                                0),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.45,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    docSnap[index][
                                                                        'Book Name'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.05,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons
                                                                          .currency_rupee),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.02,
                                                                      ),
                                                                      Text.rich(
                                                                          TextSpan(
                                                                              children: [
                                                                            TextSpan(
                                                                                text: docSnap[index]['MRP'],
                                                                                style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: MediaQuery.of(context).size.width * 0.04)),
                                                                            TextSpan(text: '    '),
                                                                            TextSpan(
                                                                                text: docSnap[index]['Discounted Price'],
                                                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold)),
                                                                          ])),
                                                                    ],
                                                                  ),
                                                                  Text.rich(
                                                                      TextSpan(
                                                                          children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Auther :  ',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                            )),
                                                                        TextSpan(
                                                                            text:
                                                                                docSnap[index]['Authar Name'],
                                                                            style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                            )),
                                                                      ])),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  Text.rich(
                                                                      TextSpan(
                                                                          children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Language :  ',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                            )),
                                                                        TextSpan(
                                                                            text:
                                                                                docSnap[index]['Language'],
                                                                            style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                            )),
                                                                      ])),
                                                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      FutureBuilder<
                                                                              bool>(
                                                                          future: checkList(
                                                                              docref,
                                                                              docSnap[index]
                                                                                  .id,
                                                                              'add to cart'),
                                                                          builder:
                                                                              (context, AsyncSnapshot<bool> text) {
                                                                            return text.hasError
                                                                                ? Text("Loading...")
                                                                                : text.data == true
                                                                                    ? Row(mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [

                                                                                          IconButton(
                                                                                              onPressed: () async {
                                                                                                if (await checkList(docref, docSnap[index].id, 'add to cart') == true) {
                                                                                                  await FirebaseFirestore.instance.collection('user').doc(docref).collection('add to cart').doc(docSnap[index].id).delete().then((e) {
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
                                                                                                } else if (await checkList(docref, docSnap[index].id, 'add to cart') == false) {
                                                                                                  FirebaseFirestore.instance
                                                                                                      .collection('user')
                                                                                                      .doc(docref)
                                                                                                      .collection('add to cart')
                                                                                                      .doc(docSnap[index].id)
                                                                                                      .set({
                                                                                                        "Category Name": widget.categoryName,
                                                                                                        "Added Date": DateTime.now().toString(),
                                                                                                      })
                                                                                                      .then((value) => Fluttertoast.showToast(
                                                                                                            msg: 'Book Added Successfully',
                                                                                                            toastLength: Toast.LENGTH_LONG,
                                                                                                            gravity: ToastGravity.BOTTOM,
                                                                                                            textColor: Colors.white,
                                                                                                            backgroundColor: Colors.blueGrey,
                                                                                                            fontSize: 16,
                                                                                                          ))
                                                                                                      .onError((error, stackTrace) => Fluttertoast.showToast(
                                                                                                            msg: error.toString(),
                                                                                                            toastLength: Toast.LENGTH_LONG,
                                                                                                            gravity: ToastGravity.BOTTOM,
                                                                                                            textColor: Colors.white,
                                                                                                            backgroundColor: Colors.blueGrey,
                                                                                                            fontSize: 16,
                                                                                                          ))
                                                                                                      .whenComplete(() {
                                                                                                        // setState(() {});
                                                                                                      });
                                                                                                }
                                                                                                ;
                                                                                               setState(() {});
                                                                                              },
                                                                                              icon: Icon(Icons.remove_shopping_cart))
                                                                                        ],
                                                                                      )
                                                                                    : Row(mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [

                                                                                         IconButton(
                                                                                              onPressed: () async {
                                                                                                if (await checkList(docref, docSnap[index].id, 'add to cart') == true) {
                                                                                                  Fluttertoast.showToast(
                                                                                                    msg: 'This Book is already added in Cart',
                                                                                                    toastLength: Toast.LENGTH_LONG,
                                                                                                    gravity: ToastGravity.BOTTOM,
                                                                                                    textColor: Colors.white,
                                                                                                    backgroundColor: Colors.blueGrey,
                                                                                                    fontSize: 16,
                                                                                                  );
                                                                                                } else if (await checkList(docref, docSnap[index].id, 'add to cart') == false) {
                                                                                                  FirebaseFirestore.instance
                                                                                                      .collection('user')
                                                                                                      .doc(docref)
                                                                                                      .collection('add to cart')
                                                                                                      .doc(docSnap[index].id)
                                                                                                      .set({
                                                                                                        "Category Name": widget.categoryName,
                                                                                                        "Added Date": DateTime.now().toString(),
                                                                                                      })
                                                                                                      .then((value) => Fluttertoast.showToast(
                                                                                                            msg: 'Cart Added Successfully',
                                                                                                            toastLength: Toast.LENGTH_LONG,
                                                                                                            gravity: ToastGravity.BOTTOM,
                                                                                                            textColor: Colors.white,
                                                                                                            backgroundColor: Colors.blueGrey,
                                                                                                            fontSize: 16,
                                                                                                          ))
                                                                                                      .onError((error, stackTrace) => Fluttertoast.showToast(
                                                                                                            msg: error.toString(),
                                                                                                            toastLength: Toast.LENGTH_LONG,
                                                                                                            gravity: ToastGravity.BOTTOM,
                                                                                                            textColor: Colors.white,
                                                                                                            backgroundColor: Colors.blueGrey,
                                                                                                            fontSize: 16,
                                                                                                          ))
                                                                                                      .whenComplete(() {
                                                                                                        setState(() {});
                                                                                                      });
                                                                                                }
                                                                                                ;
                                                                                                setState(() {});
                                                                                              },
                                                                                              icon: Icon(Icons.add_shopping_cart),
                                                                                             ),
                                                                                        ],
                                                                                      );
                                                                          }),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(
                                                            0,
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.03,
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                            0),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.1,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            );
                }),
          ],
        ),
      ),
    );
  }

  Future<bool> checkList(
      String docref, String docSnap, String collaction) async {
    bool check = false;
    var a = await FirebaseFirestore.instance
        .collection('user')
        .doc(docref)
        .collection(collaction)
        .doc(docSnap)
        .get();

    if (a.exists) {
      check = true;
    } else {
      check = false;
    }

    return check;
  }
}
