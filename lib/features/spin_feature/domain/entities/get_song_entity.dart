class GetSongEntity {
  final String category;
  final String title;
  final String artist;
  final List<String> lyrics;
  final String albumArt;
  final String audioPath;

  const GetSongEntity({
    required this.category,
    required this.title,
    required this.artist,
    required this.lyrics,
    required this.albumArt,
    required this.audioPath,
  });
}