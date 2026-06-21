import 'package:music_game_app/features/spin_feature/domain/entities/get_song_entity.dart';

abstract class SpinFeatureRepository {

  Future<GetSongEntity> getSong({
    required String roundId,
    required int turnIndex,
    required String category,
  });
}