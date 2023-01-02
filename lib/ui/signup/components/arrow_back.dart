import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/my_colors.dart';

class ArrowBack extends StatelessWidget {
  final void Function()? onTap;
  const ArrowBack({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(50).w,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30).w,
          child: Container(
            color: Colors.blue.shade500,
            width: 50.w,
            height: 50.w,
            alignment: Alignment(.4.w, 0.h),
            child: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
        ));
  }
}
