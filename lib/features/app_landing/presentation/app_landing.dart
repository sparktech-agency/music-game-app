import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/controllers/nav_controller.dart';
import 'package:music_game_app/features/app_landing/presentation/widgets/bottom_nav.dart';
import 'package:music_game_app/features/profile/presentation/controllers/profile_screen_controller.dart';

class AppLanding extends StatelessWidget {
  AppLanding({super.key});

  final NavController controller =
  Get.find<NavController>();

  final ProfileScreenController profileController =
  Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141432),

      body: Stack(
        children: [

          PageView(
            controller: controller.pageController,

            onPageChanged:
            controller.onPageChanged,

            children:
            controller.screens,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: const BottomNav(),
          ),
        ],
      ),
    );
  }
}