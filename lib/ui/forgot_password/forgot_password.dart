import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:online_shop_app/firebase/Auth_services.dart';
import '../../constants/svg/svg.dart';
import '../../utils/myButton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(28.0.w),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Enter your email, we will send you a password reset link.',
                        textAlign: TextAlign.center,
                        style: _textTheme.titleLarge?.copyWith(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 45),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 2)
                                  .r,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10).w,
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: GoogleFonts.poppins(),
                              border: InputBorder.none,
                            ),
                          )),
                      SizedBox(height: 40),
                      ValueListenableBuilder(
                          valueListenable: emailController,
                          builder: (context, value, child) {
                            return MyButton(
                              onPressed: value.text.isNotEmpty &&
                                      value.text.length >= 5
                                  ? () {
                                      AuthService.resetPassword(
                                          emailController, context);
                                    }
                                  : null,
                              title: 'Reset Password',
                              color: Color(0xFF263b54),
                            );
                          }),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Reset Password', style: GoogleFonts.poppins()),
      centerTitle: true,
      backgroundColor: Color(0xFF263b54),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(kArrow_back, color: white),
      ),
    );
  }
}
