import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/profile/domain/usecases/change_password_usecase.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordController({
    required ChangePasswordUseCase changePasswordUseCase,
  }) : _changePasswordUseCase = changePasswordUseCase;

  // Text Controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  // Reactive States
  final isLoading = false.obs;
  final isCurrentPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;

  // Toggle methods
  void togglePasswordVisibility() =>
      isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      isNewPasswordVisible.value = !isNewPasswordVisible.value;

  // Change Password Method
  Future<void> changePassword() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        'Error',
        'New password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      return;
    }

    try {
      isLoading.value = true;

      await _changePasswordUseCase.call(
        oldPassword: currentPassword,
        newPassword: newPassword,
      );

      Get.back();

      Get.snackbar(
        'Success',
        'Password changed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
