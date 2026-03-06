import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/app_bar_with_logo.dart';
import 'package:music_game_app/features/song_packs/presentation/controllers/song_pack_controller.dart';
import 'package:music_game_app/features/song_packs/presentation/widgets/song_pack_card.dart';

class SongPackScreen extends StatelessWidget {
  SongPackScreen({super.key});


  final controller = Get.put(SongPackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBarWithLogo(userName: "doe john"),


      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF1d1c35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
              child: Text(
                "My Song Packs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),


            Expanded(
              child: Obx(
                    () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: controller.songPacks.length,
                  itemBuilder: (context, index) {
                    return SongPackCard(pack: controller.songPacks[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}