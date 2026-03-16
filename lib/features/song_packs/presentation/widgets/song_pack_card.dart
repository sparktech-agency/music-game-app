import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/song_packs/data/song_pack.dart';
import 'package:music_game_app/features/song_packs/presentation/song_pack_details.dart';

class SongPackCard extends StatelessWidget {
  final SongPack pack;

  const SongPackCard({super.key, required this.pack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(
              () => SongPackDetails(
            categoryName: pack.title,
            categoryImage: pack.imageUrl,
          ),

        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: pack.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [

            // ==========================================
            // Left Side: Parallel Curved Borders & Image
            // ==========================================


            // 2. Inner Border
            Positioned(
              left: -100,
              top: -30,
              bottom: -30,
              width: 230,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ),

            // 3. Main Image
            Positioned(
              left: -90,
              top: -20,
              bottom: -20,
              width: 210,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(pack.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // ==========================================
            // Right Side: Content
            // ==========================================

            Positioned(
              left: 135,
              top: 15,
              right: 15,
              bottom: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pack.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pack.description,
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Song Count
                      Row(
                        children: [
                          const Icon(Icons.music_note, color: Colors.white54, size: 16),
                          const SizedBox(width: 4),
                          Text(
                              pack.songCount,
                              style: const TextStyle(color: Colors.white54, fontSize: 12)
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Bottom Row: Stars & Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
      ),
    );
  }

  Widget _buildOwnedButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1ED760),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
          SizedBox(width: 6),
          Text("Owned", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}