import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.green,

        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/spl2.png",
                width: MediaQuery.of(context).size.width*0.1),
            SizedBox(width: MediaQuery.of(context).size.width*0.03,),



            Text("ABOUT US",
              style: TextStyle(
                  fontSize: 20
              ),
            ),


          ],
        ),
      ),
      body: Center(
        child: Card(
          color: Colors.grey[300],
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: mediaQuery.size.width * 0.25,
                   backgroundColor: Colors.green,
                  backgroundImage: AssetImage("assets/spl2.png"), // Replace with your app logo image
                ),
                SizedBox(height: 20),
                Text(
                  'All in One book store app',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Version 7.0',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'All in one book store app provides you the most friendly environment for purchasing and also provides the favourite option which helps to buy the books in future when ever required.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Contact us:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: info@allinonebookstoreapp.com',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Phone: +91 990-996-0290',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
