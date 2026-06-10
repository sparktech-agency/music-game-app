import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SingerNumberController extends GetxController {


  final CentralSessionController sessionController = Get.find<CentralSessionController>();


  RxInt get numberOfSinger => sessionController.numberOfSingers;


  var currentSingerImage = 'assets/images/two_singer.png'.obs;

  // Select singer number
  void selectSingerNumber(int number) {
    sessionController.numberOfSingers.value = number;

    switch (number) {
      case 2:
        currentSingerImage.value = 'assets/images/two_singer.png';
        break;
      case 3:
        currentSingerImage.value = 'assets/images/three_singer.png';
        break;
      case 4:
        currentSingerImage.value = 'assets/images/four_singer.png';
        break;
      case 5:
        currentSingerImage.value = 'assets/images/five_singer.png';
        break;
      default:
        currentSingerImage.value = 'assets/images/two_singer.png';
    }
  }

  // Proceed to next page
  void proceedToNextPage() {
    print("${numberOfSinger.value} Singers will participate");
    Get.toNamed(AppRoutes.teamName);
  }
}
