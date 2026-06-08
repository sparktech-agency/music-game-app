import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class RegistrationController extends GetxController {
  // UseCase Injection
  final RegisterUseCase _registerUseCase;
  RegistrationController({required RegisterUseCase registerUseCase}) : _registerUseCase = registerUseCase;

  // Text Editing Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Reactive States (Private setters are standard for preventing external state mutation)
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isPasswordVisible = false.obs;
  bool get isPasswordVisible => _isPasswordVisible.value;

  final _isConfirmPasswordVisible = false.obs;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;

  // Visibility Toggles
  void togglePasswordVisibility() => _isPasswordVisible.value = !_isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;

  // Main Registration Logic
  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Input Validation Guard Clauses
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

      // Actual Clean UseCase Trigger
      final result = await _registerUseCase.call(email, password);

      if (result.success) {
        _showSuccessSnackbar(result.message.isNotEmpty ? result.message : 'Registration successful!');

        // Target Next Step Route Execution
        Get.toNamed(AppRoutes.verifyEmailPage);
      } else {
        _showErrorSnackbar(result.message);
      }
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }

  // Common Snackbar Helper functions
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}