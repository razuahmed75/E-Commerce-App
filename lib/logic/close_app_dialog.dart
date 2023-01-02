import 'package:flutter/services.dart';
import '../utils/toast.dart';

class PopApp {
  static DateTime? currentBackPressTime;

  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      toast('Press again to exit');
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }
}
