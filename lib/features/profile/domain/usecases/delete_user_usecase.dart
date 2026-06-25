import 'package:music_game_app/features/profile/domain/entities/delete_user_entity.dart';
import 'package:music_game_app/features/profile/domain/repositories/profile_repository.dart';

class DeleteUserUseCase {
  final ProfileRepository _repository;

  DeleteUserUseCase(this._repository);

  Future<DeleteUserEntity> call({required String userId}) {
    return _repository.deleteUser(userId: userId);
  }
}