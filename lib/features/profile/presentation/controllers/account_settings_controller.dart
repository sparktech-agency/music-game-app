import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/routes/app_routes.dart';

class AccountSettingsController extends GetxController {
  final AuthLocalSource _authLocalSource;
  AccountSettingsController(this._authLocalSource);

  void logout() {
    _authLocalSource.clearAuthData();
    Get.offAllNamed(AppRoutes.loginPage);
  }

  void deleteAccount() {
    _authLocalSource.clearAuthData();
    Get.offAllNamed(AppRoutes.loginPage);
  }
}
