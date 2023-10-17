import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _cartState();
}

class _cartState extends State<UserHome> {
  final List<String> images = [
    'https://cdn.exoticindia.com/images/products/original/books/nzf821.jpg',
    'https://m.media-amazon.com/images/I/71JjfB6RByL.jpg',
 'https://gumlet.assettype.com/swarajya/2022-12/f434309f-9308-4278-a2f0-b1bf765658d1/Year_end_book_piece.png',
 'https://1.bp.blogspot.com/-2Dmddx1EpNk/X0_Y7b5FCBI/AAAAAAAARYs/jPIwR0JUNdgsQ1Rh2DvrjvdNiLwN_T68ACLcBGAsYHQ/w1040/IMG_2364.jpg'
  ];

  // Define the current index of the carousel
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.green,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset("assets/spl2.png",
            width: MediaQuery.of(context).size.width*0.1),
            SizedBox(width: MediaQuery.of(context).size.width*0.03,),



            Text("ALL IN ONE ONLINE BOOK STORE",
              style: TextStyle(
                fontSize: 20
              ),
               ),


          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.fromLTRB(0,
                    //  MediaQuery.of(context).size.width * 0.07,
                    MediaQuery.of(context).size.width * 0.050,
                    //   MediaQuery.of(context).size.width * 0.07,
                    0,
                    0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                        children:[
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(),

                            child:  CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  decoration: BoxDecoration(



                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Container( width: MediaQuery.of(context).size.height * 0.8,

                                      decoration: BoxDecoration(
                                        color: Colors.black
                                      ),
                                      child: Image.network(
                                        images[index],
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width*0.8,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(

                                height: 240,
                                enlargeCenterPage: true,
                                aspectRatio: double.infinity,
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                //autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                viewportFraction: 2.0,
                                onPageChanged: (index, reason) => setState(() => _currentIndex = index),
                              ),
                            ),
                          ),
                          Align(alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height * 0.258 , 0, 0),
                              child: AnimatedSmoothIndicator(
                                activeIndex: _currentIndex,
                                count: images.length,
                                effect: ExpandingDotsEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.white,
                                  dotWidth: 4.5,
                                  dotHeight: 4.5,
                                ),
                              ),
                            ),
                          ), ]
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 50,
                margin:EdgeInsets.fromLTRB(10, 15, 10, 10),
                shadowColor: Colors.black,
                color: Colors. orange[100],
                child: SizedBox(
                  width:double.infinity,
                  height:  MediaQuery.of(context).size.height*0.49,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text('Most Liked Books',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: GridView.count(
                              scrollDirection: Axis.vertical,
                              childAspectRatio:
                              MediaQuery.of(context).size.width/(
                                  MediaQuery.of(context).size.height/1.2
                              ),
                              shrinkWrap: true,
                              // physics:NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              children: [
                                Container(


                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[500],
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://m.media-amazon.com/images/I/41FS6MNKJ3L._SX395_BO1,204,203,200_.jpg",
                                          ), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                     const    SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                       const  Text(
                                          'ILETS 2023',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 900',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]  ),
                                ),

                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[500],
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://tse3.mm.bing.net/th?id=OIP.HrUp1Bp9ak6WdnivGNI-zAHaJt&pid=Api&P=0"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'BHagvat Geeta',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 400',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),

                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[500],
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://tse2.mm.bing.net/th?id=OIP.qgrWpYfMbQg-5X_FiD2OVwHaLk&pid=Api&P=0"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Oxford Books',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 1100',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[500],
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://images-na.ssl-images-amazon.com/images/I/51ySpJqQ7ML.jpg"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Stock Market',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 600',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[500],
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://d1m75rqqgidzqn.cloudfront.net/wp-data/2019/12/20122909/book-4-edit-683x1024.jpg"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Machine Lerning',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 1453',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ),//Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[500],
                                          radius: 50,
                                          child: const CircleAvatar(
                                           // foregroundImage: NetworkImage("https://i.pinimg.com/originals/87/f2/c6/87f2c6fb259e5a74120cf32b1308906c.png"),
                                            backgroundImage: NetworkImage(
                                                "https://i.pinimg.com/originals/87/f2/c6/87f2c6fb259e5a74120cf32b1308906c.png",), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Future of IoT',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 999',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ),//Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.black87,
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://tse3.mm.bing.net/th?id=OIP.JLsJbweLtbwRaZII9zPDBQHaLH&pid=Api&P=0"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Spce Technology',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 599',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ),//Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.black87,
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://tse4.mm.bing.net/th?id=OIP.ojXUTjR3bAw-t8oDGHbT4AAAAA&pid=Api&P=0"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Game Book 2023',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 400',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox

                                      ]
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.black87,
                                          radius: 50,
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://tse3.mm.bing.net/th?id=OIP.Syq-fBJPPlH7bGME6PeFwAHaKE&pid=Api&P=0"), //NetworkImage
                                            radius: 100,
                                          ), //CircleAvatar
                                        ), //CircleAvatar
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Text(
                                          'Oxford Physics',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text.rich(TextSpan(
                                                text: 'Price :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: ' 2000',
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                                                  )
                                                ]
                                            )),
                                          ],
                                        ), //Text
                                        const SizedBox(
                                          height: 10,
                                        ), //SizedBox
                                        // SizedBox(
                                        //   width: 100,
                                        //   child: ElevatedButton(
                                        //     onPressed: () => Navigator.of(context)
                                        //         .push(MaterialPageRoute(builder: (context) => const product_detail())),
                                        //     style: ButtonStyle(
                                        //         backgroundColor:
                                        //         MaterialStateProperty.all(Colors.green)),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.all(4),
                                        //       child: Row(
                                        //         children: const [
                                        //           Text('Buy Now')
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ]
                                  ),
                                )
                              ]
                          ),
                        ),
                      ],
                    ), //Column
                  ), //Padding
                ), //SizedBox
              ), //Card
            ],
          ),
        ),
      ),
    );
  }
}