import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class EnterEmailController extends GetxController {
  // Controller for the email input field
  final TextEditingController emailController = TextEditingController();

  // Reactive loading state
  final isLoading = false.obs;

  // Method to request verification code
  void getCode() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Email field cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call or OTP request
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.toNamed(AppRoutes.verifyEmailPage, arguments: email);
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
