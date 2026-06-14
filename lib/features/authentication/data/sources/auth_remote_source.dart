import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/authentication/data/models/login_model.dart';
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
        final errorMessage = response.body?['message'] ?? 'Registration failed';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await post(
        '/auth/login',
        request.toJson(),
      );

      if (response.isOk && response.body != null) {
        return LoginResponseModel.fromJson(response.body);
      } else {
        final errorMessage = response.body?['message'] ?? 'Login failed';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}