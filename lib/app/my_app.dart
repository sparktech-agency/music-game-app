import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/constants/app_constants.dart';
import 'package:music_game_app/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
      ),

      initialRoute: AppRoutes.firstScreen,
      getPages: routes,
    );
  }
}
