import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {

    Timer.periodic(const Duration(milliseconds: 35), (timer) {
      if (_progress < 1.0) {
        setState(() {

          _progress += 0.06;
        });
      } else {
        timer.cancel();
      }
    });


    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Get.offNamed(AppRoutes.afterSplash);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
                ),
              ),
            ),
          ),


          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),


                const Text(
                  'Lyricraze',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontFamily: 'Orbitron',
                  ),
                ),

                const Spacer(flex: 3),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [

                        AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          curve: Curves.easeInOut,
                          width: screenWidth * _progress,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF42E8E0), Color(0xFF7BFFFA)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),


                        Center(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 100),
                            duration: const Duration(seconds: 3),
                            builder: (context, value, child) {
                              return Text(
                                '${value.toInt()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black45,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}