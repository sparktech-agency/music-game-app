import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/connect_music_app/presentation/controllers/connect_music_controller.dart';


class ConnectMusicScreen extends StatelessWidget {
  const ConnectMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    final controller = Get.put(ConnectMusicController());

    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Connect to Music App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  
                  // Title Text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Select Music App You Want to Connect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Spotify Card
                  Obx(() {
                    final isSelected = controller.selectedApp.value == 'spotify';
                    return _buildMusicCard(
                      title: 'Spotify',
                      iconAsset: 'assets/images/spotify_icon.png', 
                      fallbackIcon: Icons.music_note,
                      isSelected: isSelected,
                      onTap: () => controller.selectApp('spotify'),
                    );
                  }),

                  const SizedBox(height: 20),

                  // Apple Music Card
                  Obx(() {
                    final isSelected = controller.selectedApp.value == 'apple';
                    return _buildMusicCard(
                      title: 'Apple Music',
                      iconAsset: 'assets/images/Apple.png',
                      fallbackIcon: Icons.apple,
                      isSelected: isSelected,
                      onTap: () => controller.selectApp('apple'),
                    );
                  }),

                  const Spacer(),

                  // Continue Button
                  Obx(() {
                    final isSelected = controller.selectedApp.value.isNotEmpty;
                    return Container(
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: isSelected
                              ? [const Color(0xFF32C5FF), const Color(0xFF2F54EB)]
                              : [const Color(0xFF14244D), const Color(0xFF0F1B3E)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : () => controller.connectMusicApp(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF5A6E85),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

          
            Obx(() {
              if (!controller.isLoading.value) return const SizedBox.shrink();

              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    color: Colors.black.withValues(alpha: .3),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Connecting...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }


  Widget _buildMusicCard({
    required String title,
    required String iconAsset,
    required IconData fallbackIcon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0B122A).withValues(alpha: .6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF32C5FF) : const Color(0xFF14224A),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // App Icon
            Image.asset(
              iconAsset,
              width: 32,
              height: 32,
              errorBuilder: (context, error, stackTrace) {
                return Icon(fallbackIcon, color: Colors.white, size: 30);
              },
            ),
            const SizedBox(width: 16),
            
            // App Name Text
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            
            // Custom Radio UI
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF2F54EB) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF32C5FF) : const Color(0xFF14224A),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}