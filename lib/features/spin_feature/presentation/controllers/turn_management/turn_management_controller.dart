import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/features/spin_feature/domain/entities/get_song_entity.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TurnManagementController extends GetxController {
 late final CentralSessionController _sessionController;

  
  var roundId = "".obs;
  var currentRound = 1.obs;
  
  
  var currentSequenceIndex = 0.obs;

  
  var teamScores = <String, int>{}.obs; 
  var teamElapsedTimes = <String, int>{}.obs;

  
  var roundSequence = <Map<String, String>>[].obs;

  var activeSingerName = "".obs;
  var activeSingerTeam = "".obs;
  var activeOpponentJudge = "".obs;

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
    currentSequenceIndex.value = 0;

    
    generateRoundSequence();
  }

  
  
  void generateRoundSequence() {
    roundSequence.clear();
    int maxPlayersPerTeam = _sessionController.numberOfSingers.value; 

    for (int playerIdx = 0; playerIdx < maxPlayersPerTeam; playerIdx++) {
      for (int teamIdx = 0; teamIdx < _sessionController.teamNames.length; teamIdx++) {
        String teamName = _sessionController.teamNames[teamIdx];
        List<String> players = _sessionController.teamPlayersMap[teamName] ?? [];
        
        if (playerIdx < players.length) {
          roundSequence.add({
            "playerName": players[playerIdx],
            "teamName": teamName,
          });
        }
      }
    }

    _setupActiveTurnData();
  }

  
  void _setupActiveTurnData() {
    if (roundSequence.isNotEmpty && currentSequenceIndex.value < roundSequence.length) {
      final activeSlot = roundSequence[currentSequenceIndex.value];
      activeSingerName.value = activeSlot["playerName"] ?? "";
      activeSingerTeam.value = activeSlot["teamName"] ?? "";

    
      activeOpponentJudge.value = _getOpponentJudge(activeSingerTeam.value);
    }
  }

  String _getOpponentJudge(String singerTeamName) {
    for (var team in _sessionController.teamNames) {
      if (team != singerTeamName) {
        List<String> players = _sessionController.teamPlayersMap[team] ?? [];
        if (players.isNotEmpty) {
          return players[0]; 
        }
      }
    }
    return "Opponent";
  }

  
  String get currentGuessingTeamName => activeSingerTeam.value;

 
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
    if (currentSequenceIndex.value < roundSequence.length - 1) {
  
      currentSequenceIndex.value++;
      selectedSong.value = null;
      _setupActiveTurnData();
      Get.offAllNamed(AppRoutes.spinFrontPage);
    } else {
      
      _advanceToNextRound();
    }
  }

  void _advanceToNextRound() {
    if (currentRound.value < _sessionController.numberOfRounds.value) {
      currentRound.value++;
      currentSequenceIndex.value = 0; 
      selectedSong.value = null;
      
    
      generateRoundSequence();
      Get.offAllNamed(AppRoutes.spinFrontPage);
    } else {
     
      Get.offAllNamed(AppRoutes.resultPage);
    }
  }
}