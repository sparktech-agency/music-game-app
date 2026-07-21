import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/constants/app_constants.dart';
import 'package:music_game_app/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppConstants.backgroundColor,
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // we can try Transition.fadeIn to reduce frame drop
      defaultTransition: Transition.rightToLeft,
      theme: appTheme,
      initialRoute: AppRoutes.firstScreen,
      //initialRoute: AppRoutes.connectMusicScreen,
      getPages: routes,
    );
  }
}