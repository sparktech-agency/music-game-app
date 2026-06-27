import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/profile/presentation/controllers/spotify_music_controller.dart';

class SpotifyMusicScreen extends GetView<SpotifyMusicController> {
  const SpotifyMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      appBar: const CustomAppBar(title: 'Connected Music API'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              Obx(() {
                if (!controller.isConnected.value) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        "No Music API Connected",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [

                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1DB954),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Spotify',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'John',
                                style: TextStyle(
                                  color: Color(0xFF6F768E),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ডিসকানেক্ট বাটন
                        _buildDisconnectButton(),
                      ],
                    ),
                    const SizedBox(height: 20),


                    const Divider(
                      color: Color(0xFF1E2746),
                      thickness: 1,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisconnectButton() {
    return Obx(() => GestureDetector(
      onTap: controller.isLoading.value
          ? null
          : () => controller.disconnectSpotify(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: const Color(0xFF1D4ED8),
            width: 1.5,
          ),
        ),
        child: Text(
          controller.isLoading.value ? "..." : "Disconnect",
          style: const TextStyle(
            color: Color(0xFF3B82F6),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }
}