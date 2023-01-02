import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/svg/svg.dart';

buildCartButton(
    {required void Function()? onPressed,
    required Color bgColor,
    required Color iconColor}) {
  return SizedBox(
    width: 40.w,
    height: 40.w,
    child: MaterialButton(
      elevation: 0,
      color: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
          side: BorderSide(color: Color(0xFF3D82AE))),
      padding: EdgeInsets.all(9.w),
      onPressed: onPressed,
      child: SvgPicture.asset(
        kAddToCart,
        height: 34.h,
        color: iconColor,
      ),
    ),
  );
}
