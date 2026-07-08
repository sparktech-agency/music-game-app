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

      final String category = Get.arguments as String;
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
