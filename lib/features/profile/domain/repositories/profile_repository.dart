import 'package:music_game_app/features/profile/domain/entities/change_password_entity.dart';
import 'package:music_game_app/features/profile/domain/entities/delete_user_entity.dart';
import 'package:music_game_app/features/profile/domain/entities/get_user_entity.dart';
import 'package:music_game_app/features/profile/domain/entities/update_user_entity.dart';

abstract class ProfileRepository {

  Future<UpdateUserEntity> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String nickName,
    String? profilePath,
  });

  Future<DeleteUserEntity> deleteUser({required String userId});


  Future<ChangePasswordEntity> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<GetUserEntity> getUser({required String userId});

}