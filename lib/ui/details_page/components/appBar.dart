import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';
import '../../../constants/svg/svg.dart';
import 'package:badges/badges.dart' as bage;
import '../../../utils/cart_length_checker.dart';
import '../../bottom_nav_pages/cart/cart.dart';
import '../../search_page/search_page.dart';

AppBar buildAppbar() {
  return AppBar(
    backgroundColor: Colors.grey.shade200,
    elevation: 0,
    title: Text(
      'Detail Product',
      style: GoogleFonts.robotoMono(
          fontWeight: FontWeight.bold, color: kTextColor),
    ),
    centerTitle: true,
    leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(
          kArrow_back,
        )),
    actions: <Widget>[
      IconButton(
          onPressed: () => Get.to(() => SearchPage()),
          icon: SvgPicture.asset(kSearch, color: kTextColor)),
      IconButton(
          onPressed: () {
            Get.to(() => CartScreen());
          },
          icon: bage.Badge(
              badgeContent: Text(Cartlength.checkLength == null
                  ? 'o'
                  : Cartlength.checkLength.toString()),
              child: SvgPicture.asset(kCart, color: kTextColor))),
      SizedBox(width: kDefaultPaddin.w),
    ],
  );
}
