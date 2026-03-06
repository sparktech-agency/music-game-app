import 'dart:math' as math;
import 'package:flutter/material.dart';

class CategoryItem {
  final String label;
  final IconData icon;
  final Color color;

  CategoryItem(this.label, this.icon, this.color);
}

class SpinWheel extends StatefulWidget {
  SpinWheel({super.key});
  @override
  _PixelPerfectSpinWheelState createState() => _PixelPerfectSpinWheelState();
}

class _PixelPerfectSpinWheelState extends State<SpinWheel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentRotation = 0.0;

  final List<CategoryItem> _items = [
    CategoryItem("Pop", Icons.music_note, Color(0xFFFFB300)),
    CategoryItem("Hiphop", Icons.layers, Color(0xFF2196F3)),
    CategoryItem("TB", Icons.album, Color(0xFF455A64)),
    CategoryItem("Indie", Icons.face, Color(0xFFE53935)),
    CategoryItem("EDM", Icons.public, Color(0xFF3F51B5)),
    CategoryItem("Acoustic", Icons.music_video, Color(0xFF4CAF50)),
    CategoryItem("Pop", Icons.mic, Color(0xFFFFCA28)),
    CategoryItem("R&B", Icons.emoji_emotions, Color(0xFF1A237E)),
    CategoryItem("Rock", Icons.vibration, Color(0xFF90A4AE)),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _spin() {
    if (_controller.isAnimating) return;


    double randomRotation = (math.pi * 2 * 5) + (math.Random().nextDouble() * math.pi * 2);

    _controller.forward(from: 0).then((_) {
      setState(() {
        _currentRotation += randomRotation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A0B2E), Color(0xFF090415)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Spin to select\nsong category",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1.2),
          ),
          SizedBox(height: 10),
          Text("Let's start", style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 30),

          // Spin Button (Top)
          GestureDetector(
            onTap: _spin,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF53EBF3), Color(0xFF2BB7DA)]),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(0.3), blurRadius: 15)],
              ),
              child: Text("spin", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
            ),
          ),

          SizedBox(height: 40),

          // The Wheel Stack
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glow/Border
              Container(
                width: 315,
                height: 315,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 8),
                ),
              ),

              // Animated Wheel
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _currentRotation + (_animation.value * (math.pi * 15)),
                    child: CustomPaint(
                      size: Size(300, 300),
                      painter: WheelPainter(_items),
                    ),
                  );
                },
              ),

              // Top Red Indicator (Fixed)
              Positioned(
                top: -5,
                child: Container(
                  width: 40,
                  height: 45,
                  child: CustomPaint(painter: TrianglePainter()),
                ),
              ),

              // Center Play Button
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                  border: Border.all(color: Colors.orangeAccent, width: 4),
                ),
                child: Icon(Icons.play_arrow, color: Colors.orange, size: 40),
              ),
            ],
          ),

          SizedBox(height: 50),

          // Bottom Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
            decoration: BoxDecoration(
              color: Color(0xFF1E3A8A),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text("Get Song", style: TextStyle(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<CategoryItem> items;
  WheelPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(radius, radius);
    double arcAngle = (2 * math.pi) / items.length;

    for (int i = 0; i < items.length; i++) {
      // Draw Slice
      final paint = Paint()..color = items[i].color..style = PaintingStyle.fill;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), i * arcAngle, arcAngle, true, paint);

      // Draw Slice Border
      final linePaint = Paint()..color = Colors.white.withOpacity(0.3)..style = PaintingStyle.stroke..strokeWidth = 1.5;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), i * arcAngle, arcAngle, true, linePaint);

      // Draw Text and Icon
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * arcAngle + (arcAngle / 2));

      // Draw Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i].label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )..layout();


      textPainter.paint(canvas, Offset(radius * 0.55, -textPainter.height / 2));

      // Draw Icon
      TextPainter(
        text: TextSpan(
          text: String.fromCharCode(items[i].icon.codePoint),
          style: TextStyle(fontSize: 22, fontFamily: items[i].icon.fontFamily, color: Colors.white.withOpacity(0.8)),
        ),
        textDirection: TextDirection.ltr,
      )..layout()..paint(canvas, Offset(radius * 0.3, -11));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.redAccent);
    canvas.drawPath(path, Paint()..color = Colors.orange..style = PaintingStyle.stroke..strokeWidth = 3);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}