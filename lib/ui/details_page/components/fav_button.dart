import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;

  const FavButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.w,
      height: 32.w,
      child: MaterialButton(
          color: Color(0xFFFF6464),
          padding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.w)),
          onPressed: onPressed,
          child: icon),
    );
  }
}
