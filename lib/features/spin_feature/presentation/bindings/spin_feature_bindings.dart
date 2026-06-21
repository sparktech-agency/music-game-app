import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/data/repositories_impl/spin_feature_repository_impl.dart';
import 'package:music_game_app/features/spin_feature/data/sources/spin_feature_remote_source.dart';
import 'package:music_game_app/features/spin_feature/domain/repositories/spin_feature_repository.dart';
import 'package:music_game_app/features/spin_feature/domain/usecases/get_song_usecase.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/song_pick_loading_controller.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/spin_wheel_controller.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';

class SpinFeatureBindings extends Bindings {
  @override
  void dependencies() {
    //============== ১. Data Source ==============
    Get.lazyPut<SpinFeatureRemoteSource>(() => SpinFeatureRemoteSource());

    //============== ২. Repositories ==============
    Get.lazyPut<SpinFeatureRepository>(
          () => SpinFeatureRepositoryImpl(Get.find<SpinFeatureRemoteSource>()),
    );

    //============== ৩. UseCases ==============
    Get.lazyPut<GetSongUseCase>(
          () => GetSongUseCase(Get.find<SpinFeatureRepository>()),
    );

    //============== ৪. Controllers ==============
    Get.lazyPut<TurnManagementController>(
          () => TurnManagementController(),
      fenix: true,
    );


    Get.lazyPut<SpinWheelController>(
          () => SpinWheelController(),
      fenix: true,
    );

    Get.lazyPut<SongPickLoadingController>(
          () => SongPickLoadingController(getSongUseCase: Get.find<GetSongUseCase>()),
      fenix: true,
    );
  }
}