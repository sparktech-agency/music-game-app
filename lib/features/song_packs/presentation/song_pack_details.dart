import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/song_packs/presentation/controllers/song_details_controller.dart';

class SongPackDetails extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  SongPackDetails({
    super.key,
    required this.categoryName,
    this.categoryImage = '',
  });

  final SongDetailsController controller = Get.put(SongDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D18),

      body: CustomScrollView(
        slivers: [
          /// HEADER
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: const Color(0xFF090D18),

            leading: IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF507BFF), Color(0xFF090D18)],
                      ),
                    ),
                  ),

                  Positioned(
                    top: -80,
                    left: -80,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .06),
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Column(
                      children: [
                        const Spacer(),

                        Hero(
                          tag: categoryName,

                          child: Container(
                            width: 150,
                            height: 150,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              image: DecorationImage(
                                image: AssetImage(categoryImage),

                                fit: BoxFit.cover,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 40,

                                  color: Colors.blue.withValues(alpha: .5),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          categoryName,

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: Colors.white,

                            fontSize: 32,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Play • Guess • Enjoy",

                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .7),
                          ),
                        ),

                        const SizedBox(height: 20),

                        _buildOwnedButton(),

                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// SEARCH
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Songs",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  _buildSearchBar(),
                ],
              ),
            ),
          ),

          /// LIST
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final song = controller.filteredSongs[index];

                return _buildSongTile(song);
              }, childCount: controller.filteredSongs.length),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }

  Widget _buildOwnedButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .10),

        borderRadius: BorderRadius.circular(30),

        border: Border.all(color: Colors.white24),
      ),

      child: const Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(Icons.check_circle, color: Color(0xFF1ED760)),

          SizedBox(width: 8),

          Text(
            "Owned",

            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: controller.searchSong,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        hintText: "Search songs",

        hintStyle: const TextStyle(color: Colors.white38),

        prefixIcon: const Icon(Icons.search, color: Colors.white54),

        filled: true,

        fillColor: Colors.white.withValues(alpha: .06),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSongTile(dynamic song) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              song.imageUrl,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 65,
                  height: 65,
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.music_note, color: Colors.white),
                );
              },
            ),
          ),

          const SizedBox(width: 14),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  song.title ?? 'Unknown Title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist ?? 'Unknown Artist',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  song.lyrics ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),


          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
