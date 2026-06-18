import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/forgot_password_usecase.dart'; // নতুন ইম্পোর্ট
import 'package:music_game_app/routes/app_routes.dart';

class EnterEmailController extends GetxController {
  final ForgotPasswordUseCase _forgotPasswordUseCase;


  EnterEmailController({required ForgotPasswordUseCase forgotPasswordUseCase})
      : _forgotPasswordUseCase = forgotPasswordUseCase;

  // Controller for the email input field
  final TextEditingController emailController = TextEditingController();

  // Reactive loading state
  final isLoading = false.obs;

  // Method to request verification code
  Future<void> getCode() async {
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

    try {
      isLoading.value = true;

      await _forgotPasswordUseCase.call(email);

      Get.snackbar(
        "Success",
        "Code sent successfully, please check your email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(AppRoutes.verifyEmailPage, arguments: email);

    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}