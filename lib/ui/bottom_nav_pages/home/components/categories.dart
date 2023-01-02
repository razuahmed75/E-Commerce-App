import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Categories',
            style: GoogleFonts.robotoMono(
                fontSize: 13.sp, fontWeight: FontWeight.w700),
          ),
          Text(
            'SHOP MORE >',
            style: GoogleFonts.actor(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.blue.shade700),
          ),
        ],
      ),
    );
  }
}
