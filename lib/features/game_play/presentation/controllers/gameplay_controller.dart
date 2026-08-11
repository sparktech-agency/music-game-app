import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';

class GameplayController extends GetxController {


  late final TurnManagementController _turnController;
  late final CentralSessionController _sessionController;

  final AudioPlayer _audioPlayer = AudioPlayer();

  var teamInfo = "".obs;
  var singerStatus = "".obs;
  var songTitle = "".obs;
  var artistName = "".obs;
  var albumArt = "".obs;
  final RxList<String> lyrics = <String>[].obs;

  var songsGuessed = 0.obs;
  var totalSongs = 0.obs;
  var timeElapsed = "00:00".obs;
  var mainTimer = "60".obs;

  
  var timerColor = const Color(0xFF42E8FF).obs;

  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  
  int _secondsLeft = 60;
  int _secondsElapsed = 0;

  @override
  void onInit() {
    super.onInit();
    _turnController = Get.find<TurnManagementController>();
    _sessionController = Get.find<CentralSessionController>();
    _loadGameplayData();
    _startTimers();
    _playSong();
  }

  void _loadGameplayData() {
    teamInfo.value = "${_turnController.currentGuessingTeamName} | ROUND ${_turnController.currentRound.value}";
    singerStatus.value = "${_turnController.activeSingerName.value} is singing";

    final song = _turnController.selectedSong.value;
    if (song != null) {
      songTitle.value = song.title;
      artistName.value = song.artist;
      albumArt.value = song.albumArt;
      lyrics.assignAll(song.lyrics);
    }


    final centralSessionController = Get.find<CentralSessionController>();
    final guessingTeamName = _turnController.currentGuessingTeamName;


    final List<String> currentTeamPlayers = centralSessionController.teamPlayersMap[guessingTeamName] ?? [];


    totalSongs.value = currentTeamPlayers.length * _sessionController.numberOfRounds.value;


    songsGuessed.value = _turnController.teamScores[_turnController.currentGuessingTeamName] ?? 0;
  }


  Future<void> _playSong() async {
    final song = _turnController.selectedSong.value;
    if (song != null && song.audioPath.isNotEmpty) {
      try {
        await _audioPlayer.play(UrlSource(song.audioPath));
      } catch (e) {
        debugPrint("Error playing audio: $e");
      }
    }
  }





  void _startTimers() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        mainTimer.value = _secondsLeft.toString().padLeft(2, '0');
        _updateTimerColor(_secondsLeft);
      } else {
        _stopAllTimers();
        _onTimeOut();
      }
    });

    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      int m = _secondsElapsed ~/ 60;
      int s = _secondsElapsed % 60;
      timeElapsed.value = "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
    });

  }

  void _updateTimerColor(int seconds) {
    if (seconds > 20) {
      timerColor.value = const Color(0xFF42E8FF);
    } else if (seconds > 10) {
      timerColor.value = const Color(0xFFFFD93D);
    } else {
      timerColor.value = const Color(0xFFFF4A4A);
    }
  }



  //===============Client Update====================//

  void onCorrectGuess() async {
    await _audioPlayer.pause();
    _stopAllTimers();
    showCorrectGuessModal();
  }

  void showCorrectGuessModal() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Correct Guess",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),


            //stop song and keep singing

           Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _audioPlayer.stop();
                    Get.back();
                    _turnController.addElapsedTime(_secondsElapsed);
                    _turnController.completeCurrentSingerPerformance();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Stop Song",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await _audioPlayer.resume(); // Resume song
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Keep Singing",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),



            const SizedBox(height: 15),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: false
    );
  }

  void _onTimeOut() {
    _audioPlayer.stop();
    _turnController.addElapsedTime(60); 
    _turnController.completeCurrentSingerPerformance();
  }

  void showPauseDialogue() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: const Color(0xFF222222),
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Icon(
                Icons.lightbulb_outline_rounded,
                color: Color(0xFFF1BA33),
                size: 64.0,
              ),
              const SizedBox(height: 24.0),


              const Text(
                "Do you want to end your turn?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12.0),

              const Text(
                "This will pass the turn to the next player.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32.0),


              ElevatedButton(
                onPressed: () {
                  _audioPlayer.stop();
                  Get.back();
                  _stopAllTimers();
                  _turnController.addElapsedTime(60); 
                  _turnController.completeCurrentSingerPerformance();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1BA33),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 54.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "End Turn",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),


              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44.0),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xFFF1BA33),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }






  void _stopAllTimers() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    
  }

  @override
  void onClose() {
    _stopAllTimers();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.onClose();
  }
}