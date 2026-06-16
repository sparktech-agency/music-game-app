import 'package:music_game_app/features/session/domain/entities/create_session_entity.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';

class CreateSessionUseCase {
  final SessionRepository _repository;

  CreateSessionUseCase(this._repository);

  Future<CreateSessionEntity> call({
    required int totalRounds,
    required String preferredMusicSource,
    required List<Map<String, dynamic>> teams,
  }) {
    return _repository.createSession(
      totalRounds: totalRounds,
      preferredMusicSource: preferredMusicSource,
      teams: teams,
    );
  }
}