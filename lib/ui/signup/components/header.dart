import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';
import 'arrow_back.dart';

Widget header() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 50,
      top: 50,
    ).w,
    child: SizedBox(
      height: 100.h,
      width: ScreenUtil().screenWidth,
      child: Row(
        children: [
          /// get back
          ArrowBack(
            onTap: () => Get.back(),
          ),
          SizedBox(width: 40.w),
          Text(
            'SIGN UP',
            style: GoogleFonts.actor(
              color: white,
              fontSize: 20.sp,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    ),
  );
}
