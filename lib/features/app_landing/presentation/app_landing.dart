import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/controllers/nav_controller.dart';
import 'package:music_game_app/features/app_landing/presentation/widgets/bottom_nav.dart';

class AppLanding extends StatelessWidget {

  const AppLanding({super.key});

  @override
  Widget build(BuildContext context) {

    final NavController controller = Get.find<NavController>();

    return Scaffold(
      backgroundColor: const Color(0xFF141432),
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: controller.screens,
          ),


          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }
}