import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LetsPlayScreen extends StatelessWidget {
  const LetsPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/images/lets_play_bg.png',
              fit: BoxFit.cover,
            ),
          ),


          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/lets_play.gif',
              height: MediaQuery.of(context).size.height * 0.55,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [

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


                _buildShiningTextBox(),

                const Spacer(flex: 4),


                _buildLetsPlayButton(context),

                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildShiningTextBox() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRichText("No ", "Music"),
              const SizedBox(height: 5),
              _buildRichText("Just your ", "Voice"),
            ],
          ),
        ),


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


        Positioned(
          bottom:-34,
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


  Widget _buildRichText(String normal, String bold) {
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


  Widget _buildLetsPlayButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
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