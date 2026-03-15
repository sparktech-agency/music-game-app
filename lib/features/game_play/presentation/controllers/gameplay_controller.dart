import 'dart:async';
import 'package:get/get.dart';

class GameplayController extends GetxController {

  var teamInfo = "Team 1 | Round 1".obs;
  var singerStatus = "doejohn is singing".obs;
  var songTitle = "Night Changes".obs;
  var artistName = "One Direction".obs;


  var songsGuessed = 0.obs;
  var totalSongs = 6;
  var timeElapsed = "0:00".obs;
  var mainTimer = "00:00:03".obs;


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
  int _seconds = 3;

  @override
  void onInit() {
    super.onInit();
    startGameplayTimer();
  }

  void startGameplayTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;

      mainTimer.value = "00:00:${_seconds.toString().padLeft(2, '0')}";


      if (_seconds % 3 == 0 && currentLyricIndex.value < lyrics.length - 1) {
        currentLyricIndex.value++;
      }
    });
  }

  void onCorrectGuess() {
    if (songsGuessed.value < totalSongs) {
      songsGuessed.value++;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}