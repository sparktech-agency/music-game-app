import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class AfterSplash extends StatelessWidget {
  const AfterSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF003399),
                  Color(0xFF000000),
                ],
              ),
            ),
          ),


          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    'Hi John!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome to',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Lyricraze',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const Spacer(),


                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      // image: DecorationImage(image: AssetImage('assets/character.png')),
                    ),
                    child: const Center(
                      child: Icon(Icons.emoji_emotions, size: 100, color: Colors.blueAccent),
                    ),
                  ),

                  const Spacer(),


                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.roundSelection);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF39E3FE),
                            Color(0xFF2C6BFF),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}