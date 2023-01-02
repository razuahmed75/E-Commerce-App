import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';
import '../../signup/components/arrow_back.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 80.h,
      child: Row(
        children: [
          SizedBox(width: 40.w),
          ArrowBack(
            onTap: () => Get.back(),
          ),
          SizedBox(width: 40.w),
          Text(
            'User Form',
            style: GoogleFonts.actor(
              color: white,
              fontSize: 20.sp,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
