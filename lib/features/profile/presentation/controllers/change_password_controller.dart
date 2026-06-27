import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController{

  // Text Controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  // Reactive States
  final isLoading = false.obs;
  final isCurrentPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;

  // Toggle methods
  void togglePasswordVisibility() => isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => isNewPasswordVisible.value = !isNewPasswordVisible.value;



  // Change Password

Future<void> changePassword() async{







  Get.back();




}













}