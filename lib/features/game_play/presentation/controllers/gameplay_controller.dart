import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameplayController extends GetxController {
  static const int maxSeconds = 30;

  var teamInfo = "Team 1 | Round 1".obs;
  var singerStatus = "doejohn is singing".obs;
  var songTitle = "Night Changes".obs;
  var artistName = "One Direction".obs;

  var songsGuessed = 0.obs;
  var totalSongs = 6;


  var timeElapsed = "0:00".obs;
  var mainTimer = "00:00:00".obs;

  var currentLyricIndex = 0.obs;
  final List<String> lyrics = [
    "Goin' out tonight, changes into something red",
    "Her mother doesn't like that kind of dress",
    "Everything she never had she's showin' off",
    "Drivin' too fast, moon is breakin' through her hair",
    "She's headin' for somethin' that she won't forget",
    "Havin' no regrets is all that she really wants",
  ].obs;

  Timer? _timer;
  int _seconds = 0;

  @override
  void onInit() {
    super.onInit();
    startGameplayTimer();
  }

  void startGameplayTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds >= maxSeconds) {
        _timer?.cancel();
        return;
      }

      _seconds++;


      final duration = Duration(seconds: _seconds);
      mainTimer.value = "${duration.inHours.toString().padLeft(2, '0')}:"
          "${(duration.inMinutes % 60).toString().padLeft(2, '0')}:"
          "${(duration.inSeconds % 60).toString().padLeft(2, '0')}";


      timeElapsed.value = "${(duration.inMinutes % 60)}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";


      if (_seconds % 5 == 0 && currentLyricIndex.value < lyrics.length - 1) {

        currentLyricIndex.value++;

      }
    });
  }

  void onCorrectGuess() {
    if (songsGuessed.value < totalSongs) {
      songsGuessed.value++;
    }
  }


//Dialogue box
  void showPauseDialogue() {
    _timer?.cancel();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
            color: const Color(0xFF333333),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Icon(Icons.lightbulb_outline, color: Color(0xFFFBBF24), size: 80),
              const SizedBox(height: 20),

              const Text(
                "Do you want to end your turn?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                "This will pass the turn to the next player.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  Get.back();

                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "End Turn",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Get.back();
                  startGameplayTimer();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xFFFBBF24),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}