import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';

class NameAndPrice extends StatelessWidget {
  final productName;
  final productPrice;

  const NameAndPrice({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPaddin * 2,
        left: kDefaultPaddin * 2,
        right: kDefaultPaddin * 2,
      ).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productName,
            style: GoogleFonts.robotoMono(
              color: kTextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                    vertical: kDefaultPaddin / 2,
                    horizontal: kDefaultPaddin * 1.5)
                .w,
            decoration: BoxDecoration(
                color: Color(0xFF3D82AE),
                borderRadius: BorderRadius.circular(12).w),
            child: Text(
              '\$' + productPrice.toString(),
              style: GoogleFonts.robotoMono(color: white, fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
