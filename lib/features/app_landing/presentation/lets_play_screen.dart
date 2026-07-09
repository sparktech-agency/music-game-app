import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LetsPlayScreen extends StatefulWidget {
  const LetsPlayScreen({super.key});

  @override
  State<LetsPlayScreen> createState() => _LetsPlayScreenState();
}

class _LetsPlayScreenState extends State<LetsPlayScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(const AssetImage('assets/images/lets_play_bg.png'), context);
    precacheImage(const AssetImage('assets/images/lets_play.gif'), context);
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/lets_play_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Animated GIF (With optimizations)
          Positioned(
            top: screenSize.height * 0.08,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/lets_play.gif',
              height: screenSize.height * 0.55,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Close Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 35),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),

                const Spacer(flex: 12),


                const _ShiningTextBox(),

                const Spacer(flex: 4),


                _LetsPlayButton(width: screenSize.width * 0.75),

                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _ShiningTextBox extends StatelessWidget {
  const _ShiningTextBox();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Glass container with Glowing border
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color(0xFF42E8FF).withValues(alpha: 0.8),
              width: 3.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF42E8FF).withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RichTextHelper(normal: "No ", bold: "Music"),
              SizedBox(height: 5),
              _RichTextHelper(normal: "Just your ", bold: "Voice"),
            ],
          ),
        ),

        // Svg Sparkling (Right)
        Positioned(
          top: -34,
          right: -30,
          child: SvgPicture.asset(
            'assets/images/sparkling.svg',
            width: 80,
            height: 80,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),

        // Svg Sparkling (Left)
        Positioned(
          bottom: -34,
          left: -30,
          child: SvgPicture.asset(
            'assets/images/sparkling.svg',
            width: 80,
            height: 80,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}

class _RichTextHelper extends StatelessWidget {
  final String normal;
  final String bold;

  const _RichTextHelper({required this.normal, required this.bold});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 34, color: Colors.white, letterSpacing: 0.5),
        children: [
          TextSpan(text: normal, style: const TextStyle(fontWeight: FontWeight.w300)),
          TextSpan(text: bold, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _LetsPlayButton extends StatelessWidget {
  final double width;

  const _LetsPlayButton({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
          onTap: () => Get.toNamed(AppRoutes.mainSplash),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Play",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 2),
              Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}