import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:book_app/screens/user/bottomNavBar/confirmOrder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_app/screens/user/bottomNavBar/showProductDetail.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int? ind;
  RxDouble total = 0.0.obs;
  RxList subtotal = [].obs;
  RxList quantity = [].obs;
  RxList productName = [].obs;
  RxList price = [].obs;
  RxInt streamdata = 0.obs;
  RxList uidList = [].obs;
  RxList categoryList = [].obs;
  RxBool addBool = false.obs;
  Razorpay? _razorpay;

  final searchController = TextEditingController();
  void _handlePaymentSuccess(PaymentSuccessResponse res) async {
    Fluttertoast.showToast(
      msg: res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('order')
        .doc()
        .set({
      "Book Name": productName.value[ind!],

      "Price": price.value[ind!].toString(),
      "Added Date": DateTime.now().toString(),
      //"UID": docref.id
      "Quantity": quantity.value[ind!].toString(),
      "Order Status": "Success",
      "Payment Id": res.paymentId.toString()
    });
    final document = await FirebaseFirestore.instance
        .collection('category')
        .doc(categoryList.value[ind!])
        .collection(categoryList.value[ind!])
        .doc(uidList.value[ind!])
        .get();
    await FirebaseFirestore.instance
        .collection('category')
        .doc(categoryList.value[ind!])
        .collection(categoryList.value[ind!])
        .doc(uidList.value[ind!])
        .update({
      "Quantity":
          (int.parse(document['Quantity']) - quantity.value[ind!]).toString()
    });
  }

  void _handlePaymentError(PaymentFailureResponse res) async {
    Fluttertoast.showToast(
      msg: res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('order')
        .doc()
        .set({
      "Book Name": productName.value[ind!],

      "Price": price.value[ind!].toString(),
      "Added Date": DateTime.now().toString(),
      //"UID": docref.id
      "Quantity": quantity.value[ind!].toString(),
      "Order Status": "Failed",
    });
  }

  void _handlerExternalWallet(PaymentFailureResponse res) async {
    Fluttertoast.showToast(
      msg: res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('order')
        .doc()
        .set({
      "Book Name": productName.value[ind!],

      "Price": price.value[ind!].toString(),
      "Added Date": DateTime.now().toString(),
      //"UID": docref.id
      "Quantity": quantity.value[ind!].toString(),
      "Order Status": "Failed",
    });
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);

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
        .collection('add to cart');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/spl2.png",
                width: MediaQuery.of(context).size.width * 0.1),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              "My CART",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      body:subtotal.isEmpty
          ?Center(
        child: Text("Cart is Empty",
        style: TextStyle(
          color: Colors.red,
          fontSize: 30,
          fontWeight: FontWeight.w600
        ),),
      )
          :   Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(children: [
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {},
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
                        return Center(child: CircularProgressIndicator());
                      }
                      var docSnap = streamSnapshot.data!.docs;
                      // if(searchController.text.length>0){
                      // docSnap = docSnap.where((element) {
                      // return element
                      //     .get('Book Name')
                      //     .toString()
                      //     .toLowerCase()
                      //     .contains(searchController.text.toLowerCase());
                      // }).toList();
                      // }
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.684,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: docSnap.length,
                                padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.height *
                                            0.000,
                                        MediaQuery.of(context).size.width *
                                            0.000,
                                        0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('category')
                                                  .doc(docSnap[index]
                                                      ['Category Name'])
                                                  .collection(docSnap[index]
                                                      ['Category Name'])
                                                  .doc(docSnap[index].id)
                                                  .snapshots(),
                                              builder:
                                                  (context, streamSnapshots) {
                                                // total.value=total.value+int.parse(streamSnapshots.data![
                                                // 'Discounted Price']);
                                                return !streamSnapshots.hasData
                                                    ? const Center(
                                                        child: Text(
                                                            "Loading......."),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                                builder: (context) => ShowUSerProductDetail(
                                                                    docSnap[index]
                                                                        .id,
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
                                                                    docSnap[index]
                                                                        [
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
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                MediaQuery.of(context).size.width * 0.02,
                                                                                MediaQuery.of(context).size.height * 0.01,
                                                                                0,
                                                                                MediaQuery.of(context).size.height * 0.01),
                                                                            child:
                                                                                SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.31,
                                                                              height: MediaQuery.of(context).size.height * 0.25,
                                                                              child: Card(
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
                                                                              width: MediaQuery.of(context).size.width * 0.47,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    streamSnapshots.data!['Book Name'],
                                                                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * 0.003,
                                                                                  ),
                                                                                  // Row(
                                                                                  //   children: [
                                                                                  //   Icon(Icons.)
                                                                                  //   ],
                                                                                  // ),
                                                                                  Text.rich(TextSpan(children: [
                                                                                    TextSpan(
                                                                                        text: 'Auther :  ',
                                                                                        style: TextStyle(
                                                                                          fontSize: MediaQuery.of(context).size.width * 0.045,
                                                                                        )),
                                                                                    TextSpan(text: streamSnapshots.data!['Authar Name'], style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, fontWeight: FontWeight.w500)),
                                                                                  ])),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * 0.003,
                                                                                  ),
                                                                                  Text.rich(TextSpan(children: [
                                                                                    TextSpan(text: '₹  ', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                                                                                    TextSpan(text: streamSnapshots.data!['MRP'], style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: MediaQuery.of(context).size.width * 0.04)),
                                                                                    TextSpan(text: '    '),
                                                                                    TextSpan(text: streamSnapshots.data!['Discounted Price'], style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold)),
                                                                                  ])),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * 0.003,
                                                                                  ),

                                                                                  counterWidget(streamSnapshot.data!.docs.length, index, int.parse(streamSnapshots.data!['Discounted Price']), streamSnapshots.data!['Book Name'], streamSnapshots.data!['Quantity'], docSnap[index].id, docSnap[index]['Category Name']),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      top: MediaQuery.of(context).size.height * 0.01,
                                                                                    ),
                                                                                    child: SizedBox(
                                                                                        width: MediaQuery.of(context).size.width * 0.65,
                                                                                        height: MediaQuery.of(context).size.width * 0.115,
                                                                                        child: ElevatedButton(
                                                                                            onPressed: () async {
                                                                                              setState(() {
                                                                                                ind = index;
                                                                                              });
                                                                                              if (int.parse(streamSnapshots.data!['Quantity']) == 0) {
                                                                                                Fluttertoast.showToast(
                                                                                                  msg: 'Out of Stock',
                                                                                                  toastLength: Toast.LENGTH_LONG,
                                                                                                  gravity: ToastGravity.BOTTOM,
                                                                                                  textColor: Colors.white,
                                                                                                  backgroundColor: Colors.blueGrey,
                                                                                                  fontSize: 16,
                                                                                                );
                                                                                              } else {
                                                                                                makePayment((subtotal[index]).toString(), streamSnapshots.data!['Book Name']);
                                                                                              }
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Colors.green,
                                                                                                shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(30),
                                                                                                )),
                                                                                            child: const Text(
                                                                                              "Buy",
                                                                                              style: TextStyle(fontSize: 18),
                                                                                            ))),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                              onPressed: () async {
                                                                                subtotal.value.clear();
                                                                                quantity.value.clear();
                                                                                categoryList.value.clear();
                                                                                productName.value.clear();
                                                                                price.value.clear();
                                                                                uidList.value.clear();

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
                                                                                setState(() {
                                                                                  addBool.value = true;
                                                                                });
                                                                              },
                                                                              icon: Icon(Icons.close))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
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
                          ),
                         Container(
                                  color: Colors.blue,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              streamdata.value = streamSnapshot
                                                  .data!.docs.length;
                                              total.value = 0.0;
                                              for (int i = 0;
                                                  i < subtotal.length;
                                                  i++) {
                                                total.value =
                                                    total.value + subtotal[i];
                                              }
                                              if (streamdata.value.toInt() !=
                                                  0) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            ConfirmOrder(
                                                              productName:
                                                                  productName,
                                                              quantity:
                                                                  quantity,
                                                              price: price,
                                                              total:
                                                                  total.value,
                                                              uidList: uidList,
                                                              categoryList:
                                                                  categoryList,
                                                            )))
                                                    .then((value) => {});
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: 'Your Cart is Empty',
                                                    backgroundColor:
                                                        Colors.grey,
                                                    gravity:
                                                        ToastGravity.BOTTOM);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.amber,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                )),
                                            child: Text(
                                              "Confirm Order",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                            )),
                                      )
                                    ],
                                  ),
                                )
                        ],
                      );
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget counterWidget(int l, index, discprice, String productN,
      String totalQuantity, String uid, String category) {
    int counter = 1;

    if (subtotal.length != l) {
      uidList.clear();
      subtotal.value.add(counter * discprice.toDouble());
      quantity.value.add(counter);
      productName.add(productN);
      price.add(discprice);
      uidList.add(uid);
      categoryList.add(category);
      // subtotal.add (counter * discprice);
    }

    return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.0003,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  counter == 1
                      ? ''
                      : 'Sub total : ' + subtotal[index].toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (counter != 1) {
                                setState(() {
                                  counter--;
                                  subtotal[index] = counter * discprice;
                                  quantity[index] = counter;
                                });
                                total.value = 0.0;
                                for (int i = 0; i < subtotal.length; i++) {
                                  total.value = total.value + subtotal[i];
                                }
                              }
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                            )),
                        Text(
                          counter.toString(),
                          style: TextStyle(fontSize: 21),
                        ),
                        IconButton(
                            onPressed: () {
                              if (counter == int.parse(totalQuantity) ||
                                  int.parse(totalQuantity) == 0) {
                                Fluttertoast.showToast(
                                    msg: 'Out of Stock',
                                    backgroundColor: Colors.grey,
                                    gravity: ToastGravity.BOTTOM);
                              } else {
                                setState(() {
                                  counter++;
                                  subtotal[index] = counter * discprice;
                                  quantity[index] = counter;
                                });
                              }
                              total.value = 0.0;
                              for (int i = 0; i < subtotal.length; i++) {
                                total.value = total.value + subtotal[i];
                              }
                            },
                            icon: Icon(Icons.add_circle_outline)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  void makePayment(String amount, String description) async {
    final usercol = await FirebaseFirestore.instance
        .collection("user")
        .doc(await FirebaseAuth.instance.currentUser!.uid)
        .get();

    var options = {
      'key': 'rzp_test_Gm4UgIoUYftHlE',
      'amount': (double.parse(amount)) * 100,
      'name': usercol['Name'],
      'description': description,
      'prefill': {'contact': usercol['Phone No'], 'email': usercol['Email']}
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
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
