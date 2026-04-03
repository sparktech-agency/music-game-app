import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/spin_front_page_controller.dart';

class SpinFrontPage extends StatelessWidget {
  const SpinFrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put-এর সাথে tag ব্যবহার করলে প্রতিবার নতুন কন্ট্রোলার তৈরি হবে
    // ফলে onInit() কল হবে এবং টাইমার ফ্রেশ ভাবে শুরু হবে।
    final SpinFrontPageController controller = Get.put(
      SpinFrontPageController(),
      tag: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Stack(
        children: [
          // 1. Top Image Section with Custom Curve
          _buildTopHeroSection(context),

          // 2. Timer / Cross Sign in Top Right
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
                  const Text(
                    "Team 1, Your\nCategory Awaits!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "It's your turn to sing!",
                    style: TextStyle(color: Color(0xFF9EADDC), fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _buildUserProfile(),
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

      return SizedBox(
        height: 80,
        width: 80,
        child: Image.asset(
          'assets/images/five_sec_timer.gif',
          key: UniqueKey(), // GIF-কে প্রতিবার রিস্টার্ট করাবে
          fit: BoxFit.contain,
        ),
      );
    });
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)]),
          ),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF161B2E),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "doe john",
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

// Clipper আগের মতোই থাকবে...
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