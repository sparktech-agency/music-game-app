import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  void setPassword() {
    String pass = passwordController.text;
    String confirmPass = confirmPasswordController.text;

    if (pass.length >= 8 && pass == confirmPass) {
      print("Password set successfully");

    } else {
      Get.snackbar(
        "Invalid Password",
        "Passwords must match and be at least 8 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}