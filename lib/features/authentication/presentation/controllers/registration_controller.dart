import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class RegistrationController extends GetxController {
  final RegisterUseCase _registerUseCase;
  RegistrationController({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase;

  // Reactive States only — no TextEditingControllers here
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isPasswordVisible = false.obs;
  bool get isPasswordVisible => _isPasswordVisible.value;

  final _isConfirmPasswordVisible = false.obs;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;

  void togglePasswordVisibility() =>
      _isPasswordVisible.value = !_isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() =>
      _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;

  // Receives values from the UI, doesn't own controllers
  Future<void> register(
      String email, String password, String confirmPassword) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackbar('All fields are required');
      return;
    }
    if (!GetUtils.isEmail(email)) {
      _showErrorSnackbar('Invalid email format');
      return;
    }
    if (password.length < 6) {
      _showErrorSnackbar('Password must be at least 6 characters');
      return;
    }
    if (password != confirmPassword) {
      _showErrorSnackbar('Passwords do not match');
      return;
    }

    try {
      _isLoading.value = true;
      await _registerUseCase.call(email, password);
      _showSuccessSnackbar('Registration successful!');
      Get.offAllNamed(AppRoutes.loginPage);
    } catch (e) {
      _showErrorSnackbar(e.toString().replaceAll('Exception: ', ''));
    } finally {
      _isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15));
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar('Success', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15));
  }

// No onClose needed — nothing to dispose
}