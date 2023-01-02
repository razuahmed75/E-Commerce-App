import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:online_shop_app/constants/svg/svg.dart';
import 'package:online_shop_app/firebase/Auth_services.dart';
import 'package:online_shop_app/utils/alert_dialog.dart';
import 'package:online_shop_app/logic/theme_manager.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/profile/components/accountInfo.dart';
import 'package:online_shop_app/utils/myButton.dart';
import 'package:provider/provider.dart';
import '../../../constants/my_colors.dart';
import 'components/profile_img.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    /// variables
    final _themeManager = Provider.of<ThemeManager>(context, listen: true);
    var isDarkBrightness = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
                  top: kDefaultPaddin,
                  left: kDefaultPaddin,
                  right: kDefaultPaddin)
              .r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(
                      kArrow_back,
                    )),

                /// user profile picture
                ProfileImage(),
                SizedBox(height: kDefaultPaddin.h),

                /// user info
                AccountInfo(),
                SizedBox(height: kDefaultPaddin.h),

                /// logut
                MyButton(
                    color: black,
                    title: 'LOGOUT',
                    isLoading: false,
                    onPressed: () {
                      appDialog(
                        context: context,
                        content: 'Logout of your account?',
                        rightButtonTxt: 'LOG OUT',
                        leftPressed: () => Get.back(),
                        rightPressed: () => AuthService.signOutUser,
                      );
                    }),
                SizedBox(height: kDefaultPaddin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var User = FirebaseAuth.instance.currentUser;
}
