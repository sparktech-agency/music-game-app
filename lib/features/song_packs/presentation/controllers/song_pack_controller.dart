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
        title: "1990's Hits",
        description: "Popular hits many players will recognize",
        songCount: "12 songs available",
        imageUrl: "assets/images/Screenshot_40.png",
        gradientColors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
      ),
      SongPack(
        title: "1980's Hits",
        description: "Turn it up and rock it out",
        songCount: "11 songs available",
        imageUrl: "assets/images/Screenshot_41.png",
        gradientColors: [Color(0xFF232526), Color(0xFF414345)],
      ),
      SongPack(
        title: "Rock Ballads",
        description: "High energy. Non-stop rhythm",
        songCount: "10 songs available",
        imageUrl: "assets/images/Screenshot_42.png",
        gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ),
      SongPack(
        title: "2010's Hits",
        description: "High energy. Non-stop rhythm",
        songCount: "09 songs available",
        imageUrl: "assets/images/Screenshot_42.png",
        gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ),
   
    ]);
  }
}