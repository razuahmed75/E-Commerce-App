import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String title;
  final void Function()? onPressed;
  final bool isLoading;

  const MyButton({
    super.key,
    required this.color,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 37.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              disabledBackgroundColor: Colors.blueGrey.withOpacity(0.4),
              disabledForegroundColor: Colors.white.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.w))),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Text(
                  title,
                  style: GoogleFonts.actor(
                    fontSize: 16.sp,
                    letterSpacing: 1.7.w,
                    fontWeight: FontWeight.w400,
                  ),
                )),
    );
  }
}
