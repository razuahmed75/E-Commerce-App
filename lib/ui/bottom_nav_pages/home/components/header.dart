import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:online_shop_app/constants/svg/svg.dart';
import 'package:online_shop_app/firebase/Auth_services.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/profile/profile.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 35,
      ).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /// hi
              Text(
                'HI',
                style: GoogleFonts.raleway(
                    fontSize: 32.sp, fontWeight: FontWeight.w500),
              ),

              /// fetch user name
              Text(
                AuthService.getUserName() == null
                    ? ''
                    : ', ' + AuthService.getUserName().toString().toUpperCase(),
                style: GoogleFonts.raleway(
                    fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),

          /// profile photo
          InkWell(
            onTap: () => Get.to(() => ProfileScreen()),
            child: profilePHoto(),
          ),
        ],
      ),
    );
  }

  Material profilePHoto() {
    return Material(
      elevation: 16,
      shadowColor: Colors.grey.shade800,
      color: Colors.transparent,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.w),
          borderSide: BorderSide(
            color: black.withOpacity(0.5),
          )),
      child: Container(
        height: 42.h,
        width: 42.h,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: AuthService.getUserPhoto() == null
              ? SvgPicture.asset(kPerson, height: 28.h)
              : AuthService.getUserPhoto(),
        ),
      ),
    );
  }
}
