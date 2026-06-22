import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/domain/usecases/update_user_usecase.dart';

class ProfileScreenController extends GetxController {
  final UpdateUserUseCase _updateUserUseCase;
  final AuthLocalSource _authLocalSource;

  ProfileScreenController({
    required UpdateUserUseCase updateUserUseCase,
    required AuthLocalSource authLocalSource,
  }) : _updateUserUseCase = updateUserUseCase,
       _authLocalSource = authLocalSource;

  var userName = "".obs;
  var userEmail = "".obs;
  var nickName = "".obs;
  var profilePhoto = "".obs;
  var joinDate = "".obs;
  var teamJoined = 0.obs;
  var totalWins = 0.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialProfileData();
  }

  void _loadInitialProfileData() {
    userEmail.value = _authLocalSource.getEmail() ?? "Unknown";
    nickName.value = _authLocalSource.getNickName() ?? "user";
    profilePhoto.value = _authLocalSource.getProfilePhoto() ?? "";
    joinDate.value = _authLocalSource.getJoinDate() ?? "N/A";
    teamJoined.value = 0;
    totalWins.value = 0;
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? nickName,
    String? profilePath,
  }) async {
    try {
      isLoading.value = true;

      final String currentFirstName = _authLocalSource.getFirstName() ?? '';
      final String currentLastName = _authLocalSource.getLastName() ?? '';
      final String currentNickName = _authLocalSource.getNickName() ?? '';
      final String userIdVal = _authLocalSource.getUserId() ?? '';

      final updatedUser = await _updateUserUseCase.call(
        userId: userIdVal,
        firstName: firstName ?? currentFirstName,
        lastName: lastName ?? currentLastName,
        nickName: nickName ?? currentNickName,
        profilePath: profilePath,
      );

      userName.value = "${updatedUser.firstName} ${updatedUser.lastName}";
      this.nickName.value = updatedUser.nickName;

      await _authLocalSource.updateProfileLocalData(
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        nickName: updatedUser.nickName,
      );

      Get.back();

      Get.snackbar(
        'Success',
        'Profile updated successfully!',
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
}
