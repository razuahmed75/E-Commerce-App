import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:online_shop_app/constants/svg/svg.dart';
import '../../../constants/my_colors.dart';

class ProfileImagePreview extends StatelessWidget {
  const ProfileImagePreview({super.key});

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
          SizedBox(width: kDefaultPaddin / 2.w)
        ],
      ),
      body: Center(
        child: Image.network(
          image[0]['image'],
          height: 0.4.sh,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
