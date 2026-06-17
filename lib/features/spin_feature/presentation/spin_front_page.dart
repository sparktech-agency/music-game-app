import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/spin_front_page_controller.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';

class SpinFrontPage extends StatelessWidget {
  const SpinFrontPage({super.key});

  @override
  Widget build(BuildContext context) {



    final SpinFrontPageController controller = Get.put(
      SpinFrontPageController(),
      tag: DateTime.now().millisecondsSinceEpoch.toString(),
    );


    final turnController = Get.find<TurnManagementController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Stack(
        children: [

          _buildTopHeroSection(context),


          Positioned(
            top: 60,
            right: 25,
            child: _buildAnimatedTimer(controller),
          ),

          // 3. Main Content Area
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),



                  Obx(() => Text(
                    "Team ${turnController.currentGuessingTeamName}, Your\nCategory Awaits!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),



                  const SizedBox(height: 10),

                  Obx(() => Text(
                    "It's ${turnController.activeSingerTeam.value} — ${turnController.activeSingerName.value}'s turn to sing!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFF9EADDC), fontSize: 16),
                  )),


                  const SizedBox(height: 20),


                  Obx(() => _buildUserProfile(turnController.activeSingerName.value)),


                  const Spacer(),
                  _buildSpinButton(controller),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeroSection(BuildContext context) {
    return ClipPath(
      clipper: CustomBottomCurveClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/count_down.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTimer(SpinFrontPageController controller) {
    return Obx(() {
      if (controller.showCross.value) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 30,
            ),
          ),
        );
      }
      const String assetPath = 'assets/images/five_sec_timer.gif';
      AssetImage(assetPath).evict();
      return SizedBox(
        height: 80,
        width: 80,
        child: Image.asset(
          assetPath,
          key: UniqueKey(),
          fit: BoxFit.contain,
        ),
      );
    });
  }

  Widget _buildUserProfile(String singerName) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF42E8FF),
                Color(0xFF3B82F6),
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/logo_only.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singerName,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSpinButton(SpinFrontPageController controller) {
    return Obx(() {
      final bool isEnabled = controller.isButtonEnabled.value;
      return GestureDetector(
        onTap: isEnabled ? () => controller.onSpinTap() : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            gradient: LinearGradient(
              colors: isEnabled
                  ? [const Color(0xFF42E8FF), const Color(0xFF3B5CFF)]
                  : [const Color(0xFF161B2E), const Color(0xFF161B2E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isEnabled ? Colors.white : Colors.white.withValues(alpha: 0.3),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              child: const Text("Spin for a Category"),
            ),
          ),
        ),
      );
    });
  }
}


class CustomBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}