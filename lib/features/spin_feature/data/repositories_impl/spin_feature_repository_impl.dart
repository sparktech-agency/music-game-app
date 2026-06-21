import 'package:music_game_app/features/spin_feature/data/models/get_song_model.dart';
import 'package:music_game_app/features/spin_feature/data/sources/spin_feature_remote_source.dart';
import 'package:music_game_app/features/spin_feature/domain/entities/get_song_entity.dart';
import 'package:music_game_app/features/spin_feature/domain/repositories/spin_feature_repository.dart';

class SpinFeatureRepositoryImpl implements SpinFeatureRepository {
  final SpinFeatureRemoteSource _remoteSource;

  SpinFeatureRepositoryImpl(this._remoteSource);

  @override
  Future<GetSongEntity> getSong({
    required String roundId,
    required int turnIndex,
    required String category,
  }) async {

    final request = GetSongRequestModel(category: category);


    final response = await _remoteSource.getSong(
      roundId: roundId,
      turnIndex: turnIndex,
      request: request,
    );

    return response;
  }
}