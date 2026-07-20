import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/domain/usecases/get_song_usecase.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SongPickLoadingController extends GetxController {
  final GetSongUseCase _getSongUseCase;

  SongPickLoadingController({required GetSongUseCase getSongUseCase})
    : _getSongUseCase = getSongUseCase;

  late final TurnManagementController _turnController;

  @override
  void onInit() {
    super.onInit();
    _turnController = Get.find<TurnManagementController>();
  }

  @override
  void onReady() {
    super.onReady();

    _fetchSongAndNavigate();
  }

  Future<void> _fetchSongAndNavigate() async {
    try {
      if (Get.arguments == null) {
        throw Exception("Arguments are missing.");
      }

      final String displayCategory = Get.arguments as String;
      String category = displayCategory;

      switch (displayCategory) {
        case "1980's Hits":
          category = "80s_hits";
          break;
        case "1990's Hits":
          category = "90s_hits";
          break;
        case "Rock Ballads":
          category = "rock_ballads";
          break;
        case "2010's Hits":
          category = "2010s_hits";
          break;
      }
      final String roundId = _turnController.roundId.value;

      // API call
      final apiCall = _getSongUseCase.call(
        roundId: roundId,
        turnIndex: 0,
        category: category,
      );

      // Minimum delay
      final minimumDelay = Future.delayed(const Duration(seconds: 2));

      final results = await Future.wait([apiCall, minimumDelay]);
      final songResult = results[0];

      _turnController.selectedSong.value = songResult;

      Get.offNamed(AppRoutes.selectedSong);
    } catch (e, stackTrace) {
      print("Error in SongPickLoadingController: $e");
      print("StackTrace: $stackTrace");

      Get.back();

      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
