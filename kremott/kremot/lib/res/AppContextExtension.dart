import 'package:flutter/cupertino.dart';
import 'package:kremot/res/Resources.dart';


extension AppContextExtension on BuildContext {
  Resources get resources => Resources.of(this);
}

