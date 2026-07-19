import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(const AssetImage('assets/images/loading_bg.png'), context);
    precacheImage(const AssetImage('assets/images/loading_cartoon.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/loading_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Cartoon Mascot
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/loading_cartoon.png',
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height * 0.65,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 80,
                    height: 80,
                  ),
                ),
                const Spacer(),


                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  child: _ProgressBar(
                    onComplete: () {
                      if (mounted) {
                        Get.offNamed(AppRoutes.roundSelection);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _ProgressBar extends StatefulWidget {
  final VoidCallback onComplete;

  const _ProgressBar({required this.onComplete});

  @override
  State<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<_ProgressBar> {
  double _progress = 0.0;
  Timer? _periodicTimer;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {

    _periodicTimer = Timer.periodic(const Duration(milliseconds: 35), (timer) {
      if (_progress < 1.0) {
        if (mounted) {
          setState(() {
            _progress += 0.01;
          });
        }
      } else {
        timer.cancel();
      }
    });

    _navigationTimer = Timer(const Duration(milliseconds: 3500), () {
      widget.onComplete();
    });
  }

  @override
  void dispose() {

    _periodicTimer?.cancel();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Stack(
        children: [
          // Progress Bar Animation
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: (screenWidth - 60) * _progress,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF42E8E0), Color(0xFF7BFFFA)],
              ),
              borderRadius: BorderRadius.circular(35),
            ),
          ),

          // Percentage Text
          Center(
            child: Text(
              '${(_progress * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}