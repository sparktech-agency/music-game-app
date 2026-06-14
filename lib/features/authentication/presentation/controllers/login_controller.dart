import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  LoginController({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase;

  // Reactive States only — no TextEditingControllers here
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Receives values from the UI, doesn't own controllers
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email & Password required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Invalid email format',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      await _loginUseCase.call(email, password);
      Get.snackbar('Success', 'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      Get.offAllNamed(AppRoutes.appLanding);
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}