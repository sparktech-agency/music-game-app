
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class ResultPageController extends GetxController {
  late final TurnManagementController _turnController;


  var winnerTeamName = "".obs;
  var winnerScoreText = "0".obs;
  var totalTimeText = "4m 15s".obs;

  @override
  void onInit() {
    super.onInit();
    _turnController = Get.find<TurnManagementController>();


    _calculateWinner();
  }

  void _calculateWinner() {
    final scores = _turnController.teamScores;

    if (scores.isEmpty) {
      winnerTeamName.value = "No Game Played";
      return;
    }

    String bestTeamName = "";
    int highestScore = -1;


    scores.forEach((teamName, score) {
      if (bestTeamName.isEmpty || score > highestScore) {
        bestTeamName = teamName;
        highestScore = score;
      }
    });

    winnerTeamName.value = bestTeamName;
    winnerScoreText.value = "$highestScore";
  }

  void playAgain() {

    Get.delete<TurnManagementController>(force: true);


    Get.offAllNamed(AppRoutes.appLanding);
  }
}