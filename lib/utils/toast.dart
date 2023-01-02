import 'package:fluttertoast/fluttertoast.dart';
import '../constants/my_colors.dart';

void toast(String msg) {
  Fluttertoast.showToast(
    gravity: ToastGravity.BOTTOM,
    msg: msg,
    backgroundColor: white,
    textColor: black,
  );
}
