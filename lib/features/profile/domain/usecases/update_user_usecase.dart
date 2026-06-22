import 'package:music_game_app/features/profile/domain/entities/update_user_entity.dart';
import 'package:music_game_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserUseCase {
  final ProfileRepository _repository;

  UpdateUserUseCase(this._repository);

  Future<UpdateUserEntity> call({
    required String userId,
    required String firstName,
    required String lastName,
    required String nickName,
    String? profilePath,
  }) {
    return _repository.updateUser(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      nickName: nickName,
      profilePath: profilePath,
    );
  }
}