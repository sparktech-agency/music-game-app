import 'package:music_game_app/features/profile/domain/entities/update_user_entity.dart';

abstract class ProfileRepository {

  Future<UpdateUserEntity> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String nickName,
    String? profilePath,
  });
}