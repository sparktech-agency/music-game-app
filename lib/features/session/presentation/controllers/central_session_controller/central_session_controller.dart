import 'package:get/get.dart';

class CentralSessionController extends GetxController {


  var numberOfRounds = 2.obs;
  var numberOfTeams = 2.obs;
  var numberOfSingers = 2.obs;


  var teamNames = <String>[].obs;
  var players = <String>[].obs;


  void updateRound(int round) => numberOfRounds.value = round;

  void updateTeamCount(int count) {
    numberOfTeams.value = count;

    teamNames.assignAll(List.generate(count, (index) => "Team ${index + 1}"));
  }


  Map<String, dynamic> prepareDataForBackend() {
    return {
      "total_rounds": numberOfRounds.value,
      "total_teams": numberOfTeams.value,
      "total_singers": numberOfSingers.value,
      "team_names": teamNames,
      "player_list": players,
    };
  }


  Future<void> submitGameData() async {
    final payload = prepareDataForBackend();


    try {
      print("Sending to API: $payload");
      // await ApiRepository.postGameSetup(payload);
    } catch (e) {
      Get.snackbar("Error", "Failed to submit: $e");
    }
  }
}