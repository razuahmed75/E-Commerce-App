import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 0.5.h,
            decoration: BoxDecoration(
              color: Colors.grey[400],
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          "OR",
          style: GoogleFonts.actor(
              color: Colors.blue[300], fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Container(
            height: 0.5.h,
            decoration: BoxDecoration(
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }
}
