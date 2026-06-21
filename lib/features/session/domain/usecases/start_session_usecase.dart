import 'package:music_game_app/features/session/domain/entities/start_session_entity.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';

class StartSessionUseCase {
  final SessionRepository _repository;

  StartSessionUseCase(this._repository);

  Future<StartSessionEntity> call(String sessionId) {
    return _repository.startSession(sessionId);
  }
}