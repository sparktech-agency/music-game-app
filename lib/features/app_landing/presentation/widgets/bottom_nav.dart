import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/controllers/nav_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {

    final NavController controller = Get.find<NavController>();

    return Container(
      height: 90,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [

            Color(0xFF00C6FF),
            Color(0xFF0072FF),

          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.mic_rounded, "Let's Sing", controller),
              _buildNavItem(1, Icons.lightbulb_outline_rounded, "Guide", controller),
              _buildNavItem(2, Icons.music_note_rounded, "Song Packs", controller),
              _buildNavItem(3, Icons.person_outline_rounded, "Profile", controller),
            ],
          )),
        ],
      ),
    );
  }


  Widget _buildNavItem(int index, IconData icon, String label, NavController controller) {

    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSelected ? 100 : 80,

        margin: EdgeInsets.only(bottom: isSelected ? 20 : 0),
        decoration: isSelected
            ? BoxDecoration(
          color: const Color(0xFF3399FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [

                if (isSelected)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),

                Icon(
                  icon,
                  size: isSelected ? 35 : 28,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSelected ? 14 : 14,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,

                shadows: isSelected ? [const Shadow(blurRadius: 5, color: Colors.black26)] : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}