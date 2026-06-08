import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class VerifyEmailController extends GetxController{


  final isLoading = false.obs;

  // Verify code function
  void verifyCode(String pin) {
    if (pin.length == 4) {
      // Future API call
      Get.snackbar(
        'Success',
        'Code verified successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Redirect to next page (example route)
      Get.offAllNamed(AppRoutes.setPassScreen);
    } else {
      Get.snackbar(
        'Error',
        'Please enter a 4-digit code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Resend code function
  void resendCode() {
    Get.snackbar(
      'Code Resent',
      'Please check your email',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

}