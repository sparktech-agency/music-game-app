import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/repositories_impl/auth_repository_impl.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_remote_source.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:music_game_app/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:music_game_app/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/enter_email_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/verify_email_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    //===== Data Source =====
    Get.lazyPut<AuthRemoteSource>(() => AuthRemoteSource(), fenix: true);
    Get.lazyPut<AuthLocalSource>(() => AuthLocalSourceImpl(), fenix: true);

    //===== Repository =====
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteSource>(), Get.find<AuthLocalSource>(),),
      fenix: true,
    );

    //===== UseCases =====
    Get.lazyPut(() => RegisterUseCase(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut(() => SendOtpUseCase(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut(() => VerifyOtpUseCase(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut(() => ForgotPasswordUseCase(Get.find<AuthRepository>()), fenix: true);





    //===== Controllers =====
    Get.lazyPut<LoginController>(
      () => LoginController(loginUseCase: Get.find<LoginUseCase>()),
      fenix: true,
    );

    Get.lazyPut<RegistrationController>(
          () => RegistrationController(
        registerUseCase: Get.find<RegisterUseCase>(),
        sendOtpUseCase: Get.find<SendOtpUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<VerifyEmailController>(
          () =>
          VerifyEmailController(verifyOtpUseCase: Get.find<VerifyOtpUseCase>(), sendOtpUseCase: Get.find<SendOtpUseCase>(),),
      fenix: true,
    );

    Get.lazyPut<EnterEmailController>(
          () => EnterEmailController(
        forgotPasswordUseCase: Get.find<ForgotPasswordUseCase>(),
      ),
      fenix: true,
    );
  }
}
