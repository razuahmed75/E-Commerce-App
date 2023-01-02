import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';

buildBuyNowButton({required void Function()? onPressed}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.w)),
    color: Color(0xFF3D82AE),
    minWidth: 0.7.sw,
    height: 37.h,
    onPressed: onPressed,
    child: Text(
      'buy now'.toUpperCase(),
      style: GoogleFonts.actor(
        color: white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
