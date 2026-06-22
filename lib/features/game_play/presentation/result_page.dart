import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/game_play/presentation/controllers/result_page_controller.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResultPageController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/game_result_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 35),
                      onPressed: () => controller.playAgain(),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Obx(() => _buildWinnerSection(
                            teamName: controller.winnerTeamName.value,
                            guesses: controller.winnerScoreText.value,
                            time: controller.totalTimeText.value,
                          )),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, left: 30, right: 30),
                  child: _buildPlayAgainButton(controller),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWinnerSection({
    required String teamName,
    required String guesses,
    required String time,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            const Icon(Icons.emoji_events, color: Color(0xFFFFD700), size: 100),
            const SizedBox(height: 10),
            Text(
              "WINNER",
              style: TextStyle(
                color: const Color(0xFFFFD700),
                fontSize: Get.width * 0.12,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          teamName.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBox(guesses, "total guessed"),
            const SizedBox(width: 15),
            _buildStatBox(time, "total time"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Container(
      width: Get.width * 0.40,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(color: Color(0xFFFFD700), fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayAgainButton(ResultPageController controller) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
          colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(35),
          onTap: () => controller.playAgain(),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Play Again",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.refresh, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}