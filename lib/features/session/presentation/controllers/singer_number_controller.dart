import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SingerNumberController extends GetxController {
  // Observable singer number
  var singerNumber = 2.obs;

  // Observable current singer image
  var currentSingerImage = 'assets/images/two_singer.png'.obs;

  // Select singer number
  void selectSingerNumber(int number) {
    singerNumber.value = number;

    switch (number) {
      case 2:
        currentSingerImage.value = currentSingerImage.value;
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
    print("${singerNumber.value} Singers will participate");
    Get.toNamed(AppRoutes.teamName);
  }
}
