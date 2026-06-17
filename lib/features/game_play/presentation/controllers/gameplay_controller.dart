

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';

class GameplayController extends GetxController {
  late final TurnManagementController _turnController;

  // রিঅ্যাক্টিভ অবজেক্টস ট্র্যাকিং (ভিউ পেজের সাথে কানেকশন)
  var teamInfo = "".obs;
  var singerStatus = "".obs;
  var songTitle = "".obs;
  var artistName = "".obs;
  var albumArt = "assets/images/one_direction.jpg".obs; // সংশোধন: এখন ডিক্লেয়ার করা হয়েছে
  final RxList<String> lyrics = <String>[].obs;

  // গেমপ্লে ডাটা ও স্কোরিং
  var songsGuessed = 0.obs;
  var totalSongs = 1.obs;
  var timeElapsed = "00:00".obs;
  var mainTimer = "60".obs;

  // লিরিক্স স্ক্রলিং এবং টাইমার বর্ডার গলো কালার
  var currentLyricIndex = 0.obs;
  var timerColor = const Color(0xFF42E8FF).obs; // ডিফল্ট ব্লু কালার

  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  Timer? _lyricScrollTimer;
  int _secondsLeft = 60;
  int _secondsElapsed = 0;

  @override
  void onInit() {
    super.onInit();
    // ফাইনাল হওয়া TurnManagementController-টি খুঁজে নেওয়া
    _turnController = Get.find<TurnManagementController>();

    // গেমপ্লে ডেটা ডাইনামিকালি লোড করা
    _loadGameplayData();

    // খেলার কাউন্টডাউন টাইমারসমূহ চালু করা
    _startTimers();
  }

  // খেলার রিয়েল ডাটা লোড করার মেথড
  void _loadGameplayData() {
    teamInfo.value = "${_turnController.currentGuessingTeamName} | ROUND ${_turnController.currentRound.value}";
    singerStatus.value = "${_turnController.activeSingerName.value} is singing";

    final song = _turnController.selectedSong.value;
    if (song != null) {
      songTitle.value = song.title;
      artistName.value = song.artist;
      albumArt.value = song.albumArt; // ডাইনামিক অ্যালবাম আর্ট অ্যাসাইন করা হলো
      lyrics.assignAll(song.lyrics);
    }

    // বর্তমানে গেস করা টিমের বর্তমান পয়েন্ট স্কোরবোর্ড থেকে লোড করা
    songsGuessed.value = _turnController.teamScores[_turnController.currentGuessingTeamName] ?? 0;
  }

  // কাউন্টডাউন ও প্রোগ্রেস টাইমার মেথডস
  void _startTimers() {
    // ৬০ সেকেন্ডের মূল কাউন্টডাউন লুপ
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        mainTimer.value = _secondsLeft.toString().padLeft(2, '0');

        // টাইমারের বর্ডার কালার শিফট লজিক (Blue > 20s -> Yellow > 10s -> Red <= 10s)
        _updateTimerColor(_secondsLeft);
      } else {
        _stopAllTimers();
        _onTimeOut(); // ৬০ সেকেন্ড শেষ হয়ে গেলে টাইমআউট
      }
    });

    // সর্বমোট অতিবাহিত সময় (Time allotted ট্র্যাকিং)
    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      int m = _secondsElapsed ~/ 60;
      int s = _secondsElapsed % 60;
      timeElapsed.value = "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
    });

    // গাইড লিরিক্স হাইলাইট পরিবর্তন (প্রতি ৫ সেকেন্ড পর পর পরবর্তী লাইনে অটো স্ক্রল)
    if (lyrics.isNotEmpty) {
      _lyricScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (currentLyricIndex.value < lyrics.length - 1) {
          currentLyricIndex.value++;
        } else {
          timer.cancel();
        }
      });
    }
  }

  // টাইমারের প্রোগ্রেস কালার কোডিং (Blue > 20s -> Yellow > 10s -> Red <= 10s)
  void _updateTimerColor(int seconds) {
    if (seconds > 20) {
      timerColor.value = const Color(0xFF42E8FF); // Blue
    } else if (seconds > 10) {
      timerColor.value = const Color(0xFFFFD93D); // Yellow
    } else {
      timerColor.value = const Color(0xFFFF4A4A); // Red
    }
  }

  // সঠিক উত্তর অনুমান করলে (Correct Guess)
  void onCorrectGuess() {
    _stopAllTimers(); // ১. টাইমার প্রথমে স্টপ হয়ে যাবে
    showCorrectGuessModal(); // ২. এরপর বটম শীট মডালটি ওপেন হবে
  }

  // সফল অনুমানের ইন্টারেক্টিভ বটম শীট মডাল
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
            // Success Icon
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

            // Success Text
            const Text(
              "Correct Guess",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Stop Song Button
            GestureDetector(
              onTap: () {
                Get.back(); // বটম শীটটি বন্ধ হবে

                // ১. অনুমানকারী দলের স্কোরে +১ পয়েন্ট যোগ হবে
                _turnController.addPointToGuessingTeam();

                // ২. টার্ন বা সিঙ্গারের ট্রানজিশন এগিয়ে যাবে
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

  // ৬০ সেকেন্ড শেষ হয়ে গেলে (Timeout)
  void _onTimeOut() {
    _turnController.completeCurrentSingerPerformance();
  }

  // "I Give Up" বাটন প্রেস করলে কনফার্মেশন ডায়ালগ
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
              Get.back(); // ডায়ালগ ক্লোজ করা
              _stopAllTimers();

              // কোনো পয়েন্ট যোগ ছাড়া পরবর্তী গায়কের স্লটে চলে যাবে
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