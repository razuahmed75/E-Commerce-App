import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileLoader extends StatelessWidget {
  const ProfileLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 145.w,
          height: 145.w,
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
