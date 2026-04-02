import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SongPickLoadingPage extends StatefulWidget {
  const SongPickLoadingPage({super.key});

  @override
  State<SongPickLoadingPage> createState() => _SongPickLoadingPageState();
}

class _SongPickLoadingPageState extends State<SongPickLoadingPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {

      Get.offNamed(AppRoutes.selectedSong);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFF050A24),
      body: SafeArea(
        child: Stack(
          children: [

            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.3),
                  radius: 1.2,
                  colors: [
                    Color(0xFF0A1435),
                    Color(0xFF050A24),
                  ],
                ),
              ),
            ),


            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const PixelPerfect4DotLoader(),

                    const SizedBox(height: 50),


                    const Text(
                      "Your song is about to be selected",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 25),


                    const Text(
                      "We’ll randomly select a song based on the\nselected category. Get ready to sing! 🎶",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9EADDC),
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PixelPerfect4DotLoader extends StatefulWidget {
  const PixelPerfect4DotLoader({super.key});

  @override
  State<PixelPerfect4DotLoader> createState() => _PixelPerfect4DotLoaderState();
}

class _PixelPerfect4DotLoaderState extends State<PixelPerfect4DotLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 18.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(0),
            const SizedBox(width: spacing),
            _buildDot(1),
          ],
        ),
        const SizedBox(height: spacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(2),
            const SizedBox(width: spacing),
            _buildDot(3),
          ],
        ),
      ],
    );
  }

  Widget _buildDot(int index) {

    final delays = [0.0, 0.2, 0.4, 0.6];
    final animation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(delays[index], (delays[index] + 0.4).clamp(0.0, 1.0), curve: Curves.easeInOut),
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}