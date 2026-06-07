import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/enter_email_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/verify_email_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/verify_phone_controller.dart';

class AuthBindings extends Bindings{


  @override
  void dependencies() {


    //============= Controllers ================
    Get.lazyPut<LoginController>(()=>LoginController());
    Get.lazyPut<RegistrationController>(()=>RegistrationController());
    Get.lazyPut<VerifyEmailController>(()=>VerifyEmailController());
    Get.lazyPut<VerifyPhoneController>(()=>VerifyPhoneController());
    Get.lazyPut<EnterEmailController>(()=>EnterEmailController());

  }






}