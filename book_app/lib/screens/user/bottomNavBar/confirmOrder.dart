import 'package:book_app/screens/user/bottomNavBar/bootomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmOrder extends StatefulWidget {
  List productName, quantity, price, uidList, categoryList;
  double total;

  ConfirmOrder(
      {required this.productName,
      required this.quantity,
      required this.price,
      required this.total,
      required this.uidList,
      required this.categoryList});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final addressController = TextEditingController();
  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse res) async {
    Fluttertoast.showToast(
      msg: res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );
    for (int i = 0; i < widget.uidList.length; i++) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('order')
          .doc()
          .set({
        "Book Name": widget.productName[i],

        "Price": widget.price[i].toString(),
        "Added Date": DateTime.now().toString(),
        //"UID": docref.id
        "Quantity": widget.quantity[i].toString(),
        "Order Status": "Success",
        "Payment Id": res.paymentId.toString()
      });
      final document = await FirebaseFirestore.instance
          .collection('category')
          .doc(widget.categoryList[i])
          .collection(widget.categoryList[i])
          .doc(widget.uidList[i])
          .get();
      await FirebaseFirestore.instance
          .collection('category')
          .doc(widget.categoryList[i])
          .collection(widget.categoryList[i])
          .doc(widget.uidList[i])
          .update({
        "Quantity":
            (int.parse(document['Quantity']) - widget.quantity[i]).toString()
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
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
    for (int i = 0; i < widget.uidList.length; i++) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('order')
          .doc()
          .set({
        "Book Name": widget.productName[i],

        "Price": widget.price[i].toString(),
        "Added Date": DateTime.now().toString(),
        //"UID": docref.id
        "Quantity": widget.quantity[i].toString(),
        "Order Status": "Failed"
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
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
    for (int i = 0; i < widget.uidList.length; i++) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('order')
          .doc()
          .set({
        "Book Name": widget.productName[i],

        "Price": widget.price[i].toString(),
        "Added Date": DateTime.now().toString(),
        //"UID": docref.id
        "Quantity": widget.quantity[i].toString(),
        "Order Status": "Failed"
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.02,
                        right: MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      children: [
                        // SizedBox(
                        //     width: MediaQuery.of(context).size.width*0.14,
                        //     child: Text("Sr No",
                        //     style: TextStyle(
                        //       fontSize:  MediaQuery.of(context).size.width*0.05,
                        //       fontWeight: FontWeight.bold
                        //     ),)),

                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: Text(
                              "Product Title",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.3,

                    child: ListView.builder(
                        itemCount: widget.quantity.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.02,
                                right: MediaQuery.of(context).size.height * 0.02,
                                bottom: MediaQuery.of(context).size.height * 0.005,
                                top: MediaQuery.of(context).size.height * 0.005),
                            child: Card(
                              child: Row(
                                children: [
                                                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.44,
                                    child: Text(
                                      widget.productName[index],
                                      style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.04,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.25,
                                      child: Text(
                                        widget.quantity[index].toString(),
                                        style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(context).size.width *
                                                    0.04,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      child: Text(
                                        widget.price[index].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                MediaQuery.of(context).size.width *
                                                    0.05),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Delivery Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      maxLines: 5,
                      controller: addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.32,),
                  Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.currency_rupee, weight: 5.0),
                            Text(
                              widget.total.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (addressController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Enter Delivery Address',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.blueGrey,
                                  fontSize: 16,
                                );
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(await FirebaseAuth
                                    .instance.currentUser!.uid)
                                    .update({
                                  "Address": addressController.text.toString()
                                });
                                makePayment(widget.total.toInt().toString(),
                                    widget.productName.toString());
                              }
                            },
                            child: Text(
                              "Place Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),

          ]),
        ),
      ),
    );
  }

  void makePayment(String amount, String description) async {
    final usercol = await FirebaseFirestore.instance
        .collection("user")
        .doc(await FirebaseAuth.instance.currentUser!.uid)
        .get();

    var options = {
      'key': 'rzp_test_Gm4UgIoUYftHlE',
      'amount': int.parse(amount) * 100,
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

  func() async {
    var userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(await FirebaseAuth.instance.currentUser!.uid)
        .get();

    userData['Address'].toString() == null
        ? addressController.text = ''
        : addressController.text = userData['Address'];
  }
}
