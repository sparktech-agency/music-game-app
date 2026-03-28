import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/lyrics_controller.dart';

class LyricsPage extends StatelessWidget {
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LyricsController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Obx(() => Stack(
        children: [

          SafeArea(
            child: Column(
              children: [

                _buildAppBar(controller),
                _buildSongHeader(controller),
                _buildLyricsList(controller),
                _buildStartButton(controller),
                const SizedBox(height: 30),

              ],
            ),
          ),


          if (controller.isCountingDown.value) _buildTimerOverlay(controller),
        ],
      )),
    );
  }


  PreferredSizeWidget _buildAppBar(LyricsController controller) {

    return AppBar(
      backgroundColor: const Color(0xFF0A0E21),
      elevation: 0,
      leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${controller.teamName.value} | ${controller.roundNumber.value}",
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Row(
            children: [
              const Icon(Icons.mic, color: Colors.blueAccent, size: 14),
              const SizedBox(width: 4),
              Text(
                "${controller.singerName.value} will sing",
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(Icons.close, color: Colors.white, size: 30),
        ),
      ],
    );
  }
  Widget _buildSongHeader(LyricsController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF1E3A8A)],
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              controller.albumArt.value,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.songTitle.value,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                controller.artistName.value,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildLyricsList(LyricsController controller) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        itemCount: controller.lyrics.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              controller.lyrics[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(
                  alpha: index == controller.lyrics.length - 1 ? 0.3 : 1.0,
                ),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildStartButton(LyricsController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => controller.startGame(),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Tap to Start",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTimerOverlay(LyricsController controller) {

    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Song\nstarts in",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 45, fontWeight: FontWeight.w900, height: 1.1),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 150,
            child: IgnorePointer(
              child: ListWheelScrollView(
                controller: controller.scrollController,
                itemExtent: 140,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(5, (index) {
                  return Center(
                    child: Text(
                      "${5 - index}",
                      style: const TextStyle(
                        color: Color(0xFF42E8FF),
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}