import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TeamNumberController extends GetxController {

  final CentralSessionController sessionController = Get.find<CentralSessionController>();

  RxInt get numberOfTeam => sessionController.numberOfTeams;


  // Select team number
  void selectTeamNumber(int number) {
    sessionController.numberOfTeams.value = number;
  }

  // Proceed to next page
  void proceedToNextPage() {
    print("Selected Teams: ${numberOfTeam.value}");
    Get.toNamed(AppRoutes.singerNumber);
  }
}
