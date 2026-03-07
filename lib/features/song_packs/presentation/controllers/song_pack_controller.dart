import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/song_packs/data/song_pack.dart';

class SongPackController extends GetxController {
  var songPacks = <SongPack>[].obs;

  @override
  void onInit() {
    super.onInit();

    songPacks.assignAll([
      SongPack(
        title: "Pop",
        description: "Popular hits many players will recognize",
        songCount: "17 songs available",
        imageUrl: "assets/images/Screenshot_40.png",
        gradientColors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
      ),
      SongPack(
        title: "Rock",
        description: "Turn it up and rock it out",
        songCount: "17 songs available",
        imageUrl: "assets/images/Screenshot_41.png",
        gradientColors: [Color(0xFF232526), Color(0xFF414345)],
      ),
      SongPack(
        title: "EDM",
        description: "High energy. Non-stop rhythm",
        songCount: "17 songs available",
        imageUrl: "assets/images/Screenshot_42.png",
        gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ),
      SongPack(
        title: "EDM",
        description: "High energy. Non-stop rhythm",
        songCount: "17 songs available",
        imageUrl: "assets/images/Screenshot_42.png",
        gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ),
      SongPack(
        title: "Pop",
        description: "Popular hits many players will recognize",
        songCount: "17 songs available",
        imageUrl: "assets/images/Screenshot_40.png",
        gradientColors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
      ),
      SongPack(
        title: "Pop",
        description: "Popular hits many players will recognize",
        songCount: "17 songs available",
        imageUrl: "assets/images/Screenshot_40.png",
        gradientColors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
      ),
    ]);
  }
}