import 'package:get/get.dart';
import 'package:music_game_app/features/profile/presentation/controllers/profile_screen_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {



    //======= Controllers ===============
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
