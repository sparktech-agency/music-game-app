import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:intl/intl.dart';

class ProfileScreenController extends GetxController {
  final GetUserUseCase _getUserUseCase;
  final AuthLocalSource _authLocalSource;

  ProfileScreenController({
    required GetUserUseCase getUserUseCase,
    required AuthLocalSource authLocalSource,
  })  : _getUserUseCase = getUserUseCase,
        _authLocalSource = authLocalSource;

  var fullName = "".obs;
  var nickName = "".obs;
  var userEmail = "".obs;
  var profilePhoto = "".obs;
  var joinDate = "".obs;
  var teamJoined = 0.obs;
  var totalWins = 0.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      final userId = _authLocalSource.getUserId();

      if (userId == null) return;

      final getUser = await _getUserUseCase.call(userId: userId);

      String fName = getUser.firstName ?? "";
      String lName = getUser.lastName ?? "";
      fullName.value = "$fName $lName".trim();

      userEmail.value = getUser.email;
      profilePhoto.value = getUser.profile ?? "";


      joinDate.value = DateFormat('dd MMMM, yyyy').format(getUser.createdAt);

      nickName.value = getUser.nickName ?? "";

    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load profile data: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
