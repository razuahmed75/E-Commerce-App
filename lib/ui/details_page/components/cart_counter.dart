import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  late bool _decreamentButton;
  late bool _increamentButton;
  @override
  void initState() {
    _decreamentButton = false;
    _increamentButton = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlinedButton(
            splashColor: _decreamentButton == false
                ? Colors.transparent
                : Colors.grey.shade400,
            highlightElivation: _decreamentButton == false ? 0 : 8,
            elevation: _decreamentButton == false ? 0 : 2,
            icon: Icon(
              Icons.remove,
              color: _decreamentButton ? black : Colors.grey[400],
            ),
            press: () {
              setState(() {
                if (numOfItems > 1) {
                  numOfItems--;
                  _increamentButton = true;
                }
                if (numOfItems == 1) {
                  _decreamentButton = false;
                }
              });
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            numOfItems.toString().padLeft(2, '0'),
            style: GoogleFonts.robotoMono(color: kTextColor, fontSize: 16.sp),
          ),
        ),
        buildOutlinedButton(
            splashColor: _increamentButton == false
                ? Colors.transparent
                : Colors.grey.shade400,
            highlightElivation: _increamentButton == false ? 0 : 8,
            elevation: _increamentButton == false ? 0 : 2,
            press: () {
              setState(() {
                if (numOfItems < 5) {
                  numOfItems++;
                  _decreamentButton = true;
                }
                if (numOfItems == 5) {
                  _increamentButton = false;
                }
              });
            },
            icon: Icon(
              Icons.add,
              color: _increamentButton ? black : Colors.grey[400],
            )),
      ],
    );
  }

  SizedBox buildOutlinedButton({
    Icon? icon,
    void Function()? press,
    Color? splashColor,
    double? highlightElivation,
    double? elevation,
  }) {
    return SizedBox(
      width: 40.w,
      height: 30.h,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        elevation: elevation,
        splashColor: splashColor,
        highlightElevation: highlightElivation,
        color: Colors.grey.shade200,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
        onPressed: press,
        child: icon,
      ),
    );
  }
}
