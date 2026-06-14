import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/repositories_impl/auth_repository_impl.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_remote_source.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:music_game_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source =====
    Get.lazyPut<AuthRemoteSource>(() => AuthRemoteSource(), fenix: true);

    // Repository =====
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteSource>()),
      fenix: true,
    );

    // UseCases =====
    Get.lazyPut(() => RegisterUseCase(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()), fenix: true);

    // controllers =====
    Get.lazyPut<LoginController>(
      () => LoginController(loginUseCase: Get.find<LoginUseCase>(), ),
      fenix: true,
    );

    Get.lazyPut<RegistrationController>(
      () =>
          RegistrationController(registerUseCase: Get.find<RegisterUseCase>()),
      fenix: true,
    );
  }
}
