import 'package:fitness_ble_app/src/app/screen/pages/ble_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings_Page extends StatefulWidget {
  const Settings_Page({Key? key}) : super(key: key);

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}

class _Settings_PageState extends State<Settings_Page> {
  final bleLengthController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    bleLength();
    super.initState();
  }
  bleLength()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int bleLength = await prefs.getInt("BleLength") ?? 5000;
    bleLengthController.text =bleLength.toString();
  }
  @override
  Widget build(BuildContext context) {
Future <bool>boolll()async{
  return true;
}
    return  WillPopScope(
        onWillPop: () =>
boolll(),
        child: new Scaffold(

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Set a length for BLE Device",
            // style: TextStyle(
            //   color: Colors.blue,
            //   fontSize: 25
            // )),
            SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: bleLengthController,
              decoration: InputDecoration(
suffixIcon: IconButton(
  onPressed: (){
bleLengthController.clear();
  },icon: Icon(Icons.cancel,color: Colors.grey, size: 25,),
),

                border: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(

                child: Text(
                  'Submit',
                  style: TextStyle(),
                ),
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt("BleLength", bleLengthController.text.length==0?0:int.parse(bleLengthController.text.toString()));
                print("blelength"+await prefs.getInt("BleLength").toString());
                Navigator.pop(context);
              },),

          ],
        ),
      ),

    ));
  }
}
