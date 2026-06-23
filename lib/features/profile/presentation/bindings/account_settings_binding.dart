import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/presentation/controllers/account_settings_controller.dart';

class AccountSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSettingsController>(
          () => AccountSettingsController(Get.find<AuthLocalSource>()),
    );
  }
}
