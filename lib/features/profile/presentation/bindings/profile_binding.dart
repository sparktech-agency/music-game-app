import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:music_game_app/features/profile/data/sources/profile_remote_source.dart';
import 'package:music_game_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:music_game_app/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:music_game_app/features/profile/domain/usecases/delete_user_usecase.dart';
import 'package:music_game_app/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:music_game_app/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:music_game_app/features/profile/presentation/controllers/account_settings_controller.dart';
import 'package:music_game_app/features/profile/presentation/controllers/change_password_controller.dart';
import 'package:music_game_app/features/profile/presentation/controllers/profile_screen_controller.dart';
import 'package:music_game_app/features/profile/presentation/controllers/spotify_music_controller.dart';
import 'package:music_game_app/features/profile/presentation/controllers/update_name_controller.dart';
import 'package:music_game_app/features/profile/presentation/controllers/update_nickname_controller.dart';
import 'package:music_game_app/features/profile/presentation/controllers/update_profilepic_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    //===== Data Source =====
    Get.lazyPut<AuthLocalSource>(() => AuthLocalSourceImpl(), fenix: true);

    Get.lazyPut<ProfileRemoteSource>(
      () => ProfileRemoteSource(authLocalSource: Get.find<AuthLocalSource>()),
      fenix: true,
    );

    //===== Repository =====
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(Get.find<ProfileRemoteSource>()),
      fenix: true,
    );

    //===== UseCases =====

    Get.lazyPut<UpdateUserUseCase>(
      () => UpdateUserUseCase(Get.find<ProfileRepository>()),
      fenix: true,
    );

    Get.lazyPut<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(Get.find<ProfileRepository>()),
      fenix: true,
    );

    Get.lazyPut<DeleteUserUseCase>(
      () => DeleteUserUseCase(Get.find<ProfileRepository>()),
    );

    Get.lazyPut<GetUserUseCase>(
          () => GetUserUseCase(Get.find<ProfileRepository>()),
    );

    //======= Controllers ===============
    Get.lazyPut<ProfileScreenController>(
      () =>
          ProfileScreenController(authLocalSource: Get.find<AuthLocalSource>(), getUserUseCase: Get.find<GetUserUseCase>()),
    );
    Get.lazyPut<UpdateNameController>(
      () => UpdateNameController(
        updateUserUseCase: Get.find<UpdateUserUseCase>(),
        authLocalSource: Get.find<AuthLocalSource>(),
      ),
    );

    Get.lazyPut<UpdateNicknameController>(
      () => UpdateNicknameController(
        updateUserUseCase: Get.find<UpdateUserUseCase>(),
        authLocalSource: Get.find<AuthLocalSource>(),
      ),
    );

    Get.lazyPut<UpdateProfilePicController>(
      () => UpdateProfilePicController(
        updateUserUseCase: Get.find<UpdateUserUseCase>(),
        authLocalSource: Get.find<AuthLocalSource>(),
      ),
    );

    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(
        changePasswordUseCase: Get.find<ChangePasswordUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<AccountSettingsController>(
      () => AccountSettingsController(
        Get.find<AuthLocalSource>(),
        Get.find<DeleteUserUseCase>(),
      ),
    );

    Get.lazyPut<SpotifyMusicController>(
      () => SpotifyMusicController(),
      fenix: true,
    );
  }
}
