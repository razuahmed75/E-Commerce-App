import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_shop_app/firebase/Auth_services.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/cart/cart.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/favorite/favourite.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/home/home.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/profile/profile.dart';
import '../../logic/close_app_dialog.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  /// variables
  int _zeroIndex = 0;
  List pages = [HomeScreen(), FavoriteScreen(), CartScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: black));
    return WillPopScope(
      onWillPop: () => PopApp.onWillPop(),
      child: Scaffold(
        backgroundColor: white,
        bottomNavigationBar: Container(
          color: white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20).r,
            child: GNav(
              onTabChange: (index) => setState(() => _zeroIndex = index),
              gap: 8,
              color: black,
              activeColor: black,
              backgroundColor: white,
              tabBackgroundColor: Colors.blue.shade50,
              padding: EdgeInsets.all(16).w,
              tabs: [
                GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                    textStyle:
                        GoogleFonts.robotoMono(fontWeight: FontWeight.bold)),
                GButton(
                  icon: Icons.favorite_outline,
                  text: 'Favorite',
                  textStyle:
                      GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                ),
                GButton(
                    icon: Icons.shopping_cart_outlined,
                    text: 'Cart',
                    textStyle:
                        GoogleFonts.robotoMono(fontWeight: FontWeight.bold)),
                GButton(
                    icon: Icons.person_outline,
                    text: 'Profile',
                    textStyle:
                        GoogleFonts.robotoMono(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        body: pages[_zeroIndex],
      ),
    );
  }
}
