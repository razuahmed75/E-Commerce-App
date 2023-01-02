import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';

Widget header() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 50,
      top: 60,
    ).w,
    child: SizedBox(
      height: 100.h,
      width: ScreenUtil().screenWidth,
      child: Text(
        'Sign In',
        style: GoogleFonts.actor(
            fontSize: 20.sp, color: white, letterSpacing: 0.7.w),
      ),
    ),
  );
}
