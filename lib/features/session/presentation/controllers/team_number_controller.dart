import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TeamNumberController extends GetxController {
  // Observable team number
  var teamNumber = 2.obs;

  // Select team number
  void selectTeamNumber(int number) {
    teamNumber.value = number;
  }

  // Proceed to next page
  void proceedToNextPage() {
    print("Selected Teams: ${teamNumber.value}");
    Get.toNamed(AppRoutes.singerNumber);
  }
}
