import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SelectedSongController extends GetxController {
  late final TurnManagementController _turnController;

  var songTitle = "Loading...".obs;
  var artistName = "".obs;
  var albumArt = "".obs;

  @override
  void onInit() {
    super.onInit();

    _turnController = Get.find<TurnManagementController>();

    _loadSelectedSongData();
  }

  void _loadSelectedSongData() {
    final song = _turnController.selectedSong.value;
    if (song != null) {
      songTitle.value = song.title;
      artistName.value = song.artist;
      albumArt.value = song.albumArt;
    }
  }

  void onNext() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),

              const Icon(Icons.headset_rounded, color: Colors.white, size: 80),
              const SizedBox(height: 20),

              const Text(
                "Headphones Required",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 15),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Use headphones so that your team will not hear the song you will be singing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Container(height: 1, color: Colors.white.withValues(alpha: 0.3)),

              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offNamed(AppRoutes.lyricsPage);
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.black.withValues(alpha: 0.85),
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
