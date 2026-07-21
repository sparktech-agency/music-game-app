import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class ConnectMusicController extends GetxController {
  
  var selectedApp = ''.obs;
  
  
  var isLoading = false.obs;

  void selectApp(String app) {
    if (!isLoading.value) {
      selectedApp.value = app;
    }
  }

  Future<void> connectMusicApp() async {
    if (selectedApp.value.isEmpty) {
      Get.snackbar(
        'Selection Required',
        'Please select a music app to connect.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10162D),
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    isLoading.value = true;

   
    await Future.delayed(const Duration(seconds: 3));

    isLoading.value = false;

   
    Get.toNamed(AppRoutes.appLanding); 
  }
}