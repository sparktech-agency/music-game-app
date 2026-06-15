import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/app_bar_with_logo.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LetsSingScreen extends StatelessWidget {
  const LetsSingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthLocalSource localSource = Get.find<AuthLocalSource>();
    final String userName = localSource.getName() ?? 'User';






    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBarWithLogo(userName: userName, onTap: (){Get.toNamed(AppRoutes.profileScreen);}),


      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lets_sing_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/lets_sing.png',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),

          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: _buildStartSingingButton(
              onTap: () {
                Get.toNamed(AppRoutes.letsPlayScreen);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartSingingButton({required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),

      height: 85,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),

          width: 3,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withValues(alpha: 0.5),

            blurRadius: 15,

            offset: const Offset(0, 4),
          ),
        ],

        gradient: const LinearGradient(
          colors: [Color(0xFF43D5FF), Color(0xFF28C2FF)],
        ),
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(25),

          // Ripple effect border radius
          onTap: onTap,

          child: Stack(
            children: [
              Positioned(
                left: 12,

                top: 12,

                child: Icon(
                  Icons.auto_awesome,

                  color: Colors.white.withValues(alpha: 0.7),

                  size: 24,
                ),
              ),

              Positioned(
                right: 12,
                bottom: 12,
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 24,
                ),
              ),

              const Center(
                child: Text(
                  "Let's Start Singing!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
