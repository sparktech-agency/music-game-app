

import 'package:flutter/material.dart';
import 'package:music_game_app/features/song_packs/data/song_pack.dart';

class SongPackCard extends StatelessWidget {
  final SongPack pack;

  const SongPackCard({super.key, required this.pack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: pack.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [

          Positioned(
            left: -10,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: CustomImageClipper(),
              child: Container(
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(pack.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 130, top: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  pack.title,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  pack.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white54, size: 16),
                    Text(pack.songCount, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 24),
                    _buildOwnedButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnedButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2ecc71),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
          SizedBox(width: 5),
          Text("Owned", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}


class CustomImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.7, size.height);
    path.quadraticBezierTo(size.width, size.height / 2, size.width * 0.7, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}