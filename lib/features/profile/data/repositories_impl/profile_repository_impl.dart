import 'package:music_game_app/features/profile/data/models/change_password_model.dart';
import 'package:music_game_app/features/profile/data/models/update_user_model.dart';
import 'package:music_game_app/features/profile/data/sources/profile_remote_source.dart';
import 'package:music_game_app/features/profile/domain/entities/change_password_entity.dart';
import 'package:music_game_app/features/profile/domain/entities/delete_user_entity.dart';
import 'package:music_game_app/features/profile/domain/entities/update_user_entity.dart';
import 'package:music_game_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteSource _remoteSource;

  ProfileRepositoryImpl(this._remoteSource);

  @override
  Future<UpdateUserEntity> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String nickName,
    String? profilePath,
  }) async {

    final request = UpdateUserRequestModel(
      firstName: firstName,
      lastName: lastName,
      nickName: nickName,
      profilePath: profilePath,
    );


    final response = await _remoteSource.updateUser(
      userId: userId,
      request: request,
    );

    return response;
  }


  @override
  Future<ChangePasswordEntity> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {

    final request = ChangePasswordRequestModel(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    final response = await _remoteSource.changePassword(request);

    return response;
  }


  @override
  Future<DeleteUserEntity> deleteUser({required String userId}) async {
    final response = await _remoteSource.deleteUser(userId: userId);
    return response;
  }
}