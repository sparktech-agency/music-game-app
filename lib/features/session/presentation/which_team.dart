import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/prerequisite_controller.dart';


class WhichTeam extends StatelessWidget {


  const WhichTeam({super.key});

  @override
  Widget build(BuildContext context) {
    final PrerequisiteController controller = Get.find<PrerequisiteController>();

    const Color brandBlue = Color(0xFF2254C9);

    return Scaffold(
      body: Stack(
        children: [
          // //==== 1. Background Gradient or Image ====
          Positioned.fill(
            child: Image.asset(
              'assets/images/all_game_setup.png',
              fit: BoxFit.cover,
            ),
          ),

          // //==== 2. Character Illustration (Use Image.asset here later) ====

          Obx(() {
            bool isTeam1 = controller.selectedTeam.value == 1;


            final team1Character = _buildAnimatedCharacter(
              key: const ValueKey('team1'),
              context: context,
              isSelected: isTeam1,
              top: isTeam1 ? 280 : 120,
              left: isTeam1 ? -60 : 60,
              imagePath: 'assets/images/three_singer.png',
            );

            final team2Character = _buildAnimatedCharacter(
              key: const ValueKey('team2'),
              context: context,
              isSelected: !isTeam1,
              top: !isTeam1 ? 280 : 120,
              left: !isTeam1 ? -60 : 60,
              imagePath: 'assets/images/three_singer.png',
            );


            return Stack(
              children: isTeam1
                  ? [team2Character, team1Character]
                  : [team1Character, team2Character],
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


          // //==== 3. Custom AppBar Over Stack ====
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: _buildHeader(),
          ),

          // //==== 4. Selection UI & Next Button ====
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please select',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),

                // //==== Team Selectors Row ====
                Row(
                  children: [
                    Expanded(child: _buildTeamCard(1, "Team 1", controller)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildTeamCard(2, "Team 2", controller)),
                  ],
                ),

                const SizedBox(height: 60),

                // //==== Pixel Perfect Next Button ====
                _buildNextButton(controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        const Text(
          'Which team do you\nbelong?',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildTeamCard(int teamNum, String title, PrerequisiteController controller) {
    return Obx(() {
      bool isSelected = controller.selectedTeam.value == teamNum;
      return GestureDetector(
        onTap: () => controller.selectTeam(teamNum),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF42E8FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white,
                  width: 2.5,
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // //==== Selection Indicator (Check Mark) ====
            if (isSelected)
              Positioned(
                top: -8,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 16, color: Color(0xFF42E8FF)),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildNextButton(PrerequisiteController controller) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
          colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)],
        ),
      ),
      child: ElevatedButton(
        onPressed: ()=> controller.proceedToNextPage("whichTeam"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        ),
        child: const Text(
          'Next',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  //=======swap effect========//

  Widget _buildAnimatedCharacter({
    Key? key,
    required BuildContext context,
    required bool isSelected,
    required double top,
    required double left,
    required String imagePath,
  }) {
    return AnimatedPositioned(
      key: key,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      top: top,
      left: left,
      right: 0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 600),
        scale: isSelected ? 1.1 : 0.85,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: isSelected ? 1.0 : 1.0,
          child: ColorFiltered(
            colorFilter: isSelected
                ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                : const ColorFilter.matrix(<double>[
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0, 0, 0, 1, 0,
            ]),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: MediaQuery.sizeOf(context).height * 0.40,
            ),
          ),
        ),
      ),
    );
  }

}