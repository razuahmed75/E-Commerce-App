import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';
import '../../signin/signin_page.dart';

Padding goToSingInPage() {
  return Padding(
    padding: const EdgeInsets.all(10.0).w,
    child: Row(
      children: [
        Text(
          'Already have an account?',
          style: GoogleFonts.actor(
            fontSize: 11.sp,
            letterSpacing: 1.2.w,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
            onTap: () => Get.to(() => SignInPage()),
            child: Text(
              'SignIn',
              style: GoogleFonts.actor(
                fontSize: 11.sp,
                letterSpacing: 1.2.w,
                fontWeight: FontWeight.bold,
                color: kColor,
              ),
            )),
      ],
    ),
  );
}
