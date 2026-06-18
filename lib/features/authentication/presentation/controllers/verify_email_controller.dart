import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class VerifyEmailController extends GetxController {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final SendOtpUseCase _sendOtpUseCase;


  VerifyEmailController({
    required VerifyOtpUseCase verifyOtpUseCase,
    required SendOtpUseCase sendOtpUseCase,
  })  : _verifyOtpUseCase = verifyOtpUseCase,
        _sendOtpUseCase = sendOtpUseCase;


  final String email = Get.arguments ?? '';

  final isLoading = false.obs;

  // Verify code function
  Future<void> verifyCode(String pin) async {
    if (pin.length == 6) {
      try {
        isLoading.value = true;


        await _verifyOtpUseCase.call(email, pin);

        Get.snackbar(
          'Success',
          'Code verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Redirect to next page
        Get.offAllNamed(AppRoutes.welcomeSplash);

      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString().replaceAll('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
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
  Future<void> resendCode() async {
    try {
      isLoading.value = true;


      await _sendOtpUseCase.call(email);

      Get.snackbar(
        'Code Resent',
        'Please check your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}