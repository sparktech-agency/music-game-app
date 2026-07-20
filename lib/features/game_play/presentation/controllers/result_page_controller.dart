import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';




class TeamResultModel {
  final String teamName;
  final int score;
  final String scoreRatio;
  final int totalSeconds;
  final String formattedTime;

  TeamResultModel({
    required this.teamName,
    required this.score,
    required this.scoreRatio,
    required this.totalSeconds,
    required this.formattedTime,
  });
}
class ResultPageController extends GetxController {
  late final TurnManagementController _turnController;

  var winnerTeamName = "".obs;
  var winnerScoreText = "0".obs;
  var totalTimeText = "0s".obs;


  var isDraw = false.obs;


  var rankedTeams = <TeamResultModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _turnController = Get.find<TurnManagementController>();
    _calculateWinnerAndRankings();
  }

  

void _calculateWinnerAndRankings() {
  final scores = _turnController.teamScores; 
  
  if (scores.isEmpty) {
    winnerTeamName.value = "No Game Played";
    return;
  }

  List<TeamResultModel> tempResults = [];

  scores.forEach((teamName, _) {
    final int totalSeconds = _turnController.teamElapsedTimes[teamName] ?? 0;
    final String formatted = _formatElapsedTime(totalSeconds);

    tempResults.add(
      TeamResultModel(
        teamName: teamName,
        score: 0, 
        scoreRatio: formatted,
        totalSeconds: totalSeconds,
        formattedTime: formatted,
      ),
    );
  });

 
  tempResults.sort((a, b) => a.totalSeconds.compareTo(b.totalSeconds));

  rankedTeams.assignAll(tempResults);


  if (tempResults.length > 1) {
    final lowestTime = tempResults[0].totalSeconds;

  
    final tieTeams = tempResults.where((team) => team.totalSeconds == lowestTime).toList();

    if (tieTeams.length > 1) {
      isDraw.value = true;
      winnerTeamName.value = "Draw!";
      winnerScoreText.value = "N/A";
      totalTimeText.value = tempResults[0].formattedTime;
    } else {
      isDraw.value = false;
      final winner = tempResults[0];
      winnerTeamName.value = winner.teamName;
      winnerScoreText.value = "Best Time";
      totalTimeText.value = winner.formattedTime;
    }
  } else if (tempResults.length == 1) {
    isDraw.value = false;
    final winner = tempResults[0];
    winnerTeamName.value = winner.teamName;
    winnerScoreText.value = "Best Time";
    totalTimeText.value = winner.formattedTime;
  }
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
