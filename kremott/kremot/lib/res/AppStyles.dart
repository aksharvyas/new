import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';

import '../view/widgets/widget.dart';

hintTextStyle(BuildContext context){
  return TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontSize: getAdaptiveTextSize(context, 12.0));
}

apiMessageTextStyle(BuildContext context, {dynamic fontSize,dynamic color,dynamic fontFamily,dynamic isBold}){
  return TextStyle(
      //fontFamily: fontFamily ?? "Inter",
      fontSize: getAdaptiveTextSize(context, 12.0),
      color: color ?? textColor,
      decoration: TextDecoration.none
    //fontWeight: isBold ?? null ? FontWeight.bold : null
  );
}