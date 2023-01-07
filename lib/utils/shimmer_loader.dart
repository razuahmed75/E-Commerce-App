import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/my_colors.dart';

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          loader(),
          loader(),
          loader(),
          loader(),
        ],
      ),
    );
  }

  Padding loader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20).r,
      child: Container(
        width: ScreenUtil().screenWidth,
        height: 80.h,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4.w,
              offset: Offset(0, 4), // Shadow position
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4.w,
              offset: Offset(0, -4), // Shadow position
            ),
          ],
        ),
      ),
    );
  }
}
