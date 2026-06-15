import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';


class ProfileScreenController extends GetxController {
  final AuthLocalSourceImpl _authLocalSource = AuthLocalSourceImpl();

  var userName = "".obs;
  var userId = "".obs;
  var joinDate = "".obs;
  var teamJoined = 0.obs;
  var totalWins = 0.obs;

  @override
  void onInit() {
    super.onInit();

    userName.value = _authLocalSource.getName() ?? "Guest";
    userId.value = _authLocalSource.getEmail() ?? "Unknown";
    joinDate.value = _authLocalSource.getJoinDate() ?? "N/A";

    teamJoined.value = 5;
    totalWins.value = 12;
  }
}
