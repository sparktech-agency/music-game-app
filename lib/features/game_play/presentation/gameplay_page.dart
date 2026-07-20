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
            const SizedBox(height: 10,),
            _buildSongStrip(controller),
            _buildScoreAndSmallTimer(controller),
            _buildMainAnimatedTimer(controller),
            const SizedBox(height: 20),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),

            //exit popup should be implemented
            onPressed: () => Get.back(),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Text(
                  controller.teamInfo.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
                )),
                Row(
                  children: [
                    const Icon(Icons.mic, color: Colors.blueAccent, size: 16),
                    const SizedBox(width: 4),
                    Obx(() => Text(
                      controller.singerStatus.value,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => controller.showPauseDialogue(),
          ),
        ],
      ),
    );
  }

  Widget _buildSongStrip(GameplayController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF1E40AF), Color(0xFF1D4ED8)]),
        border: Border(
          top: BorderSide(color: Colors.white, width: 2),
          bottom: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Row(
        children: [

          Obx(() {
            final String path = controller.albumArt.value;
            final bool isNetworkImage = path.startsWith('http');

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: path.isEmpty
                  ? _buildPlaceholder()
                  : isNetworkImage
                  ? Image.network(
                path,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              )
                  : Image.asset(
                path,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              ),
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.songTitle.value,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                )),
                Obx(() => Text(
                  controller.artistName.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                )),
              ],
            ),
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Transform.scale(
                scale: 4.0,
                child: Image.asset(
                  'assets/images/music_bar.gif',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPlaceholder() {
    return Container(
      width: 45,
      height: 45,
      color: Colors.black26,
      child: const Icon(Icons.music_note, color: Colors.white, size: 20),
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
                child: Obx(() => Text(
                  "${controller.songsGuessed.value}/${controller.totalSongs.value}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )),
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
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: controller.timerColor.value, width: 2),
        boxShadow: [
          BoxShadow(
            color: controller.timerColor.value.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Text(
        controller.mainTimer.value,
        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 2),
      ),
    ));
  }


  Widget _buildLyricsSection(GameplayController controller) {
    return Expanded(
      child: Obx(() {
        if (controller.lyrics.isEmpty) {
          return const Center(
            child: Text(
              "No lyrics found",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.lyrics.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            bool isCurrent = controller.currentLyricIndex.value == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                controller.lyrics[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isCurrent ? const Color(0xFF42E8FF) : Colors.white,
                  fontSize: 18,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w400,
                ),
              ),
            );
          },
        );
      }),
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
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Center(
                  child: Text(
                    "Correctly\nGuessed",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.showPauseDialogue(),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9A404),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Center(
                  child: Text(
                    "I Give Up",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}