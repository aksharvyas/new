import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:flutter/material.dart';

Widget textFieldWidget(
    {required String hintText,
    bool obscureText = false,
    required TextEditingController controller,
    required TextInputType? keyboardType,
      bool readOnly = false,
    required TextInputAction? textInputAction,
      required GestureTapCallback onTap,
    required VoidCallback onEditingComplete}) {
  return TextField(
      readOnly:readOnly,
    controller: controller,
    enabled: true,
    onTap: onTap,
    textAlign: TextAlign.left,
    keyboardType: keyboardType,
    obscureText: obscureText,
    style: textFieldTextStyle.copyWith(
        color: Colors.black, fontWeight: FontWeight.normal),
    textInputAction: textInputAction,
    onEditingComplete: onEditingComplete,
    decoration: new InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: textFieldTextStyle,
      fillColor: Colors.white,
      hoverColor: Colors.white,
      enabledBorder: new OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          const Radius.circular(
            12.0,
          ),
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          const Radius.circular(
            12.0,
          ),
        ),
      ),
      filled: true,
      contentPadding: EdgeInsets.all(16),
    ),
  );
}

Widget materialButtonWidget({onPressed,required bool showLoader, required String text}) {
  if (showLoader) {
    return MaterialButton(
      onPressed: null,
      textColor: Colors.white,
      //splashColor: Colors.greenAccent,
      //elevation: 8.0,
      child: Container(
        height: 50,
        width: 180,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage(raisedButtonPng), fit: BoxFit.cover),
        ),child: Center(child: Container(
              height: 25.0,
              width: 25.0,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  strokeWidth: 3,
                ),
              ),
            ),)  ,
      ),

    );
  } else {
    return MaterialButton(
      onPressed: onPressed,
      textColor: Colors.white,
      //splashColor: Colors.greenAccent,
      //elevation: 8.0,
      child: Container(
        height: 50,
        width: 180,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage(raisedButtonPng), fit: BoxFit.cover),
        ),
        child: Text(text, style: buttonTextStyle,),
      ),

    );
  }
}