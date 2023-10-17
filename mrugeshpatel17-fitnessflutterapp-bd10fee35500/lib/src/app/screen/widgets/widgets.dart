

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget assetCircleImage({required String imageName}){
 return CircleAvatar(
   child: Image.asset(imageName,height: 22,width: 22,),
   radius: 20,
   backgroundColor: Colors.blue,
 );
}

// ClipRRect(
// borderRadius: BorderRadius.circular(20),
// child: Image.asset(
// bicyclePng,
// fit: BoxFit.cover,
// ),
// ),