import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class ResultPageController extends GetxController {
  late final TurnManagementController _turnController;

  var winnerTeamName = "".obs;
  var winnerScoreText = "0".obs;
  var totalTimeText = "0s".obs;

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
      if (bestTeamName.isEmpty) {
        bestTeamName = teamName;
        highestScore = score;
      } else if (score > highestScore) {
        bestTeamName = teamName;
        highestScore = score;
      } else if (score == highestScore) {

        final int currentTime = _turnController.teamElapsedTimes[teamName] ?? 0;
        final int bestTime = _turnController.teamElapsedTimes[bestTeamName] ?? 0;
        if (currentTime < bestTime) {
          bestTeamName = teamName;
          highestScore = score;
        }
      }
    });

    winnerTeamName.value = bestTeamName;


    final centralSessionController = Get.find<CentralSessionController>();
    final List<String> winnerTeamPlayers = centralSessionController.teamPlayersMap[bestTeamName] ?? [];
    final int totalRounds = centralSessionController.numberOfRounds.value;
    final int totalSongsOffered = winnerTeamPlayers.length * totalRounds;


    winnerScoreText.value = "$highestScore/$totalSongsOffered";


    final int totalSeconds = _turnController.teamElapsedTimes[bestTeamName] ?? 0;
    totalTimeText.value = _formatElapsedTime(totalSeconds);
  }


  String _formatElapsedTime(int totalSeconds) {
    if (totalSeconds <= 0) return "0s";
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    if (minutes > 0) {
      return "${minutes}m ${seconds}s";
    } else {
      return "${seconds}s";
    }
  }

  void playAgain() {
    Get.delete<TurnManagementController>(force: true);
    if (Get.isRegistered<CentralSessionController>()) {
      Get.find<CentralSessionController>().resetSessionData();
    }
    Get.offAllNamed(AppRoutes.appLanding);
  }
}