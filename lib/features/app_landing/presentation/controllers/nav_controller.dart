import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {

  var selectedIndex = 0.obs;


  final List<Widget> screens = [
    const Center(child: Text('Let\'s Sing Main Screen', style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text('Guide Screen Demo', style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text('Song Packs List', style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text('User Profile Screen', style: TextStyle(color: Colors.white, fontSize: 20))),
  ];


  void changeTab(int index) {
    selectedIndex.value = index;
  }
}