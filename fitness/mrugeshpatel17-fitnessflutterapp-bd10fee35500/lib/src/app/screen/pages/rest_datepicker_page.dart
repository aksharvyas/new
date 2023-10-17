

import 'package:flutter/material.dart';
import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:fitness_ble_app/src/app/screen/widgets/widgets.dart';
// class CustomPicker extends CommonPickerModel {
//   String digits(int value, int length) {
//     return '$value'.padLeft(length, "0");
//   }
//
//   CustomPicker({required DateTime currentTime, required LocaleType locale}) : super(locale: locale) {
//     this.currentTime = currentTime==null? DateTime.now():currentTime;
//     this.setLeftIndex(this.currentTime.hour);
//     this.setMiddleIndex(this.currentTime.minute);
//     this.setRightIndex(this.currentTime.second);
//   }
//
//   @override
//   String? leftStringAtIndex(int index) {
//     if (index >= 0 && index < 24) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String? middleStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String? rightStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String leftDivider() {
//     return "|";
//   }
//
//   @override
//   String rightDivider() {
//     return "|";
//   }
//
//   @override
//   List<int> layoutProportions() {
//     return [1, 2, 1];
//   }
//
//   @override
//   DateTime finalTime() {
//     return currentTime.isUtc
//         ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
//         this.currentLeftIndex(), this.currentMiddleIndex(), this.currentRightIndex())
//         : DateTime(currentTime.year, currentTime.month, currentTime.day, this.currentLeftIndex(),
//         this.currentMiddleIndex(), this.currentRightIndex());
//   }
// }



class RestDatePickerPage extends StatelessWidget {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: GestureDetector(
            onTap: ()async{

            },
            child: Container(
              decoration:
              BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appBarPng),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(restText,style: appbarTextStyle,),
          //centerTitle: true,
          leadingWidth: 25,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
              },
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Image.asset(backButtonPng,),
            ),
          )
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),

                    initialDatePickerMode: DatePickerMode.year,

                  );
                },
                child: Text(
                  'show date picker(custom theme &date time range)',
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }
}
