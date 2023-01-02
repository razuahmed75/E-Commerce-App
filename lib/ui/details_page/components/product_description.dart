import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/my_colors.dart';

Padding productDescription(description) {
  return Padding(
    padding: const EdgeInsets.only(
      top: kDefaultPaddin * 2,
      left: kDefaultPaddin,
      right: kDefaultPaddin,
    ).r,
    child: Text(
      description,
      textAlign: TextAlign.justify,
      style: GoogleFonts.robotoMono(
        color: kTextColor,
      ),
    ),
  );
}
