import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LyricsController extends GetxController {

  late final TurnManagementController _turnController;


  var teamName = "Team 1".obs;
  var roundNumber = "Round 1".obs;
  var singerName = "doejohn".obs;

  var songTitle = "Night Changes".obs;
  var artistName = "One Direction".obs;
  var albumArt = "assets/images/one_direction.jpg".obs;

  final RxList<String> lyrics = <String>[].obs;

  var countdown = 5.obs;
  var isCountingDown = false.obs;
  late FixedExtentScrollController scrollController;
  Timer? _timer;


  @override
  void onInit() {
    super.onInit();
    scrollController = FixedExtentScrollController();
    _turnController = Get.find<TurnManagementController>();
    _loadLyricsData();
  }

  void _loadLyricsData() {
    teamName.value = _turnController.currentGuessingTeamName;
    roundNumber.value = "Round ${_turnController.currentRound.value}";
    singerName.value = _turnController.activeSingerName.value;

    final song = _turnController.selectedSong.value;
    if (song != null) {
      songTitle.value = song.title;
      artistName.value = song.artist;
      albumArt.value = song.albumArt;
      lyrics.assignAll(song.lyrics);
    }
  }

  void startGame() {
    isCountingDown.value = true;
    countdown.value = 5;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
        scrollController.animateToItem(
          5 - countdown.value,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
        isCountingDown.value = false;

        Get.offNamed(AppRoutes.gameplayPage);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    scrollController.dispose();
    super.onClose();
  }
}