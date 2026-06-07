import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class PhoneController extends GetxController {
  final phoneController = TextEditingController();
  var selectedCountryCode = "+1".obs;

  void verifyPhone() {
    String phoneNumber = selectedCountryCode.value + phoneController.text;
    if (phoneController.text.isNotEmpty) {
      Get.toNamed(AppRoutes.verifyPhonePage);

    } else {
      Get.snackbar(
        "Error",
        "Please enter a valid phone number",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}