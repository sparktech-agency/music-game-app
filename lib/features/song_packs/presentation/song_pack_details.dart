import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/song_packs/presentation/controllers/song_details_controller.dart';

class SongPackDetails extends StatelessWidget {

  final String categoryName;
  final String categoryImage;

  SongPackDetails({
    super.key,
    required this.categoryName,
    this.categoryImage = 'https://via.placeholder.com/150',
  });


  final SongDetailsController controller = Get.put(SongDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E1B),
      body: CustomScrollView(
        slivers: [
          // Top Header Section
          SliverToBoxAdapter(
            child: Container(
              height: 380,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4A89FF),
                    Color(0xFF0B0E1B)
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        onPressed: () => Get.back(),
                      ),
                    ),

                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white24,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(categoryImage),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      categoryName,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Popular hits many players will recognize",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    _buildOwnedButton(),
                  ],
                ),
              ),
            ),
          ),

          // Search Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Songs under this song category",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                ],
              ),
            ),
          ),

          // Optimized List using Obx
          Obx(() => SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final song = controller.filteredSongs[index];
                  return _buildSongTile(song);
                },
                childCount: controller.filteredSongs.length,
              ),
            ),
          )),
        ],
      ),
    );
  }


  Widget _buildOwnedButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.greenAccent.withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
          elevation: 0,
        ),
        onPressed: () {},
        icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
        label: const Text(
          "Owned",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: controller.searchSong,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search a song...",
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1A1F36),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSongTile(var song) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(song.imageUrl, width: 55, height: 55, fit: BoxFit.cover),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${song.title} ",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            ),
            TextSpan(
              text: "• ${song.artist}",
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            const Icon(Icons.mic_none_rounded, size: 14, color: Colors.white38),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                song.lyrics,
                style: const TextStyle(color: Colors.white38, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}