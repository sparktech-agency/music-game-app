import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/app_bar_with_logo.dart';
import 'package:music_game_app/features/song_packs/presentation/controllers/song_pack_controller.dart';
import 'package:music_game_app/features/song_packs/presentation/widgets/song_pack_card.dart';

class SongPackScreen extends StatelessWidget {
  const SongPackScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SongPackController());

    return Scaffold(

      backgroundColor: const Color(0xFF1d1c35),

      appBar: AppBarWithLogo(userName: "doe john"),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                  () {

                if (controller.songPacks.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                return ListView.builder(

                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 100,
                  ),

                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.songPacks.length,
                  itemBuilder: (context, index) {

                    return RepaintBoundary(
                      child: SongPackCard(pack: controller.songPacks[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}