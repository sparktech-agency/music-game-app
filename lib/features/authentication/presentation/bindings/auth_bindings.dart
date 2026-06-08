import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/repositories_impl/auth_repository_impl.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_remote_source.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:music_game_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/enter_email_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/verify_email_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/verify_phone_controller.dart';

class AuthBindings extends Bindings{


  @override
  void dependencies() {


    //============= Data Source and Network ================

    Get.lazyPut<AuthRemoteSource>(() => AuthRemoteSource());


    //============= Repository Implementation ===============

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<AuthRemoteSource>()));



    //=================== UseCases ======================

    Get.lazyPut<RegisterUseCase>(() => RegisterUseCase(Get.find<AuthRepository>()));



    //=================== Controllers ======================

    Get.lazyPut<RegistrationController>(() => RegistrationController(registerUseCase: Get.find<RegisterUseCase>()));
    Get.lazyPut<LoginController>(()=>LoginController());
    Get.lazyPut<VerifyEmailController>(()=>VerifyEmailController());
    Get.lazyPut<VerifyPhoneController>(()=>VerifyPhoneController());
    Get.lazyPut<EnterEmailController>(()=>EnterEmailController());

  }






}