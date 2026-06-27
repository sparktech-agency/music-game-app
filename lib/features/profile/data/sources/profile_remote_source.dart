import 'dart:io';
import 'package:get/get.dart';
import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/data/models/change_password_model.dart';
import 'package:music_game_app/features/profile/data/models/delete_user_model.dart';
import 'package:music_game_app/features/profile/data/models/update_user_model.dart';

class ProfileRemoteSource extends BaseProvider {
  Future<UpdateUserResponseModel> updateUser({
    required String userId,
    required UpdateUserRequestModel request,
  }) async {
    try {
      final accessToken = AuthLocalSourceImpl().getAccessToken();

      final Map<String, dynamic> fields = {'data': request.toDataJsonString()};

      if (request.profilePath != null && request.profilePath!.isNotEmpty) {
        fields['profile'] = MultipartFile(
          File(request.profilePath!),
          filename: request.profilePath!.split('/').last,
        );
      }

      final formData = FormData(fields);

      final response = await patch(
        '/user/$userId',
        formData,
        headers: {'Authorization': '$accessToken'},
      );

      if (response.isOk && response.body != null) {
        return UpdateUserResponseModel.fromJson(response.body);
      } else {
        final errorMessage =
            response.body?['message'] ?? 'Failed to update profile';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ChangePasswordResponseModel> changePassword(
    ChangePasswordRequestModel request,
  ) async {
    try {
      final accessToken = AuthLocalSourceImpl().getAccessToken();

      final response = await post(
        '/auth/change-password',

        request.toJson(),

          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          }
      );

      if (response.isOk && response.body != null) {
        return ChangePasswordResponseModel.fromJson(response.body);
      } else {
        final errorMessage =
            response.body?['message'] ?? 'Failed to change password';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DeleteUserResponseModel> deleteUser({required String userId}) async {
    try {
      final response = await delete('/user/$userId');

      if (response.isOk && response.body != null) {
        return DeleteUserResponseModel.fromJson(response.body);
      } else {
        final errorMessage =
            response.body?['message'] ?? 'Failed to delete user';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
