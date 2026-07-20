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
                const SizedBox(height: 10,),
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),

        //exit game logic should be implemented
        onPressed: () => Get.back(),

      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            "${controller.teamName.value} | ${controller.roundNumber.value}",
            style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
          )),
          Row(
            children: [
              const Icon(Icons.mic, color: Colors.blueAccent, size: 16),
              const SizedBox(width: 2),
              Obx(() => Text(
                "${controller.singerName.value} will sing",
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildSongHeader(LyricsController controller) {
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


  Widget _buildLyricsList(LyricsController controller) {
    return Expanded(
      child: Obx(() {
        if (controller.lyrics.isEmpty) {
          return const Center(
            child: Text(
              "No lyrics found",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          itemCount: controller.lyrics.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                controller.lyrics[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        );
      }),
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
              colors: [
                Color(0xFF54EAF2),
                Color(0xFF3867FF),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(40),
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
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: IgnorePointer(
              child: ListWheelScrollView(
                controller: controller.scrollController,
                itemExtent: 80,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(5, (index) {
                  return Center(
                    child: Text(
                      "${5 - index}",
                      style: const TextStyle(
                        color: Color(0xFF42E8FF),
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
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