import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/domain/usecases/update_user_usecase.dart';

class UpdateProfilePicController extends GetxController {
  final UpdateUserUseCase _updateUserUseCase;
  final AuthLocalSource _authLocalSource;
  final ImagePicker _picker = ImagePicker();

  UpdateProfilePicController({
    required UpdateUserUseCase updateUserUseCase,
    required AuthLocalSource authLocalSource,
  }) : _updateUserUseCase = updateUserUseCase,
       _authLocalSource = authLocalSource;

  final selectedImage = Rx<File?>(null);
  final isLoading = false.obs;
  final currentImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentImage();
  }

  void _loadCurrentImage() {
    currentImageUrl.value = _authLocalSource.getProfilePhoto() ?? '';
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateProfilePicture() async {
    if (selectedImage.value == null) {
      Get.snackbar(
        'Warning',
        'Please select an image first!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
      );
      return;
    }

    try {
      isLoading.value = true;
      final String userId = _authLocalSource.getUserId() ?? '';

      await _updateUserUseCase.call(
        userId: userId,
        firstName: _authLocalSource.getFirstName() ?? '',
        lastName: _authLocalSource.getLastName() ?? '',
        nickName: _authLocalSource.getNickName() ?? '',
        profilePath: selectedImage.value!.path,
      );

      Get.back();

      Get.snackbar(
        'Success',
        'Profile picture updated successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
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
}
