import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class RoundSelectionController extends GetxController {

  var numberOfRound = 2.obs;


  String get currentRoundImage {
    switch (numberOfRound.value) {
      case 2:
        return 'assets/images/two_player.png';
      case 3:
        return 'assets/images/three_player.png';
      case 4:
        return 'assets/images/four_player.png';
      default:
        return 'assets/images/two_player.png';
    }
  }

  void selectNumberOfRound(int round) {
    numberOfRound.value = round;
  }

  void proceedToNextPage() {

    print("Selected Rounds: ${numberOfRound.value}");
    Get.toNamed(AppRoutes.teamNumber);
  }
}