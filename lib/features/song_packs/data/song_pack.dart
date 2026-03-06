import 'dart:ui';

class SongPack {
  final String title;
  final String description;
  final String songCount;
  final List<Color> gradientColors;
  final String imageUrl;
  final bool isOwned;

  SongPack({
    required this.title,
    required this.description,
    required this.songCount,
    required this.gradientColors,
    required this.imageUrl,
    this.isOwned = true,
  });
}