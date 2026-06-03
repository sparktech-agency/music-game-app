import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';

class AuthBindings extends Bindings{


  @override
  void dependencies() {


    //============= Controllers ================
    Get.lazyPut<LoginController>(()=>LoginController());
    Get.lazyPut<RegistrationController>(()=>RegistrationController());

  }






}