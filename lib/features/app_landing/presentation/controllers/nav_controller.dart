import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/profile/presentation/profile_screen.dart';

class NavController extends GetxController {

  var selectedIndex = 0.obs;


  final List<Widget> screens = [
    const Center(child: Text('Let\'s Sing Main Screen', style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text('Guide Screen Demo', style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text('Song Packs List', style: TextStyle(color: Colors.white, fontSize: 20))),
    ProfileScreen()
  ];


  void changeTab(int index) {
    selectedIndex.value = index;
  }
}