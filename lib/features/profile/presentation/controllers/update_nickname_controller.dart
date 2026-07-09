import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:music_game_app/features/profile/presentation/controllers/profile_screen_controller.dart';

class UpdateNicknameController extends GetxController {
  final UpdateUserUseCase _updateUserUseCase;
  final AuthLocalSource _authLocalSource;

  UpdateNicknameController({
    required UpdateUserUseCase updateUserUseCase,
    required AuthLocalSource authLocalSource,
  })  : _updateUserUseCase = updateUserUseCase,
        _authLocalSource = authLocalSource;

  final nicknameController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    nicknameController.text = _authLocalSource.getNickName() ?? '';
  }

  Future<void> updateNickname() async {
    final nickName = nicknameController.text.trim();

    if (nickName.isEmpty) {
      Get.snackbar('Error', 'Nickname is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.lightBlueAccent,
          colorText: Colors.black);
      return;
    }

    try {
      isLoading.value = true;
      final String userId = _authLocalSource.getUserId() ?? '';

      await _updateUserUseCase.call(
        userId: userId,
        firstName: _authLocalSource.getFirstName() ?? '',
        lastName: _authLocalSource.getLastName() ?? '',
        nickName: nickName,
      );

      if (Get.isRegistered<ProfileScreenController>()) {
        Get.find<ProfileScreenController>().fetchUserProfile();
      }

      Get.back();

      Get.snackbar('Success', 'Nickname updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

    } catch (e) {
      debugPrint('UpdateNickname error: $e');
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nicknameController.dispose();
    super.onClose();
  }
}
