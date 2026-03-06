import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_sing_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_screen.dart';
import 'package:music_game_app/features/song_packs/presentation/song_pack_screen.dart';

class NavController extends GetxController {

  var selectedIndex = 0.obs;


  final List<Widget> screens = [
    LetsSingScreen(),
    const Center(child: Text('Guide Screen Demo', style: TextStyle(color: Colors.white, fontSize: 20))),
    SongPackScreen(),
    ProfileScreen()
  ];


  void changeTab(int index) {
    selectedIndex.value = index;
  }
}