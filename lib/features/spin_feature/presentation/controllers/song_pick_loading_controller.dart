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


    _fetchSongAndNavigate();
  }

  Future<void> _fetchSongAndNavigate() async {
    try {
      final String category = (Get.arguments ?? '').toString().toLowerCase();
      final String roundId = _turnController.roundId.value;



      final apiCall = _getSongUseCase.call(
        roundId: roundId,
        turnIndex: 0,
        category: category,
      );

      final minimumDelay = Future.delayed(const Duration(seconds: 2));


      final List<dynamic> results = await Future.wait([apiCall, minimumDelay]);
      final songResult = results[0];


      _turnController.selectedSong.value = songResult;


      Get.offNamed(AppRoutes.selectedSong);

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.back();
    }
  }
}