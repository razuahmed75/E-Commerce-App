import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/firebase/Auth_services.dart';
import 'package:online_shop_app/ui/forgot_password/forgot_password.dart';
import 'package:online_shop_app/ui/signin/components/navigate_to_signup.dart';
import 'package:online_shop_app/utils/myButton.dart';
import '../../constants/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/close_app_dialog.dart';
import '../../utils/myText_field.dart';
import 'components/header.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
        onWillPop: () {
          return PopApp.onWillPop();
        },
        child: Scaffold(
          backgroundColor: kColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// header text
                header(),
                Expanded(
                  child: Container(
                    width: double.infinity,
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
                            /// welcome text
                            welcome(),
                            SizedBox(height: 4.h),

                            /// enter your email address to sign in
                            buildText(),
                            SizedBox(height: 19.h),

                            /// form
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    /// email
                                    buildEmail(),
                                    SizedBox(height: 10.h),

                                    /// password
                                    buildPassword()
                                  ],
                                )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () => Get.to(() => ForgotPassword()),
                                child: Text('Forgot Password?',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            SizedBox(height: 29.h),
                            MyButton(
                                color: kColor,
                                title: 'SIGNIN',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthService.signIn(
                                        emailController: _emailController,
                                        passController: _passController,
                                        context: context);

                                    FocusScope.of(context).unfocus();
                                  }
                                }),
                            SizedBox(height: 16.h),

                            /// alreday have an account? / sign up
                            navigateToSignUp(),
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

  /// build methods
  MyTextField buildPassword() {
    return MyTextField(
      controller: _passController,
      focusNode: _passFocusNode,
      label: 'Password',
      obscureText: _obscureTxt,
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
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Field must not be empty!';
        } else if (value.length < 8) {
          return 'Password should be in 8 characters';
        }
        return null;
      },
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
      "Enter your Email Address to sign in.\nEnjoy your shop :)",
      style: GoogleFonts.actor(
        fontSize: 13.sp,
        letterSpacing: 0.7.w,
        color: grey,
      ),
    );
  }

  Text welcome() {
    return Text(
      'Welcome',
      style: GoogleFonts.actor(
        fontSize: 24.sp,
        color: kColor,
        letterSpacing: 0.7.w,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
