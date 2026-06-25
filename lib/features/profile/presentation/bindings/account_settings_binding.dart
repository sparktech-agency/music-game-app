import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:music_game_app/features/profile/data/sources/profile_remote_source.dart';
import 'package:music_game_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:music_game_app/features/profile/domain/usecases/delete_user_usecase.dart';
import 'package:music_game_app/features/profile/presentation/controllers/account_settings_controller.dart';

class AccountSettingsBinding extends Bindings {
  @override
  void dependencies() {
    //============== 1. Data Source ==============
    Get.lazyPut<ProfileRemoteSource>(() => ProfileRemoteSource());

    //============== 2. Repositories ==============
    Get.lazyPut<ProfileRepository>(
          () => ProfileRepositoryImpl(Get.find<ProfileRemoteSource>()),
    );

    //============== 3. UseCases ==============
    Get.lazyPut<DeleteUserUseCase>(
          () => DeleteUserUseCase(Get.find<ProfileRepository>()),
    );

    //============== 4. Controllers ==============

    Get.lazyPut<AccountSettingsController>(
          () => AccountSettingsController(
        Get.find<AuthLocalSource>(),
        Get.find<DeleteUserUseCase>(),
      ),
    );
  }
}