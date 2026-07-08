import 'package:music_game_app/features/spin_feature/domain/entities/get_song_entity.dart';

//===== Request Model =====

class GetSongRequestModel {
  final String category;

  const GetSongRequestModel({
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
    };
  }
}

//===== Response Model =====
class GetSongResponseModel extends GetSongEntity {
  const GetSongResponseModel({
    required super.category,
    required super.title,
    required super.artist,
    required super.lyrics,
    required super.albumArt,
    required super.audioPath,
  });

  factory GetSongResponseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;
    final songData = data['song'] as Map<String, dynamic>;

    return GetSongResponseModel(
      category: songData['category'] as String,
      title: songData['title'] as String,
      artist: songData['artist'] as String,

      lyrics: List<String>.from(songData['lyrics'] as List<dynamic>),
      albumArt: songData['albumArt'] as String,
      audioPath: songData['audioPath'] as String,
    );
  }
}