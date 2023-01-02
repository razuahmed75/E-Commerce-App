import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shop_app/ui/signin/signin_page.dart';
import '../ui/bottom_nav_pages/bottomNav_controller.dart';
import '../utils/toast.dart';
import 'addEmptyFieldToDb.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  /// session manager
  static get userCredential => getUserCredential();
  static getUserCredential() {
    return auth.currentUser;
  }

  /// signOUt user
  static get signOutUser => signOutuser();

  static signOutuser() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();

    Get.to(() => SignInPage());
  }

  /// get user photo
  static String? profilePicture;
  static String? image = auth.currentUser!.photoURL;

  static getUserPhoto() {
    if (profilePicture != null) {
      return Image.network(
        profilePicture.toString(),
        height: 90,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, size: 40),
      );
    }
    if (image != null) {
      return Image.network(
        image.toString(),
        height: 90,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, size: 40),
      );
    }
  }

  /// get user name
  static getUserName() {
    if (auth.currentUser!.displayName != null) {
      return auth.currentUser!.displayName;
    }
    if (name != null) {
      return name;
    }
  }

  /// sing up
  // static String? username, photoURL;
  // static var users;
  static signUp({
    required emailController,
    required passController,
    required context,
  }) async {
    final auth = FirebaseAuth.instance;
    loader(context);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
      // auth.authStateChanges();

      // User? user = userCredential.user;
      // users = user;
      // user!.updateDisplayName(name);
      // user.updatePhotoURL(photoURL);
      emailController.clear();
      passController.clear();

      toast("Successfully created");

      addEmptyFieldToDb();
      Navigator.pop(context);

      Get.offAll(() => BottomNavPage());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        snackBar("The password provied is too weak", context);
      } else if (e.code == 'email-already-in-use') {
        snackBar("The account already exists for that email", context);
      }
    } catch (e) {
      Navigator.pop(context);
      snackBar("Email is invalid or already taken", context);
    }
  }

  /// sign in
  static signIn({
    required emailController,
    required passController,
    required BuildContext context,
  }) async {
    loader(context);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim());
      if (userCredential.user != null) {
        emailController.clear();
        passController.clear();
        Navigator.pop(context);
        Get.offAll(() => BottomNavPage());
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        snackBar('Please enter a valid email!', context);
      } else if (e.code == 'wrong-password') {
        snackBar('Please enter a valid password!', context);
      }
    } catch (e) {
      Navigator.pop(context);
      snackBar("Please enter valid email or password!", context);
    }
  }

  /// google sign in
  static Future signInGoogle(context) async {
    loader(context);
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    Navigator.pop(context);
    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = result.user;
    loader(context);
    if (user != null) {
      // addEmptyFieldToDb();
      Navigator.pop(context);
      Get.offAll(() => BottomNavPage());
    }
  }

  /// facebook sign in
  static String? id, name, email;
  static String? first_name, last_name;

  static void signInFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      await FacebookAuth.instance.getUserData().then((facebookUserData) async {
        id = facebookUserData['id'];
        email = facebookUserData['email'];
        name = facebookUserData['name'];
        first_name = facebookUserData['first_name'];
        last_name = facebookUserData['last_name'];
        profilePicture = facebookUserData['picture']['data']['url'];
      });

      final credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final result = FirebaseAuth.instance.signInWithCredential(credential);

      // addEmptyFieldToDb();
      Get.offAll(() => BottomNavPage());
    } catch (e) {
      toast(e.toString());
    }
  }

  /// reset password
  static Future resetPassword(emailController, context) async {
    try {
      return auth
          .sendPasswordResetEmail(email: emailController.text.trim())
          .then((value) {
        emailController.clear();
        FocusScope.of(context).unfocus();
        dialog(
          context: context,
          text: "Password reset link sent! Check your email",
          textColor: Colors.green,
        );
      });
    } on FirebaseAuthException catch (e) {
      dialog(
          context: context, text: e.message.toString(), textColor: Colors.red);
    }
  }

  /// alert dialog
  static Future<dynamic> dialog(
      {required context, required String text, required textColor}) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
              backgroundColor: Color(0xFF263b54),
              content: Text(
                text,
                style: GoogleFonts.poppins(color: textColor),
              ));
        });
  }

  /// loader
  static Future<dynamic> loader(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
  }

  /// snackBar
  static void snackBar(String msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.all(18).w,
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(color: Colors.red.withOpacity(0.7)),
        )));
  }

  ///
}
