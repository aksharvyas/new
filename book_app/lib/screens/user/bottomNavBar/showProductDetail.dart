import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bootomNavBar.dart';
class ShowUSerProductDetail extends StatefulWidget {
  String productID;
  String userID;
  String image;
  String bookName;
  String MRP;
  String discPrice;
  String categoryName;
  String autherName;
  String bookPage;
  String language;
  String quantity;

  @override
  State<ShowUSerProductDetail> createState() => _ShowUSerProductDetailState();

  ShowUSerProductDetail(
      @required this.productID,
      @required this.userID,
      @required this.image,
      @required this.bookName,
      @required this.MRP,
      @required this.discPrice,
      @required this.categoryName,
      @required this.autherName,
      @required this.bookPage,
      @required this.language,
      @required this.quantity);
}

class _ShowUSerProductDetailState extends State<ShowUSerProductDetail> {

  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse  res)async{
    Fluttertoast.showToast(
      msg:res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );

    await FirebaseFirestore.instance.collection('user').
    doc(FirebaseAuth.instance.currentUser!.uid).collection('order').doc().set(
        {
          "Book Name": widget.bookName,

          "Price": widget.discPrice.toString(),
          "Added Date": DateTime.now().toString(),
          //"UID": docref.id
          "Quantity": widget.quantity.toString(),
          "Order Status":"Success",
          "Payment Id": res.paymentId.toString()
        });
    final document = await FirebaseFirestore.instance.collection('category').doc(widget.categoryName)
        .collection(widget.categoryName).doc(widget.productID).get();
    await FirebaseFirestore.instance.collection('category').doc(widget.categoryName)
        .collection(widget.categoryName).doc(widget.productID).update({
      "Quantity": (int.parse(document['Quantity'])-int.parse(widget.quantity)).toString()
    })  ;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  void _handlePaymentError(PaymentFailureResponse res)async{
    Fluttertoast.showToast(
      msg:res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );

    await FirebaseFirestore.instance.collection('user').
    doc(FirebaseAuth.instance.currentUser!.uid).collection('order').doc().set(
        {
          "Book Name": widget.bookName,

          "Price": widget.discPrice.toString(),
          "Added Date": DateTime.now().toString(),
          //"UID": docref.id
          "Quantity": widget.quantity.toString(),
          "Order Status":"Failed"
        });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }


  void _handlerExternalWallet(PaymentFailureResponse res)async{
    Fluttertoast.showToast(
      msg:res.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.blueGrey,
      fontSize: 16,
    );

    await FirebaseFirestore.instance.collection('user').
    doc(FirebaseAuth.instance.currentUser!.uid).collection('order').doc().set(
        {
          "Book Name": widget.bookName,

          "Price": widget.discPrice.toString(),
          "Added Date": DateTime.now().toString(),
          //"UID": docref.id
          "Quantity": widget.quantity.toString(),
          "Order Status":"Failed"
        });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  @override
  void initState() {

    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR , _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
    super.initState();
  }

  void makePayment(String amount,String description, )async{
   final usercol = await FirebaseFirestore.instance.collection("user").
   doc(await FirebaseAuth.instance.currentUser!.uid).get();

    var options = {
      'key': 'rzp_test_Gm4UgIoUYftHlE',
      'amount': int.parse(amount)*100,
      'name': usercol['Name'],
      'description': widget.bookName,
      'prefill': {
        'contact': usercol['Phone No'],
        'email': usercol['Email']
      }
    };
    try{
      _razorpay?.open(options);
    }
    catch(e){
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/spl2.png",
                  width: MediaQuery.of(context).size.width*0.1),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              Text("BOOK DETAIL")

            ],
          ),
        ),
      body: Stack(
        children: [Container(color: Colors.grey[300],
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .5,
        ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height * .35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.image),
                      fit: BoxFit.fill
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(0, -4),
                        blurRadius: 8)
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                         widget.bookName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )),
                        FutureBuilder<bool> (
                            future: checkList(widget.userID, widget.productID, 'favourite'),
                            builder: (context, AsyncSnapshot<bool>text){
                              print(text.data);
                              return InkWell(
                                onTap: ()async {

                                  if (await checkList(
                                      widget.userID,
                                      widget.productID,
                                      'favourite') ==
                                      true) {
                                    await FirebaseFirestore.instance.collection('user').doc(widget.userID).collection('favourite').doc(widget.productID).delete().then((e)  {

                                      Fluttertoast.showToast(
                                        msg:'Book removed from favourite',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.blueGrey,
                                        fontSize: 16,
                                      );

                                    })
                                        .onError((error, stackTrace)  {
                                      Fluttertoast.showToast(
                                        msg:
                                        error.toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.blueGrey,
                                        fontSize: 16,
                                      );


                                    });

                                  } else if (await checkList(
                                      widget.userID,
                                      widget.productID,
                                      'favourite') ==
                                      false) {
                                    FirebaseFirestore
                                        .instance
                                        .collection(
                                        'user')
                                        .doc(
                                        widget.userID)
                                        .collection(
                                        'favourite')
                                        .doc(widget.productID)
                                        .set({
                                      "Category Name":
                                      widget.categoryName,
                                      "Added Date":
                                      DateTime.now().toString(),
                                    })
                                        .then((value) =>
                                        Fluttertoast
                                            .showToast(
                                          msg: 'Book added to favourite',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.blueGrey,
                                          fontSize: 16,
                                        ))
                                        .onError((error,
                                        stackTrace) =>
                                        Fluttertoast.showToast(
                                          msg: error.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.blueGrey,
                                          fontSize: 16,
                                        )).whenComplete(() {
                                      setState(() {

                                      });
                                    });

                                  }
                                  ;
                                  setState(() {

                                  });
                                },
                                child: text.data==true?Icon(Icons.favorite, color: Colors.red,):Icon(Icons.favorite_border),
                              );

                              }),

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, right: 30, bottom: 0),
                        child: Container(
                            child: Text(widget.autherName,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 30),
                    child: Row(
                      children: [
                        Text(
                         int.parse(widget.quantity)==0?'Out of Stock': 'In stock',
                          style: TextStyle(
                              color:   int.parse(widget.quantity)==0?Colors.red:Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 30, bottom: 0),
                          child: Text.rich(TextSpan(
                              text: 'MRP :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: widget.MRP,
                                  style: TextStyle(

                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ]))),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 30, bottom: 0),
                          child: Text.rich(TextSpan(
                              text: 'Our price :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: widget.discPrice,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )
                              ]))),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 30, bottom: 0),
                          child: Text.rich(TextSpan(
                              text: 'You save :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: (int.parse(widget.MRP)-int.parse(widget.discPrice)).toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                )
                              ]))),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: ()async {

                          if (await checkList(
                          widget.userID,
                          widget.productID
                              ,
                          'add to cart') ==
                          true) {
                          Fluttertoast
                              .showToast(
                          msg: 'This Book is already added in Cart',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          fontSize: 16,
                          );

                          } else if (await checkList(
                              widget.userID,
                              widget.productID
                              ,
                          'add to cart') ==
                          false) {
                          FirebaseFirestore
                              .instance
                              .collection(
                          'user')
                              .doc(
                              widget.userID)
                              .collection(
                          'add to cart')
                              .doc(widget.productID
                              )
                              .set({
                          "Category Name":
                          widget.categoryName,
                          "Added Date":
                          DateTime.now().toString(),
                          })
                              .then((value) =>
                          Fluttertoast
                              .showToast(
                          msg: 'Cart Added Successfully',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          fontSize: 16,
                          ))
                              .onError((error,
                          stackTrace) =>
                          Fluttertoast.showToast(
                          msg: error.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          fontSize: 16,
                          )).whenComplete(() {
                          setState(() {

                          });
                          });

                          };
                          setState(() {

                          });
                        },
                        child: Text('Add To Cart',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(

                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          primary: Colors.yellow,
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(  int.parse(widget.quantity)==0){
                            Fluttertoast.showToast(
                              msg:'Out of Stock',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              fontSize: 16,
                            );
                          }
                          else{
                            makePayment(widget.discPrice, widget.bookName);
                          }

                        },
                        child: Text('Buy Now',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 90.0, vertical: 20.0),
                          primary: Colors.orange,
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
  Future<bool> checkList(
      String docref, String docSnap, String collaction) async {
    bool check=false;
    var a = await FirebaseFirestore.instance
        .collection('user')
        .doc(docref)
        .collection(collaction)
        .doc(docSnap)
        .get();

    if (a.exists) {
      check= true;
    } else {
      check= false;
    }

    return check;

  }
}
