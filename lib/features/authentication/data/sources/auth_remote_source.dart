

import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/authentication/data/models/register_model.dart';

class AuthRemoteSource extends BaseProvider {



  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await post(
        '/user/register',
        request.toJson(),
      );

      if (response.isOk && response.body != null) {
        return RegisterResponseModel.fromJson(response.body);
      } else {
        return RegisterResponseModel(
          success: false,
          message: response.body?['message'] ?? 'Registration failed',
        );
      }
    } catch (e) {
      return RegisterResponseModel(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}