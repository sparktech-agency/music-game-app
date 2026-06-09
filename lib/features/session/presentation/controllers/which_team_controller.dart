import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class WhichTeamController extends GetxController {
  // Observable selected team (default 0 = none)
  var selectedTeam = 0.obs;

  // Select team
  void selectTeam(int teamNum) {
    selectedTeam.value = teamNum;
  }

  // Proceed to next page
  void proceedToNextPage() {

   print("Which team completed");
   Get.toNamed(AppRoutes.playerName);
  }
}
