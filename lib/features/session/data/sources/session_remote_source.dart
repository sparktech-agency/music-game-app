import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/session/data/models/create_session_model.dart';

class SessionRemoteSource extends BaseProvider {



  Future<CreateSessionResponseModel> createSession(CreateSessionRequestModel request) async {
    try {
      final accessToken = AuthLocalSourceImpl().getAccessToken();
      final response = await post(
        '/session/create',
        request.toJson(),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.isOk && response.body != null) {
        return CreateSessionResponseModel.fromJson(response.body);
      } else {
        final errorMessage = response.body?['message'] ?? 'Failed to create session';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}