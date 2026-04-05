import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/game_play/presentation/widgets/result_screen.dart';

class GameController extends GetxController{

  var totalRounds = 2.obs;
  var totalTeams = 2.obs;
  var totalSingers = 2.obs;

  var team1Name = "".obs;
  var team2Name = "".obs;

  var team1Players = <String>[].obs;
  var team2Players = <String>[].obs;

  var currentTurn = 0.obs;

  void initializeGame({
    required int numberOfRounds,
    required int numberOfTeams,
    required int numberOfSingers,
    required String t1Name,
    required String t2Name,
    required int myTeam,
    required List<String> t1Players,
    required List<String> t2Players,
  }) {
    totalRounds.value = numberOfRounds;
    totalTeams.value = numberOfTeams;
    totalSingers.value = numberOfSingers;
    team1Name.value = t1Name;
    team2Name.value = t2Name;
    currentTurn.value = myTeam;
    team1Players.assignAll(t1Players);
    team2Players.assignAll(t2Players);
  }



  //Game result functionality

  var team1Score = 0.obs;
  var team2Score = 0.obs;
  var currentRound = 1.obs;


  void updateScore(int points) {
    if (currentTurn.value == 1) {
      team1Score.value += points;
    } else {
      team2Score.value += points;
    }
  }


  void switchTurnAndCheckRound() {
    if (currentTurn.value == 1) {
      currentTurn.value = 2;
    } else {

      if (currentRound.value < totalRounds.value) {
        currentRound.value++;
        currentTurn.value = 1;
      } else {
        Get.off(() => const ResultScreen());
      }
    }
  }

  void _showFinalResult() {
    debugPrint("======== FINAL RESULT ========");
    debugPrint("${team1Name.value}: ${team1Score.value}");
    debugPrint("${team2Name.value}: ${team2Score.value}");
    if (team1Score.value > team2Score.value) debugPrint("Winner: ${team1Name.value}");
    else if (team2Score.value > team1Score.value) debugPrint("Winner: ${team2Name.value}");
    else debugPrint("Match Draw!");
    debugPrint("==============================");
  }

}