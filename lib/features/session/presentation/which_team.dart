import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/which_team_controller.dart';

class WhichTeam extends GetView<WhichTeamController> {
  const WhichTeam({super.key});

  static const Color brandBlue = Color(0xFF2254C9);
  static const Color accentBlue = Color(0xFF42E8FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/all_game_setup.png',
              fit: BoxFit.cover,
            ),
          ),

          // Characters
          Obx(() {
            final isSwapped = controller.isSwapped.value;

            return Stack(
              children: isSwapped
                  ? [
                      _AnimatedCharacter(
                        key: const ValueKey('team2'),
                        isSelected: false,
                        top: 120,
                        left: 60,
                      ),
                      _AnimatedCharacter(
                        key: const ValueKey('team1'),
                        isSelected: true,
                        top: 280,
                        left: -60,
                      ),
                    ]
                  : [
                      _AnimatedCharacter(
                        key: const ValueKey('team1'),
                        isSelected: false,
                        top: 120,
                        left: 60,
                      ),
                      _AnimatedCharacter(
                        key: const ValueKey('team2'),
                        isSelected: true,
                        top: 280,
                        left: -60,
                      ),
                    ],
            );
          }),

          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x002254C9), brandBlue, brandBlue],
                ),
              ),
            ),
          ),

          // Header
          const Positioned(top: 40, left: 10, right: 10, child: _Header()),

          // Selection + Next Button
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please select',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                SizedBox(
                  height: 70,
                  child: Obx(
                    () => ListView.separated(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.teamNames.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (_, index) {
                        final teamName = controller.teamNames[index];
                        return SizedBox(
                          width: 150,
                          child: _TeamCard(title: teamName),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 60),
                const _NextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//================= Team Card =================//
class _TeamCard extends GetView<WhichTeamController> {
  final String title;

  const _TeamCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.isSelected(title);

      return GestureDetector(
        onTap: () => controller.selectTeam(title),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? WhichTeam.accentBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white,
                  width: 2.5,
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                top: -5,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: WhichTeam.accentBlue,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

//================= Header =================//
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}

//================= Animated Character =================//
class _AnimatedCharacter extends StatelessWidget {
  final bool isSelected;
  final double top;
  final double left;

  const _AnimatedCharacter({
    super.key,
    required this.isSelected,
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      top: top,
      left: left,
      right: 0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 600),
        scale: isSelected ? 1.1 : 0.85,
        child: ColorFiltered(
          colorFilter: isSelected
              ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
              : const ColorFilter.matrix([
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
          child: Image.asset(
            'assets/images/three_singer.png',
            fit: BoxFit.contain,
            height: MediaQuery.sizeOf(context).height * 0.40,
          ),
        ),
      ),
    );
  }
}

//================= Next Button =================//
class _NextButton extends GetView<WhichTeamController> {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: controller.proceedToNextPage,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              padding: EdgeInsets.zero,
            ).copyWith(
              backgroundColor: MaterialStateProperty.resolveWith((_) => null),
            ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [WhichTeam.accentBlue, Color(0xFF3B5CFF)],
            ),
            borderRadius: BorderRadius.circular(35),
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
    );
  }
}
