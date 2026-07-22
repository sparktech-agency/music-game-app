import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/exit_game/presentation/exit_game_dialogue.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/spin_wheel_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class CategoryItem {
  final String apiValue;
  final String displayName;
  final Color color;
  final bool isBlank;

  const CategoryItem(
    this.apiValue,
    this.displayName,
    this.color, {
    this.isBlank = false,
  });
}

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({super.key});

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  static const Color _defaultCyan = Color(0xFF2DD4E8);
  static const Color _defaultCyanDark = Color(0xFF18AABF);

  Color _resultColor = _defaultCyan;
  Color _resultColorDark = _defaultCyanDark;

  double _currentRotation = 0.0;
  double _targetRotation = 0.0;

  final SpinWheelController controller = Get.find<SpinWheelController>();

  // Compile-time constant list for memory efficiency
  static const List<CategoryItem> _items = [
    CategoryItem("", "SPIN", _defaultCyan, isBlank: false),

    CategoryItem("90s_hits", "1990's Hits", Color(0xFFFFB300)),
    CategoryItem("80s_hits", "1980's Hits", Color(0xFF2196F3)),
    CategoryItem("rock_ballads", "Rock Ballads", Color(0xFF455A64)),
    CategoryItem("2010s_hits", "2010's Hits", Color(0xFFE53935)),
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

    // Using final instead of const to avoid compilation error with .length
    final double itemAngle = (math.pi * 2) / _items.length;
    _currentRotation = -math.pi / 2 - itemAngle / 2;
    _targetRotation = _currentRotation;
  }

  void _spin() {
    if (_controller.isAnimating || controller.hasSpun.value) return;

    controller.isSpinning.value = true;

    final random = math.Random();
    final int randomIndex = 1 + random.nextInt(_items.length - 1);

    final double itemAngle = (math.pi * 2) / _items.length;
    final double segmentCenter = randomIndex * itemAngle + itemAngle / 2;
    const double spinOffset = math.pi * 2 * 8; // 8 full spins
    double finalAngle = -math.pi / 2 - segmentCenter;

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
      controller.updateResult(_items[randomIndex].displayName);
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
      body: SizedBox.expand(
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
                          onPressed: () {
                            Get.dialog(
                              ExitGameDialogue(),
                              barrierDismissible: false,
                            );
                          },
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
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 20),

                  // ===== Top Result Button =====
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
                  // RepaintBoundary blocks unneeded paint triggers from GIF/Text to GPU
                  RepaintBoundary(
                    child: Stack(
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

                        // Rotating Wheel (Optimized with cached CustomPainter child)
                        AnimatedBuilder(
                          animation: _animation,
                          child: CustomPaint(
                            size: const Size(314, 314),
                            painter: WheelPainter(_items),
                          ),
                          builder: (context, child) {
                            final double angle =
                                _currentRotation +
                                (_animation.value *
                                    (_targetRotation - _currentRotation));
                            return Transform.rotate(angle: angle, child: child);
                          },
                        ),

                        // Pointer at top
                        Positioned(
                          top: -16,
                          child: CustomPaint(
                            size: const Size(44, 54),
                            painter: const TrianglePainter(),
                          ),
                        ),

                        // Center play button
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
                  ),
                  const Spacer(),

                  // ===== Get Song Button =====
                  Obx(
                    () => GestureDetector(
                      onTap: controller.hasSpun.value
                          ? () {
                              Get.offNamed(
                                AppRoutes.songPickLoading,
                                arguments: controller.resultText.value,
                              );
                            }
                          : null,
                      child: Container(
                        width: 300,
                        height: 58,
                        margin: const EdgeInsets.only(bottom: 34),
                        decoration: BoxDecoration(
                          gradient: controller.hasSpun.value
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF54EAF2),
                                    Color(0xFF3867FF),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )
                              : null,
                          color: controller.hasSpun.value
                              ? null
                              : Colors.black26,
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

// ===== Optimized Wheel Painter =====
class WheelPainter extends CustomPainter {
  final List<CategoryItem> items;

  // Cached objects to avoid instantiation overhead inside the paint loop
  final List<TextPainter?> _textPainters = [];
  final Paint _fillPaint = Paint()..style = PaintingStyle.fill;
  final Paint _strokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.8;

  WheelPainter(this.items) {
    // Heavy TextPainter instantiation is done once here
    for (var item in items) {
      if (item.isBlank) {
        _textPainters.add(null);
        continue;
      }

      final textPainter = TextPainter(
        text: TextSpan(
          text: item.displayName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '...',
      );
      _textPainters.add(textPainter);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);
    final double arcAngle = (2 * math.pi) / items.length;
    final Rect wheelRect = Rect.fromCircle(center: center, radius: radius);

    final double maxTextWidth = radius * 0.66;
    final double startOffset = radius * 0.30;

    for (int i = 0; i < items.length; i++) {
      final double currentArcStart = i * arcAngle;

      // Slice fill
      _fillPaint.color = items[i].color;
      canvas.drawArc(wheelRect, currentArcStart, arcAngle, true, _fillPaint);

      // Divider lines
      _strokePaint.color = Colors.white.withValues(alpha: 0.3);
      canvas.drawArc(wheelRect, currentArcStart, arcAngle, true, _strokePaint);

      if (items[i].isBlank) continue;

      final textPainter = _textPainters[i];
      if (textPainter != null) {
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(currentArcStart + (arcAngle / 2));

        // Layout execution runs instantly since TextSpan allocation is already cached
        textPainter.layout(maxWidth: maxTextWidth);
        textPainter.paint(canvas, Offset(startOffset, -textPainter.height / 2));

        canvas.restore();
      }
    }

    // Center white circle
    canvas.drawCircle(center, radius * 0.148, _fillPaint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) =>
      items != oldDelegate.items;
}

// ===== Triangle Pointer =====
class TrianglePainter extends CustomPainter {
  const TrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = Colors.black38
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final Path path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    final Path shadowPath = Path()
      ..moveTo(size.width / 2, size.height + 3)
      ..lineTo(1, 1)
      ..lineTo(size.width - 1, 1)
      ..close();

    canvas.drawPath(shadowPath, shadowPaint);
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
