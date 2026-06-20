import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class VerifyEmailController extends GetxController {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final SendOtpUseCase _sendOtpUseCase;

  late final String email;
  late final String flow;


  VerifyEmailController({
    required VerifyOtpUseCase verifyOtpUseCase,
    required SendOtpUseCase sendOtpUseCase,
  })  : _verifyOtpUseCase = verifyOtpUseCase,
        _sendOtpUseCase = sendOtpUseCase;


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] ?? '';
    flow = args['flow'] ?? 'registration';
  }

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
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.lightBlueAccent,
          colorText: Colors.black,
        );

        if (flow == 'registration') {
          Get.offAllNamed(AppRoutes.welcomeSplash);
        } else {
          Get.offAllNamed(AppRoutes.setPassScreen, arguments: email);
        }

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