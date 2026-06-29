import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';

class ProfileScreenController extends GetxController {
  final AuthLocalSource _authLocalSource;

  ProfileScreenController({required AuthLocalSource authLocalSource})
    : _authLocalSource = authLocalSource;



  var userName = "".obs;
  var userEmail = "".obs;
  var nickName = "".obs;
  var profilePhoto = "".obs;
  var joinDate = "".obs;
  var teamJoined = 0.obs;
  var totalWins = 0.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialProfileData();
  }

  void _loadInitialProfileData() {
    userEmail.value = _authLocalSource.getEmail() ?? "Unknown";
    nickName.value = _authLocalSource.getNickName() ?? "user";
    profilePhoto.value = _authLocalSource.getProfilePhoto() ?? "";
    joinDate.value = _authLocalSource.getJoinDate() ?? "N/A";
    teamJoined.value = 0;
    totalWins.value = 0;
  }
}
