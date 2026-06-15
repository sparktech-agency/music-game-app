import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/controllers/nav_controller.dart';


class AppLandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavController>(() => NavController());
  }
}