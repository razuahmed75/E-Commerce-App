import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop_app/logic/profile_manager.dart';
import 'package:online_shop_app/logic/theme_manager.dart';
import 'package:online_shop_app/theme.dart';
import 'package:provider/provider.dart';
import 'authPage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProfileManager(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeManager(),
      ),
    ],
    child: const MyApp(),
  ));
}

/// myApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final _themeManager = Provider.of<ThemeManager>(context, listen: true);
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-shop',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: _themeManager.themeMode,
              home: AuthPage(),
            ));
  }
}
