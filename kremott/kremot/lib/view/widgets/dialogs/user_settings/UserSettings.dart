import 'package:flutter/material.dart';
import '../../../../utils/Utils.dart';
import 'UserSettingsDialog.dart';

void createSettingDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return UserSettingsDialog(width, height);
  });

}
