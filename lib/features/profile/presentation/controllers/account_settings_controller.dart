import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/domain/usecases/delete_user_usecase.dart';
import 'package:music_game_app/routes/app_routes.dart';

class AccountSettingsController extends GetxController {
  final AuthLocalSource _authLocalSource;
  final DeleteUserUseCase _deleteUserUseCase;

  AccountSettingsController(this._authLocalSource, this._deleteUserUseCase);

  final isLoading = false.obs;

  void logout() {
    _authLocalSource.clearAuthData();
    Get.offAllNamed(AppRoutes.loginPage);
  }

  Future<void> deleteAccount() async {
    final String userId = _authLocalSource.getUserId() ?? '';

    if (userId.isEmpty) {
      Get.snackbar('Error', 'User session not found');
      return;
    }

    try {
      isLoading.value = true;


      await _deleteUserUseCase.call(userId: userId);


      await _authLocalSource.clearAuthData();


      Get.offAllNamed(AppRoutes.loginPage);

      Get.snackbar(
        'Success',
        'Your account has been deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
