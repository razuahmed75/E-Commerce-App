import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/firebase/Auth_services.dart';
import 'package:online_shop_app/ui/signup/components/circle_tile.dart';
import 'package:online_shop_app/ui/signup/components/footer.dart';
import 'package:online_shop_app/utils/myButton.dart';
import '../../constants/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/close_app_dialog.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/myText_field.dart';
import 'components/goToSingInPage.dart';
import 'components/header.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _emailController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: black));
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: WillPopScope(
        onWillPop: () => PopApp.onWillPop(),
        child: Scaffold(
          backgroundColor: kColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// header section
                header(),
                Expanded(
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45).w,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 23,
                        right: 23,
                        top: 29,
                      ).r,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// create account text
                            createAccount(),
                            SizedBox(height: 4.h),

                            /// enter your email, password for sign up
                            buildText(),
                            SizedBox(height: 19.h),

                            /// form
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    buildEmail(),
                                    SizedBox(height: 10.h),
                                    buildPassword()
                                  ],
                                )),
                            SizedBox(height: 29.h),

                            /// signUp button
                            MyButton(
                                color: kColor,
                                title: 'SIGNUP',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthService.signUp(
                                      emailController: _emailController,
                                      passController: _passController,
                                      context: context,
                                    );
                                    FocusScope.of(context).unfocus();
                                  }
                                }),
                            SizedBox(height: 16.h),

                            /// already have an account? or singIn
                            goToSingInPage(),
                            SizedBox(height: 30.h),

                            /// or sing up with divider
                            Footer(),
                            SizedBox(height: 20.h),

                            /// social sign in
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleTile(
                                    onTap: () => AuthService.signInFacebook(),
                                    imagePath: 'assets/images/fb.png'),
                                SizedBox(width: 20.w),
                                CircleTile(
                                    onTap: () =>
                                        AuthService.signInGoogle(context),
                                    imagePath: 'assets/images/google.png'),
                                SizedBox(width: 20.w),
                                CircleTile(
                                    onTap: () {},
                                    imagePath: 'assets/images/twitter.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// variables

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscureTxt = true;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();

  /// methods

  MyTextField buildPassword() {
    return MyTextField(
      controller: _passController,
      focusNode: _passFocusNode,
      obscureText: _obscureTxt,
      label: 'Password',
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Field must not be empty!';
        } else if (value.length < 8) {
          return 'Password should be in 8 characters';
        }
        return null;
      },
      prefixIcon: Icons.lock,
      sufixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureTxt = !_obscureTxt;
            });
          },
          icon: Icon(
            _obscureTxt ? Icons.visibility_off : Icons.visibility,
            color: _passFocusNode.hasFocus || _passController.text.isNotEmpty
                ? kColor
                : Colors.grey[500],
          )),
    );
  }

  MyTextField buildEmail() {
    return MyTextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      label: 'Email',
      prefixIcon: Icons.email,
      sufixIcon: _emailController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
              onPressed: () => _emailController.clear(),
              icon: Icon(
                Icons.close,
                color: _emailController.text.isNotEmpty
                    ? kColor
                    : Colors.grey[700],
              )),
    );
  }

  Text buildText() {
    return Text(
      "Enter your Email and Password for sign up.",
      style: GoogleFonts.actor(
        fontSize: 13.sp,
        letterSpacing: 0.7.w,
        color: grey,
      ),
    );
  }

  Text createAccount() {
    return Text(
      'Create Account',
      style: GoogleFonts.raleway(
        fontSize: 24.sp,
        color: kColor,
        letterSpacing: 0.7.w,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
