import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart'; // নতুন ইম্পোর্ট

class GameplayController extends GetxController {


  late final TurnManagementController _turnController;
  late final CentralSessionController _sessionController;

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

  var currentLyricIndex = 0.obs;
  var timerColor = const Color(0xFF42E8FF).obs;

  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  Timer? _lyricScrollTimer;
  int _secondsLeft = 60;
  int _secondsElapsed = 0;

  @override
  void onInit() {
    super.onInit();
    _turnController = Get.find<TurnManagementController>();
    _loadGameplayData();
    _startTimers();
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

    if (lyrics.isNotEmpty) {
      _lyricScrollTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (currentLyricIndex.value < lyrics.length - 1) {
          currentLyricIndex.value++;
        } else {
          timer.cancel();
        }
      });
    }
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

  void onCorrectGuess() {
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
            GestureDetector(
              onTap: () {
                Get.back();
                _turnController.addPointToGuessingTeam(_secondsElapsed);
                _turnController.completeCurrentSingerPerformance();
              },
              child: Container(
                width: double.infinity,
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }

  void _onTimeOut() {
    _turnController.completeCurrentSingerPerformance();
  }

  void showPauseDialogue() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF161B2E),
        title: const Text(
          "End Turn?",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to surrender this turn early? No point will be awarded.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("CANCEL", style: TextStyle(color: Color(0xFF42E8FF))),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _stopAllTimers();
              _turnController.completeCurrentSingerPerformance();
            },
            child: const Text("END TURN", style: TextStyle(color: Color(0xFFFF4A4A))),
          ),
        ],
      ),
    );
  }

  void _stopAllTimers() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _lyricScrollTimer?.cancel();
  }

  @override
  void onClose() {
    _stopAllTimers();
    super.onClose();
  }
}