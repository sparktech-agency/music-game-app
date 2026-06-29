import 'package:get_storage/get_storage.dart';

abstract class AuthLocalSource {
  //Login Data Save
  Future<void> saveAuthData({
    required String id,
    required String accessToken,
    required String refreshToken,
    required String email,
    String? firstName,
    String? lastName,
    String? nickName,
    String? profilePhoto,
    required String joinDate,
  });

  // Registration Data Save
  Future<void> registerAuthData({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? nickName,
    required String joinDate,
  });

  // update Profile Local Data
  Future<void> updateProfileLocalData({
    required String firstName,
    required String lastName,
    required String nickName,
    String? profilePhoto,
  });

  String? getUserId();

  String? getAccessToken();

  String? getRefreshToken();

  String? getEmail();

  String? getFirstName();

  String? getLastName();

  String? getNickName();

  String? getProfilePhoto();

  String? getJoinDate();

  Future<void> clearAuthData();
}

//================== Implementation ==================
class AuthLocalSourceImpl implements AuthLocalSource {
  final GetStorage _authStorage = GetStorage();

  @override
  Future<void> saveAuthData({
    required String id,
    required String accessToken,
    required String refreshToken,
    required String email,
    String? firstName,
    String? lastName,
    String? nickName,
    String? profilePhoto,
    required String joinDate,
  }) async {
    await _authStorage.write('_id', id);
    await _authStorage.write('access_token', accessToken);
    await _authStorage.write('refresh_token', refreshToken);
    await _authStorage.write('first_name', firstName ?? '');
    await _authStorage.write('last_name', lastName ?? '');
    await _authStorage.write('nick_name', nickName ?? 'user');
    await _authStorage.write('profile_photo', profilePhoto ?? '');
    await _authStorage.write('email', email);
    await _authStorage.write('join_date', joinDate);
  }

  @override
  Future<void> registerAuthData({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? nickName,
    required String joinDate,
  }) async {
    await _authStorage.write('_id', id);
    await _authStorage.write('email', email);
    await _authStorage.write('first_name', firstName ?? '');
    await _authStorage.write('last_name', lastName ?? '');
    await _authStorage.write('nick_name', nickName ?? 'user');
    await _authStorage.write('join_date', joinDate);
  }

  @override
  Future<void> updateProfileLocalData({
    required String firstName,
    required String lastName,
    required String nickName,
    String? profilePhoto,
  }) async {
    await _authStorage.write('first_name', firstName);
    await _authStorage.write('last_name', lastName);
    await _authStorage.write('nick_name', nickName);
    if (profilePhoto != null) {
      await _authStorage.write('profile_photo', profilePhoto);
    }
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
  String? getFirstName() => _authStorage.read<String>('first_name');

  @override
  String? getLastName() => _authStorage.read<String>('last_name');

  @override
  String? getNickName() => _authStorage.read<String>('nick_name');

  @override
  String? getProfilePhoto() => _authStorage.read<String>('profile_photo');

  @override
  String? getJoinDate() => _authStorage.read<String>('join_date');

  @override
  Future<void> clearAuthData() async {
    await _authStorage.remove('_id');
    await _authStorage.remove('access_token');
    await _authStorage.remove('refresh_token');
    await _authStorage.remove('email');
    await _authStorage.remove('first_name');
    await _authStorage.remove('last_name');
    await _authStorage.remove('nick_name');
    await _authStorage.remove('profile_photo');
    await _authStorage.remove('join_date');
  }
}
