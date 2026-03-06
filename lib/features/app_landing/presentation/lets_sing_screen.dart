import 'package:flutter/material.dart';
import 'package:music_game_app/core/widgets/app_bar_with_logo.dart';

class LetsSingScreen extends StatelessWidget {
  const LetsSingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBarWithLogo(userName: "doe john"),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A0B3D),
              Color(0xFF3282B8),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            _buildStartSingingButton(),
            const SizedBox(height: 120),

          ],
        ),
      ),
    );
  }


  Widget _buildStartSingingButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 3),
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
      child: Stack(
        children: [

          Positioned(
              left: 12,
              top: 12,
              child: Icon(Icons.auto_awesome, color: Colors.white.withValues(alpha: 0.7), size: 24)
          ),
          Positioned(
              right: 12,
              bottom: 12,
              child: Icon(Icons.auto_awesome, color: Colors.white.withValues(alpha: 0.7), size: 24)
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
    );
  }

}