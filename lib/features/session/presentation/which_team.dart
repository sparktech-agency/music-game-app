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
            final isTeam1Selected = isSwapped;
            final isTeam2Selected = !isSwapped;

            final char1 = _AnimatedCharacter(
              key: const ValueKey('team1'),
              isSelected: isTeam1Selected,
              top: isTeam1Selected ? 280 : 120,
              left: isTeam1Selected ? -60 : 60,
            );

            final char2 = _AnimatedCharacter(
              key: const ValueKey('team2'),
              isSelected: isTeam2Selected,
              top: isTeam2Selected ? 280 : 120,
              left: isTeam2Selected ? -60 : 60,
            );

            return Stack(
              children: isTeam1Selected ? [char2, char1] : [char1, char2],
            );
          }),

          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x002254C9), brandBlue, brandBlue],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: _Header(),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
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

                        const SizedBox(height: 30),
                        const _NextButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
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
              const Positioned(
                top: -5,
                right: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: WhichTeam.accentBlue,
                    ),
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
        const SizedBox(width: 20),
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

  static const List<double> _grayscaleMatrix = [
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
  ];

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
              : const ColorFilter.matrix(_grayscaleMatrix),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
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