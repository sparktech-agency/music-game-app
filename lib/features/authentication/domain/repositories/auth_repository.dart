import 'package:music_game_app/features/authentication/domain/entities/login_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/send_otp_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/verify_otp_entity.dart';

abstract class AuthRepository {

  Future<RegisterEntity> register(String email, String password);
  Future<LoginEntity> login(String email, String password);
  Future<SendOtpEntity> sendOtp(String email);
  Future<VerifyOtpEntity> verifyOtp(String email, String otp);

}