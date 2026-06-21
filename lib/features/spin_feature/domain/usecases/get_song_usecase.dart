import 'package:music_game_app/features/spin_feature/domain/entities/get_song_entity.dart';
import 'package:music_game_app/features/spin_feature/domain/repositories/spin_feature_repository.dart';

class GetSongUseCase {
  final SpinFeatureRepository _repository;

  GetSongUseCase(this._repository);

  Future<GetSongEntity> call({
    required String roundId,
    required int turnIndex,
    required String category,
  }) {
    return _repository.getSong(
      roundId: roundId,
      turnIndex: turnIndex,
      category: category,
    );
  }
}