import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/reset_pass_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  final ResetPassUseCase _resetPassUseCase;

  ResetPasswordController({required ResetPassUseCase resetPassUseCase})
      : _resetPassUseCase = resetPassUseCase;


  final String email = Get.arguments ?? '';

  // Text Controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Reactive States
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Toggle methods
  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  // Main Reset Password Method
  Future<void> setPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();


    if (password.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackbar('All fields are required');
      return;
    }


    if (password != confirmPassword) {
      _showErrorSnackbar('Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;


      await _resetPassUseCase.call(
        email: email,
        newPass: password,
        confirmNewPass: confirmPassword,
      );

      _showSuccessSnackbar('Password reset successfully!');


      Get.offAllNamed(AppRoutes.loginPage);

    } catch (e) {
      _showErrorSnackbar(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15));
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar('Success', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
        margin: const EdgeInsets.all(15));
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}