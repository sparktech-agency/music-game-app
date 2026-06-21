import 'package:music_game_app/features/session/domain/entities/create_round_entity.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';

class CreateRoundUseCase {
  final SessionRepository _repository;

  CreateRoundUseCase(this._repository);

  Future<CreateRoundEntity> call({
    required String sessionId,
    required int roundNumber,
  }) {
    return _repository.createRound(
      sessionId: sessionId,
      roundNumber: roundNumber,
    );
  }
}