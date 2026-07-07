import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:music_game_app/features/profile/presentation/controllers/profile_screen_controller.dart';

class UpdateNameController extends GetxController {
  final UpdateUserUseCase _updateUserUseCase;
  final AuthLocalSource _authLocalSource;

  UpdateNameController({
    required UpdateUserUseCase updateUserUseCase,
    required AuthLocalSource authLocalSource,
  }) : _updateUserUseCase = updateUserUseCase,
       _authLocalSource = authLocalSource;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    firstNameController.text = _authLocalSource.getFirstName() ?? '';
    lastNameController.text = _authLocalSource.getLastName() ?? '';
  }

  Future<void> updateName() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      Get.snackbar(
        'Error',
        'First Name and Last Name are required',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.black,
      );
      return;
    }

    try {
      isLoading.value = true;
      final String userId = _authLocalSource.getUserId() ?? '';

      await _updateUserUseCase.call(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        nickName: _authLocalSource.getNickName() ?? '',
        profilePath: _authLocalSource.getProfilePhoto(),
      );

      if (Get.isRegistered<ProfileScreenController>()) {
        Get.find<ProfileScreenController>().fetchUserProfile();
      }

      Get.back();

    } catch (e) {
      Get.snackbar(
        'Error',
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
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
