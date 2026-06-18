import 'package:get_storage/get_storage.dart';

abstract class AuthLocalSource {
  //save Login Auth Data
  Future<void> saveAuthData({
    required String id,
    required String accessToken,
    required String refreshToken,
    required String email,
    required String role,
    String? name, // optional name
    required String joinDate,
  });

  //save Registration Auth Data
  Future<void> registerAuthData({
    required String id,
    required String email,
    String? name, // optional name
    required String joinDate,
  });

  String? getUserId();
  String? getAccessToken();
  String? getRefreshToken();
  String? getEmail();
  String? getRole();
  String? getName();
  String? getJoinDate();
  Future<void> clearAuthData();
}








//Implementation
class AuthLocalSourceImpl implements AuthLocalSource {
  final GetStorage _authStorage = GetStorage();

  @override
  Future<void> saveAuthData({
    required String id,
    required String accessToken,
    required String refreshToken,
    required String email,
    required String role,
    String? name,
    required String joinDate,
  }) async {
    await _authStorage.write('_id', id);
    await _authStorage.write('access_token', accessToken);
    await _authStorage.write('refresh_token', refreshToken);
    await _authStorage.write('role', role);
    await _authStorage.write('name', name ?? 'user');
    await _authStorage.write('email', email);
    await _authStorage.write('join_date', joinDate);
  }


  @override
  Future<void> registerAuthData({
    required String id,
    required String email,
    String? name,
    required String joinDate,
  }) async {

    await _authStorage.write('_id', id);
    await _authStorage.write('email', email);
    await _authStorage.write('name', name ?? 'user');
    await _authStorage.write('join_date', joinDate);

  }








  @override
  String? getUserId() => _authStorage.read<String>('_id');

  @override
  String? getAccessToken() => _authStorage.read<String>('access_token');

  @override
  String? getRefreshToken() => _authStorage.read<String>('refresh_token');

  @override
  String? getEmail() => _authStorage.read<String>('email');

  @override
  String? getRole() => _authStorage.read<String>('role');

  @override
  String? getName() => _authStorage.read<String>('name');

  @override
  String? getJoinDate() => _authStorage.read<String>('join_date');

  @override
  Future<void> clearAuthData() async {
    await _authStorage.remove('_id');
    await _authStorage.remove('access_token');
    await _authStorage.remove('refresh_token');
    await _authStorage.remove('email');
    await _authStorage.remove('role');
    await _authStorage.remove('name');
    await _authStorage.remove('join_date');
  }
}