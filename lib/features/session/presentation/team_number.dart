import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/team_number_controller.dart';

class TeamNumber extends GetView<TeamNumberController> {
  const TeamNumber({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF2254C9);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/all_game_setup.png',
              fit: BoxFit.cover,
            ),
          ),

          Obx(() {
            int count = controller.numberOfTeam.value;

            final List<Map<String, double>> positions;

            if (count == 2) {
              positions = [
                {'top': 180, 'left': 30, 'height': 0.24},
                {'top': 310, 'left': -30, 'height': 0.27},
              ];
            } else if (count == 3) {
              positions = [
                {'top': 140, 'left': -130, 'height': 0.18},
                {'top': 240, 'left': 130, 'height': 0.22},
                {'top': 360, 'left': -30, 'height': 0.27},
              ];
            } else {
              positions = [
                {'top': 240, 'left': -160, 'height': 0.14},
                {'top': 240, 'left': 160, 'height': 0.14},
                {'top': 360, 'left': -160, 'height': 0.16},
                {'top': 360, 'left': 200, 'height': 0.16},
              ];
            }

            return Stack(
              children: List.generate(count, (index) {
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        top: positions[index]['top'],
                        left: positions[index]['left'],
                        right: 0,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: 1.0,
                          child: Image.asset(
                            'assets/images/team_selection.png',
                            fit: BoxFit.contain,
                            height:
                                MediaQuery.sizeOf(context).height *
                                positions[index]['height']!,
                          ),
                        ),
                      );
                    }),
            );
          }),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    brandBlue.withValues(alpha: 0.0),
                    brandBlue.withValues(alpha: 1.0),
                    brandBlue.withValues(alpha: 1.0),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'How many teams\nwill participate?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,)
                    ],
                  ),
                ),

                const Spacer(),

                SizedBox(height: MediaQuery.sizeOf(context).height * 0.50),

                const Text(
                  'Please select',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    2,
                    3,
                    4,
                  ].map((team) => _buildRoundCircle(team)).toList(),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.proceedToNextPage();
                    },
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF39E3FE), Color(0xFF2C6BFF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundCircle(int team) {
    return Obx(() {
      bool isSelected = controller.numberOfTeam.value == team;
      return GestureDetector(
        onTap: () => controller.selectTeamNumber(team),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF42E8E0)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white,
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  '$team',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            if (isSelected)
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 15,
                  color: Color(0xFF42E8E0),
                ),
              ),
          ],
        ),
      );
    });
  }
}
