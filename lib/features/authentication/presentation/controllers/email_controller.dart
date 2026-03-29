import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class EmailController extends GetxController {

  final TextEditingController emailController = TextEditingController();


  var isLoading = false.obs;

  void verifyEmail() {
    String email = emailController.text.trim();

    if (GetUtils.isEmail(email)) {

      print("Valid Email: $email");

     //Get.toNamed(AppRoutes.appLanding);

      Get.toNamed(AppRoutes.welcomeSplash);
    } else {

      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {

    emailController.dispose();
    super.onClose();
  }
}