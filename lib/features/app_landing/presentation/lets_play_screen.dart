import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LetsPlayScreen extends StatelessWidget {
  const LetsPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A1B4B), // Deep blue/purple
                  Color(0xFF2339ED), // Bright blue
                ],
              ),
            ),
          ),

          // 2. Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Close Button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Get.back(),
                  ),
                ),

                const Spacer(flex: 2), // Space for top characters/images

                // 3. Shining Text Box (Pixel Perfect)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFF68FBFF).withValues(alpha: 0.8), // Cyan border
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF68FBFF).withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            children: [
                              TextSpan(text: "No "),
                              TextSpan(
                                text: "Music",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            children: [
                              TextSpan(text: "Just your "),
                              TextSpan(
                                text: "Voice",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),



                const Spacer(),

                // 5. Shining "Let's Play" Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),

                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF3FE7FE), // Light Cyan
                          Color(0xFF3D5AFE), // Royal Blue
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.mainSplash);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Let's Play",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
                        ],
                      ),
                    ),
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
