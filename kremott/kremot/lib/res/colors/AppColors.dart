import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kremot/res/colors/BaseColors.dart';


class AppColors implements BaseColors {
  final Map<int, Color> _primary = {
    50: const Color(0xff484949 ),//10%
    100: const Color(0xff484949),//20%
    200: const Color(0xff484949),//30%
    300: const Color(0xff484949),//40%
    400: const Color(0xff484949),//50%
    500: const Color(0xff484949),//60%
    600: const Color(0xff484949),//70%
    700: const Color(0xff484949),//80%
    800: const Color(0xff484949),//90%
    900: const Color(0xff484949),//100%
  };

  @override
  MaterialColor get colorAccent => Colors.amber;

  @override
  MaterialColor get colorPrimary => MaterialColor(0xff484949, _primary);

  @override
  Color get colorPrimaryText => const Color(0xff49ABFF);

  @override
  Color get colorSecondaryText => const Color(0xff3593FF);

  @override
  Color get colorWhite => const Color(0xfff5edee);

  @override
  Color get colorBlack => const Color(0xff5C5455);

  @override
  Color get castChipColor => Colors.deepOrangeAccent;

  @override
  Color get catChipColor => Colors.indigoAccent;

  @override
  Color get colorTextFieldBg => const Color(0xb81b1918);

  @override
  Color get colorDialogBg => const Color(0xb81b1918);


}
