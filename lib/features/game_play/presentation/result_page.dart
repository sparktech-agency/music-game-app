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
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/game_result_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top Close Button
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
                // Main Content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          // Dynamic Winner or Draw Header
                          Obx(() {
                            return _buildTopHeroSection(
                              isDraw: controller.isDraw.value,
                              teamName: controller.winnerTeamName.value,
                              guesses: controller.winnerScoreText.value,
                              time: controller.totalTimeText.value,
                            );
                          }),
                          const SizedBox(height: 35),

                          // Leaderboard Header
                          _buildSectionHeader("FINAL STANDINGS"),
                          const SizedBox(height: 15),

                          // Leaderboard List
                          Obx(() {
                            return Column(
                              children: List.generate(
                                controller.rankedTeams.length,
                                    (index) {
                                  final team = controller.rankedTeams[index];
                                  return _buildLeaderboardCard(
                                    rank: index + 1,
                                    teamName: team.teamName,
                                    scoreRatio: team.scoreRatio,
                                    time: team.formattedTime,
                                    isDraw: controller.isDraw.value,
                                  );
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                // Play Again Button at bottom
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


  Widget _buildTopHeroSection({
    required bool isDraw,
    required String teamName,
    required String guesses,
    required String time,
  }) {
    if (isDraw) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.handshake, color: Color(0xFF42E8FF), size: 100),
          const SizedBox(height: 10),
          Text(
            "MATCH DRAW",
            style: TextStyle(
              color: const Color(0xFF42E8FF),
              fontSize: Get.width * 0.10,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "NO SINGLE WINNER",
            style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 15),
        Text(
          teamName.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
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

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
      ],
    );
  }


  Widget _buildLeaderboardCard({
    required int rank,
    required String teamName,
    required String scoreRatio,
    required String time,
    required bool isDraw,
  }) {

    final bool isFirst = rank == 1 && !isDraw;

    Color rankColor;
    if (rank == 1 && !isDraw) {
      rankColor = const Color(0xFFFFD700); // Gold
    } else if (rank == 2 && !isDraw) {
      rankColor = const Color(0xFFC0C0C0); // Silver
    } else {
      rankColor = Colors.white54;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isFirst
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isFirst ? const Color(0xFFFFD700).withValues(alpha: 0.6) : Colors.white12,
          width: isFirst ? 1.8 : 1.0,
        ),
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: rankColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              "#$rank",
              style: TextStyle(
                color: rankColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Team Name & Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teamName,
                  style: TextStyle(
                    color: isFirst ? const Color(0xFFFFD700) : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, color: Colors.white38, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Score Ratio
          Text(
            scoreRatio,
            style: TextStyle(
              color: isFirst ? const Color(0xFFFFD700) : Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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






















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:music_game_app/features/game_play/presentation/controllers/result_page_controller.dart';
//
// class ResultPage extends StatelessWidget {
//   const ResultPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ResultPageController());
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/game_result_bg.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 10, top: 5),
//                     child: IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white, size: 35),
//                       onPressed: () => controller.playAgain(),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 20),
//                           Obx(() => _buildWinnerSection(
//                             teamName: controller.winnerTeamName.value,
//                             guesses: controller.winnerScoreText.value,
//                             time: controller.totalTimeText.value,
//                           )),
//                           const SizedBox(height: 30),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 25, left: 30, right: 30),
//                   child: _buildPlayAgainButton(controller),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWinnerSection({
//     required String teamName,
//     required String guesses,
//     required String time,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Column(
//           children: [
//             const Icon(Icons.emoji_events, color: Color(0xFFFFD700), size: 100),
//             const SizedBox(height: 10),
//             Text(
//               "WINNER",
//               style: TextStyle(
//                 color: const Color(0xFFFFD700),
//                 fontSize: Get.width * 0.12,
//                 fontWeight: FontWeight.w900,
//                 fontStyle: FontStyle.italic,
//                 letterSpacing: 2,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 15),
//         Text(
//           teamName.toUpperCase(),
//           style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildStatBox(guesses, "total guessed"),
//             const SizedBox(width: 15),
//             _buildStatBox(time, "total time"),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatBox(String value, String label) {
//     return Container(
//       width: Get.width * 0.40,
//       padding: const EdgeInsets.symmetric(vertical: 18),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.05),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white24, width: 1.5),
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: const TextStyle(color: Color(0xFFFFD700), fontSize: 26, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: const TextStyle(color: Colors.white60, fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlayAgainButton(ResultPageController controller) {
//     return Container(
//       width: double.infinity,
//       height: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(35),
//         gradient: const LinearGradient(
//           colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(35),
//           onTap: () => controller.playAgain(),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Play Again",
//                 style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(width: 8),
//               Icon(Icons.refresh, color: Colors.white, size: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }