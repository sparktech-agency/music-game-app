
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/game_play/presentation/controllers/gameplay_controller.dart';

class GameplayPage extends StatelessWidget {
  const GameplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameplayController());


    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(controller),
            _buildSongStrip(controller),
            _buildScoreAndSmallTimer(controller),
            const SizedBox(height: 20),
            _buildMainAnimatedTimer(controller),
            const SizedBox(height: 30),
            _buildLyricsSection(controller),
            _buildBottomControls(controller),
          ],
        ),
      ),
    );
  }


  Widget _buildHeader(GameplayController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          Column(
            children: [
              Obx(() => Text(controller.teamInfo.value, style: const TextStyle(color: Colors.white70, fontSize: 12))),
              Row(
                children: [
                  const Icon(Icons.mic, color: Colors.blueAccent, size: 14),
                  const SizedBox(width: 4),
                  Obx(() => Text(controller.singerStatus.value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
          const Icon(Icons.close, color: Colors.white, size: 28),
        ],
      ),
    );
  }

  Widget _buildSongStrip(GameplayController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF1E40AF), Color(0xFF1D4ED8)]),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/one_direction.jpg', width: 45, height: 45, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(controller.songTitle.value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                Obx(() => Text(controller.artistName.value, style: const TextStyle(color: Colors.white70, fontSize: 13))),
              ],
            ),
          ),
          const Icon(Icons.pause_circle_filled, color: Colors.white, size: 35),
        ],
      ),
    );
  }


  Widget _buildScoreAndSmallTimer(GameplayController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Songs Guessed", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                child: Obx(() => Text("${controller.songsGuessed}/${controller.totalSongs}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Time allotted", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              Obx(() => Text(controller.timeElapsed.value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildMainAnimatedTimer(GameplayController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF42E8FF), width: 3),
        boxShadow: [
          BoxShadow(color: const Color(0xFF42E8FF).withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 2),
        ],
      ),
      child: Obx(() => Text(
        controller.mainTimer.value,
        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2),
      )),
    );
  }


  Widget _buildLyricsSection(GameplayController controller) {
    return Expanded(
      child: Obx(() => ListView.builder(
        itemCount: controller.lyrics.length,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        itemBuilder: (context, index) {
          bool isCurrent = controller.currentLyricIndex.value == index;
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              controller.lyrics[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isCurrent ? const Color(0xFF42E8FF) : Colors.white,
                fontSize: 22,
                fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w600,
              ),
            ),
          );
        },
      )),
    );
  }


  Widget _buildBottomControls(GameplayController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.onCorrectGuess(),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)]),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Correct Guess", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(color: Color(0xFFD9A404), shape: BoxShape.circle),
            child: const Icon(Icons.stop, color: Colors.black, size: 35),
          ),
        ],
      ),
    );
  }
}