import 'package:music_game_app/features/authentication/data/models/forgot_password_model.dart';
import 'package:music_game_app/features/authentication/data/models/login_model.dart';
import 'package:music_game_app/features/authentication/data/models/register_model.dart';
import 'package:music_game_app/features/authentication/data/models/send_otp_model.dart';
import 'package:music_game_app/features/authentication/data/models/verify_otp_model.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_remote_source.dart';
import 'package:music_game_app/features/authentication/domain/entities/forgot_password_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/login_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/send_otp_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _remoteSource;
  final AuthLocalSource _localSource;

  AuthRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<RegisterEntity> register(String email, String password) async {

    final request = RegisterRequestModel(
      email: email,
      password: password,
    );

    final response = await _remoteSource.register(request);

    return response;
  }

  @override
  Future<SendOtpEntity> sendOtp(String email) async {
    final request = SendOtpRequestModel(email: email);

    final response = await _remoteSource.sendOtp(request);

    return response;
  }

  @override
  Future<VerifyOtpEntity> verifyOtp(String email, String otp) async {
    final request = VerifyOtpRequestModel(
      email: email,
      otp: otp,
    );

    final response = await _remoteSource.verifyOtp(request);
    return response;
  }

  @override
  Future<LoginEntity> login(String email, String password) async {
    final request = LoginRequestModel(
      email: email,
      password: password,
    );

    final response = await _remoteSource.login(request);

    await _localSource.saveAuthData(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      email: response.email,
      role: response.role,
      name: response.name,
      joinDate: response.createdAt.toIso8601String(),
    );

    return response;
  }

  @override
  Future<ForgotPasswordEntity> forgotPassword(String email) async {
    final request = ForgotPasswordRequestModel(email: email);

    final response = await _remoteSource.forgotPassword(request);

    return response;
  }
}