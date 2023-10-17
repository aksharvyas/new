import 'package:flutter/cupertino.dart';
import 'package:kremot/res/strings/AppString.dart';

import '../res/strings/Strings.dart';

import 'colors/AppColors.dart';
import 'dimentions/AppDimension.dart';

class Resources {
  final BuildContext _context;

  Resources(this._context);

  Strings get strings {
    return AppString();
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
