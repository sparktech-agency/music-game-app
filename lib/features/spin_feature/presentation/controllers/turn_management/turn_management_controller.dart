import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/features/spin_feature/domain/entities/get_song_entity.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TurnManagementController extends GetxController {
  late final CentralSessionController _sessionController;



  var roundId = "".obs;
  var currentRound = 1.obs;
  var currentTeamIndex = 0.obs;
  var teamScores = <String, int>{}.obs;


  var teamElapsedTimes = <String, int>{}.obs;

  var remainingSingers = <Map<String, String>>[].obs;
  var activeSingerName = "".obs;
  var activeSingerTeam = "".obs;

  var selectedSong = Rxn<GetSongEntity>();

  @override
  void onInit() {
    super.onInit();
    _sessionController = Get.find<CentralSessionController>();
    initializeGameSession();
  }


  void initializeGameSession() {
    teamScores.clear();
    teamElapsedTimes.clear();
    for (var name in _sessionController.teamNames) {
      teamScores[name] = 0;
      teamElapsedTimes[name] = 0;
    }
    currentRound.value = 1;
    currentTeamIndex.value = 0;
    prepareOpponentSingersForTurn();
  }

  String get currentGuessingTeamName {
    if (_sessionController.teamNames.isNotEmpty &&
        currentTeamIndex.value < _sessionController.teamNames.length) {
      return _sessionController.teamNames[currentTeamIndex.value];
    }
    return "";
  }

  void prepareOpponentSingersForTurn() {
    remainingSingers.clear();
    String guessingTeam = currentGuessingTeamName;

    _sessionController.teamPlayersMap.forEach((teamName, players) {
      if (teamName != guessingTeam) {
        for (var player in players) {
          remainingSingers.add({
            "name": player,
            "team": teamName,
          });
        }
      }
    });

    _setupNextSinger();
  }

  bool _setupNextSinger() {
    if (remainingSingers.isNotEmpty) {
      final nextSinger = remainingSingers.first;
      activeSingerName.value = nextSinger["name"] ?? "";
      activeSingerTeam.value = nextSinger["team"] ?? "";
      return true;
    }
    return false;
  }


  void addPointToGuessingTeam(int elapsedSeconds) {
    String guessingTeamName = currentGuessingTeamName;
    if (teamScores.containsKey(guessingTeamName)) {
      teamScores[guessingTeamName] = (teamScores[guessingTeamName] ?? 0) + 1;
    }


    if (teamElapsedTimes.containsKey(guessingTeamName)) {
      teamElapsedTimes[guessingTeamName] = (teamElapsedTimes[guessingTeamName] ?? 0) + elapsedSeconds;
    }
  }

  void completeCurrentSingerPerformance() {
    if (remainingSingers.isNotEmpty) {
      remainingSingers.removeAt(0);
    }

    if (_setupNextSinger()) {
      selectedSong.value = null;
      Get.offAllNamed(AppRoutes.spinFrontPage);
    } else {
      _advanceToNextGuessingTeam();
    }
  }

  void _advanceToNextGuessingTeam() {
    if (currentTeamIndex.value < _sessionController.teamNames.length - 1) {
      currentTeamIndex.value++;
      _resetForNextTurn();
    } else {
      if (currentRound.value < _sessionController.numberOfRounds.value) {
        currentRound.value++;
        currentTeamIndex.value = 0;
        _resetForNextTurn();
      } else {
        Get.offAllNamed(AppRoutes.resultPage);
      }
    }
  }

  void _resetForNextTurn() {
    selectedSong.value = null;
    remainingSingers.clear();
    prepareOpponentSingersForTurn();
    Get.offAllNamed(AppRoutes.spinFrontPage);
  }
}