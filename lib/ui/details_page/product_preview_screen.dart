import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:online_shop_app/constants/svg/svg.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({super.key});

  @override
  Widget build(BuildContext context) {
    var image = Get.arguments;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: SvgPicture.asset(kClose)),
          SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: Center(
          child: Image.network(
        image[0]['image'].toString(),
        height: 300.h,
      )),
    );
  }
}
