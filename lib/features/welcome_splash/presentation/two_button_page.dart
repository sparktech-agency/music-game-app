import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TwoButtonPage extends StatelessWidget {
  const TwoButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/images/loading_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Start Singing Button
                    GamifiedButton(
                      text: 'Start Singing',
                      gradientColors: const [Color(0xFF39E3FE), Color(0xFF2C6BFF)],
                      shadowColor: const Color(0xFF1A44B3),
                      onTap: () {
                        Get.toNamed(AppRoutes.appLanding);
                      },
                    ),

                    const SizedBox(height: 20),

                    //Tutorial Button
                    GamifiedButton(
                      text: 'Tutorial',
                      gradientColors: const [Color(0xFF9CA3AF), Color(0xFF4B5563)],
                      shadowColor: const Color(0xFF1F2937),
                      onTap: () {
                        // Get.toNamed(AppRoutes.tutorial);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class GamifiedButton extends StatefulWidget {
  final String text;
  final List<Color> gradientColors;
  final Color shadowColor;
  final VoidCallback onTap;

  const GamifiedButton({
    super.key,
    required this.text,
    required this.gradientColors,
    required this.shadowColor,
    required this.onTap,
  });

  @override
  State<GamifiedButton> createState() => _GamifiedButtonState();
}

class _GamifiedButtonState extends State<GamifiedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.only(top: _isPressed ? 6 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: widget.gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),

          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: _isPressed
              ? []
              : [

            BoxShadow(
              color: widget.shadowColor,
              offset: const Offset(0, 6),
              blurRadius: 0,
            ),

            BoxShadow(
              color: widget.gradientColors[1].withValues(alpha: 0.4),
              offset: const Offset(0, 10),
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              shadows: [

                Shadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}