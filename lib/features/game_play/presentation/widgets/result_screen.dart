import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),


                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        _buildResultSection(
                          isWinner: true,
                          teamName: "Team 2",
                          guesses: "6 / 6",
                          time: "4m",
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: Divider(color: Colors.white24, thickness: 1, indent: 40, endIndent: 40),
                        ),


                        _buildResultSection(
                          isWinner: false,
                          teamName: "Team 1",
                          guesses: "4 / 6",
                          time: "4m 15s",
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                // ৪. প্লে এগেইন বাটন (LetsPlayScreen স্টাইল)
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, left: 30, right: 30),
                  child: _buildPlayAgainButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection({
    required bool isWinner,
    required String teamName,
    required String guesses,
    required String time,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isWinner
            ? Column(
          children: [
            const Icon(Icons.emoji_events, color: Color(0xFFFFD700), size: 70),
            Text(
              "WIN",
              style: TextStyle(
                color: const Color(0xFFFFD700),
                fontSize: Get.width * 0.12,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                letterSpacing: 2,
              ),
            ),
          ],
        )
            : Column(
          children: [
            const Icon(Icons.thumb_down, color: Color(0xFF5C7CFA), size: 50),
            Text(
              "LOSE",
              style: TextStyle(
                color: Colors.white70,
                fontSize: Get.width * 0.10,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          teamName.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBox(guesses, "# of guesses"),
            const SizedBox(width: 15),
            _buildStatBox(time, "total time"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Container(
      width: Get.width * 0.38,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayAgainButton(BuildContext context) {
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
          onTap: () => Get.offAllNamed(AppRoutes.appLanding),
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