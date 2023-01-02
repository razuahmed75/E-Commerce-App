import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ui/bottom_nav_pages/bottomNav_controller.dart';
import 'ui/signup/registration_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            /// user is logged in
            if (snapshot.hasData) {
              return BottomNavPage();
            }

            /// user is not logged in
            else {
              return SignUpPage();
            }
          }),
    );
  }
}
