import '../entities/get_user_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserUseCase {
  final ProfileRepository _repository;

  GetUserUseCase(this._repository);

  Future<GetUserEntity> call({required String userId}) {
    return _repository.getUser(userId: userId);
  }
}