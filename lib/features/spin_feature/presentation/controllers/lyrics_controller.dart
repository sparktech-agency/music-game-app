import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LyricsController extends GetxController {

  var teamName = "Team 1".obs;
  var roundNumber = "Round 1".obs;
  var singerName = "doejohn".obs;


  var songTitle = "Night Changes".obs;
  var artistName = "One Direction".obs;
  var albumArt = "assets/images/one_direction.jpg".obs;


  final List<String> lyrics = [
    "Goin' out tonight, changes into something red",
    "Her mother doesn't like that kind of dress",
    "Everything she never had she's showin' off",
    "Drivin' too fast, moon is breakin' through her hair",
    "She's headin' for somethin' that she won't forget",
    "Havin' no regrets is all that she really wants",
    "We're only gettin' older, baby",
    "And I've been thinkin' about it",
  ].obs;


  var countdown = 5.obs;
  var isCountingDown = false.obs;
  late FixedExtentScrollController scrollController;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    scrollController = FixedExtentScrollController();
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


        Get.offNamed('/gameplay_screen');
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