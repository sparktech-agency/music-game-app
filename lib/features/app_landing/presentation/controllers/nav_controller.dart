import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_sing_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_screen.dart';
import 'package:music_game_app/features/song_packs/presentation/song_pack_screen.dart';

class NavController extends GetxController {

  final selectedIndex = 0.obs;

  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController(
      initialPage: selectedIndex.value,
    );
  }

  final List<Widget> screens = const [
    LetsSingScreen(),
    SongPackScreen(),
    ProfileScreen(),
  ];

  void changeTab(int index) {
    if (selectedIndex.value == index) return;

    selectedIndex.value = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}