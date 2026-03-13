import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/selected_song_controller.dart';

class SelectedSong extends StatelessWidget {
  const SelectedSong({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedSongController controller = Get.put(SelectedSongController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B46FF),
              Color(0xFF3388FF),
            ],
          ),
        ),
        child: SafeArea(

              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // AppBar Section
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 35),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ),

                      const Text(
                        "Show to opponent", //
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),

                      _buildUserProfile(controller),

                      const SizedBox(height: 20),

                      _buildSongCard(controller),

                      const Spacer(),

                      _buildNextButton(controller),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
            ),


      ),
    );
  }

  Widget _buildUserProfile(SelectedSongController controller) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)]),
              ),
              child: const Center(
                child: Text("B", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              ),
            ),
            const Icon(Icons.visibility, color: Colors.white, size: 20),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() => Text(
          controller.userName.value,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildSongCard(SelectedSongController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 4,
          ),
        ),
        child: Column(
          children: [
            const Text(
              "Song title & artist",
              style: TextStyle(
                color: Color(0xFF53EBF3),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Obx(() => Container(
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Image.asset(
                  controller.albumArt.value,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black26,
                      child: const Icon(Icons.music_note, color: Colors.white, size: 50),
                    );
                  },
                ),
              ),
            )),

            const SizedBox(height: 10),

            Obx(() => Text(
              controller.songTitle.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            )),

            const SizedBox(height: 8),

            Obx(() => Text(
              controller.artistName.value,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(SelectedSongController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () => controller.onNext(),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF54EAF2), //
                Color(0xFF3867FF), //
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Center(
            child: Text(
              "Next", //
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}