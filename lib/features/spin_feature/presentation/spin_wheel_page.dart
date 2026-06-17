import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/spin_wheel_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class CategoryItem {
  final String label;
  final IconData icon;
  final Color color;
  final bool isBlank;

  CategoryItem(this.label, this.icon, this.color, {this.isBlank = false});
}

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({super.key});

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const Color _defaultCyan = Color(0xFF2DD4E8);
  static const Color _defaultCyanDark = Color(0xFF18AABF);

  Color _resultColor = _defaultCyan;
  Color _resultColorDark = _defaultCyanDark;

  double _currentRotation = 0.0;
  double _targetRotation = 0.0;

  final SpinWheelController controller = Get.put(SpinWheelController());




  final List<CategoryItem> _items = [
    CategoryItem("spin", Icons.music_note, _defaultCyan, isBlank: true),
    CategoryItem("Pop", Icons.music_note, Color(0xFFFFB300)),
    CategoryItem("Hiphop", Icons.layers, Color(0xFF2196F3)),
    CategoryItem("TB", Icons.album, Color(0xFF455A64)),
    CategoryItem("Indie", Icons.face, Color(0xFFE53935)),
    CategoryItem("EDM", Icons.public, Color(0xFF3F51B5)),
    CategoryItem("Acoustic", Icons.music_video, Color(0xFF4CAF50)),
    CategoryItem("R&B", Icons.emoji_emotions, Color(0xFF1A237E)),
    CategoryItem("Rock", Icons.vibration, Color(0xFF90A4AE)),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    final double itemAngle = (math.pi * 2) / _items.length;
    _currentRotation = -math.pi / 2 - itemAngle / 2;
    _targetRotation = _currentRotation;
  }

  void _spin() {
    if (_controller.isAnimating || controller.hasSpun.value) return;

    controller.isSpinning.value = true;

    final random = math.Random();

    int randomIndex = 1 + random.nextInt(_items.length - 1);

    final double itemAngle = (math.pi * 2) / _items.length;
    final double segmentCenter = randomIndex * itemAngle + itemAngle / 2;
    final double spinOffset = math.pi * 2 * 8; // 8 full spins
    double finalAngle = -math.pi / 2 - segmentCenter;

    // Normalize to positive
    finalAngle = finalAngle % (math.pi * 2);
    if (finalAngle < 0) finalAngle += math.pi * 2;

    _targetRotation =
        _currentRotation +
        spinOffset +
        finalAngle -
        (_currentRotation % (math.pi * 2));

    _controller.forward(from: 0).then((_) {
      setState(() {
        _currentRotation = _targetRotation;
        _resultColor = _items[randomIndex].color;
        _resultColorDark = _darken(_items[randomIndex].color, 0.22);
      });
      controller.updateResult(_items[randomIndex].label);
    });
  }

  Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/music_notes.gif',
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF1A0B2E).withValues(alpha: 0.9),
                      const Color(0xFF090415).withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 4),

                  // AppBar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        const Text(
                          "Spin to select song category",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Spin to select\nsong category",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Let's start",
                    style: TextStyle(color: Colors.white60, fontSize: 15),
                  ),
                  const SizedBox(height: 20),

                  // ===== Top Result Button — changes color with selected slice =====
                  Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 52,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_resultColor, _resultColorDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _resultColor.withValues(alpha: 0.5),
                            blurRadius: 22,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        controller.resultText.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ===== Wheel =====
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Outer glow ring
                      Container(
                        width: 336,
                        height: 336,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF3B5CFF,
                              ).withValues(alpha: 0.4),
                              blurRadius: 32,
                              spreadRadius: 8,
                            ),
                          ],
                          border: Border.all(
                            color: const Color(
                              0xFF4A6FFF,
                            ).withValues(alpha: 0.75),
                            width: 10,
                          ),
                        ),
                      ),

                      // Rotating Wheel
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          double angle =
                              _currentRotation +
                              (_animation.value *
                                  (_targetRotation - _currentRotation));
                          return Transform.rotate(
                            angle: angle,
                            child: CustomPaint(
                              size: const Size(314, 314),
                              painter: WheelPainter(_items),
                            ),
                          );
                        },
                      ),

                      // Pointer at top
                      Positioned(
                        top: -16,
                        child: CustomPaint(
                          size: const Size(44, 54),
                          painter: TrianglePainter(),
                        ),
                      ),

                      // Center play button — color follows result
                      GestureDetector(
                        onTap: _spin,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: _resultColor, width: 5),
                            boxShadow: [
                              BoxShadow(
                                color: _resultColor.withValues(alpha: 0.55),
                                blurRadius: 18,
                                spreadRadius: 2,
                              ),
                              const BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Obx(
                            () => Icon(
                              controller.hasSpun.value
                                  ? Icons.check_rounded
                                  : Icons.play_arrow_rounded,
                              color: _resultColor,
                              size: 46,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ===== Get Song Button — CONSTANT, never changes =====
                  Obx(
                    () => GestureDetector(
                      onTap: controller.hasSpun.value
                          ? () {
                              Get.offNamed(AppRoutes.songPickLoading);
                            }
                          : null,
                      child: Container(
                        width: 300,
                        height: 58,
                        margin: const EdgeInsets.only(bottom: 34),
                        decoration: BoxDecoration(
                          color: controller.hasSpun.value
                              ? const Color(0xFF3B5CFF)
                              : const Color(0xFF161B2E),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            "Get Song",
                            style: TextStyle(
                              color: controller.hasSpun.value
                                  ? Colors.white
                                  : Colors.white24,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ===== Wheel Painter =====
class WheelPainter extends CustomPainter {
  final List<CategoryItem> items;

  WheelPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(radius, radius);
    double arcAngle = (2 * math.pi) / items.length;

    for (int i = 0; i < items.length; i++) {
      // Slice fill
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * arcAngle,
        arcAngle,
        true,
        Paint()
          ..color = items[i].color
          ..style = PaintingStyle.fill,
      );

      // White divider lines
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * arcAngle,
        arcAngle,
        true,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8,
      );

      // Skip label/icon for blank slice
      if (items[i].isBlank) continue;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * arcAngle + (arcAngle / 2));

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i].label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(radius * 0.52, -textPainter.height / 2));

      // Icon
      final iconPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(items[i].icon.codePoint),
          style: TextStyle(
            fontSize: 20,
            fontFamily: items[i].icon.fontFamily,
            color: Colors.white,
            shadows: const [Shadow(color: Colors.black45, blurRadius: 4)],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      iconPainter.paint(canvas, Offset(radius * 0.27, -10));

      canvas.restore();
    }

    // Center white circle — covered by center button widget
    canvas.drawCircle(center, radius * 0.148, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ===== Triangle Pointer =====
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Drop shadow
    canvas.drawPath(
      Path()
        ..moveTo(size.width / 2, size.height + 3)
        ..lineTo(1, 1)
        ..lineTo(size.width - 1, 1)
        ..close(),
      Paint()
        ..color = Colors.black38
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, Paint()..color = const Color(0xFFE53935));
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFFFD54F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
