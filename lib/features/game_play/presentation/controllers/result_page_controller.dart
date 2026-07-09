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
    final centralSessionController = Get.find<CentralSessionController>();
    final int totalRounds = centralSessionController.numberOfRounds.value;

    if (scores.isEmpty) {
      winnerTeamName.value = "No Game Played";
      return;
    }


    List<TeamResultModel> tempResults = [];

    scores.forEach((teamName, score) {
      final List<String> players = centralSessionController.teamPlayersMap[teamName] ?? [];
      final int totalSongsOffered = players.length * totalRounds;
      final int totalSeconds = _turnController.teamElapsedTimes[teamName] ?? 0;

      tempResults.add(
        TeamResultModel(
          teamName: teamName,
          score: score,
          scoreRatio: "$score/$totalSongsOffered",
          totalSeconds: totalSeconds,
          formattedTime: _formatElapsedTime(totalSeconds),
        ),
      );
    });


    tempResults.sort((a, b) {
      if (b.score != a.score) {
        return b.score.compareTo(a.score);
      } else {
        return a.totalSeconds.compareTo(b.totalSeconds);
      }
    });


    rankedTeams.assignAll(tempResults);


    if (tempResults.length > 1) {
      final highestScore = tempResults[0].score;


      final tieTeams = tempResults.where((team) => team.score == highestScore).toList();

      if (tieTeams.length > 1) {

        isDraw.value = true;
        winnerTeamName.value = "Draw!";
        winnerScoreText.value = "$highestScore";
        totalTimeText.value = "N/A";
      } else {

        isDraw.value = false;
        final winner = tempResults[0];
        winnerTeamName.value = winner.teamName;
        winnerScoreText.value = winner.scoreRatio;
        totalTimeText.value = winner.formattedTime;
      }
    } else if (tempResults.length == 1) {

      isDraw.value = false;
      final winner = tempResults[0];
      winnerTeamName.value = winner.teamName;
      winnerScoreText.value = winner.scoreRatio;
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




















// class ResultPageController extends GetxController {
//   late final TurnManagementController _turnController;
//
//   var winnerTeamName = "".obs;
//   var winnerScoreText = "0".obs;
//   var totalTimeText = "0s".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _turnController = Get.find<TurnManagementController>();
//     _calculateWinner();
//   }
//
//   void _calculateWinner() {
//     final scores = _turnController.teamScores;
//
//     if (scores.isEmpty) {
//       winnerTeamName.value = "No Game Played";
//       return;
//     }
//
//     String bestTeamName = "";
//     int highestScore = -1;
//
//
//     scores.forEach((teamName, score) {
//       if (bestTeamName.isEmpty) {
//         bestTeamName = teamName;
//         highestScore = score;
//       } else if (score > highestScore) {
//         bestTeamName = teamName;
//         highestScore = score;
//       } else if (score == highestScore) {
//
//         final int currentTime = _turnController.teamElapsedTimes[teamName] ?? 0;
//         final int bestTime = _turnController.teamElapsedTimes[bestTeamName] ?? 0;
//         if (currentTime < bestTime) {
//           bestTeamName = teamName;
//           highestScore = score;
//         }
//       }
//     });
//
//     winnerTeamName.value = bestTeamName;
//
//
//     final centralSessionController = Get.find<CentralSessionController>();
//     final List<String> winnerTeamPlayers = centralSessionController.teamPlayersMap[bestTeamName] ?? [];
//     final int totalRounds = centralSessionController.numberOfRounds.value;
//     final int totalSongsOffered = winnerTeamPlayers.length * totalRounds;
//
//
//     winnerScoreText.value = "$highestScore/$totalSongsOffered";
//
//
//     final int totalSeconds = _turnController.teamElapsedTimes[bestTeamName] ?? 0;
//     totalTimeText.value = _formatElapsedTime(totalSeconds);
//   }
//
//
//   String _formatElapsedTime(int totalSeconds) {
//     if (totalSeconds <= 0) return "0s";
//     final int minutes = totalSeconds ~/ 60;
//     final int seconds = totalSeconds % 60;
//     if (minutes > 0) {
//       return "${minutes}m ${seconds}s";
//     } else {
//       return "${seconds}s";
//     }
//   }
//
//   void playAgain() {
//     Get.delete<TurnManagementController>(force: true);
//     if (Get.isRegistered<CentralSessionController>()) {
//       Get.find<CentralSessionController>().resetSessionData();
//     }
//     Get.offAllNamed(AppRoutes.appLanding);
//   }
// }