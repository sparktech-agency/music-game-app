import 'dart:async';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SpinFrontPageController extends GetxController {
  // Observables
  final showCross = false.obs;
  final isButtonEnabled = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    resetAndStartTimer();
  }

  // Timer Logic
  void resetAndStartTimer() {

    _timer?.cancel();


    showCross.value = false;
    isButtonEnabled.value = false;


    _timer = Timer(const Duration(seconds: 6), () {
      if (!isClosed) {
        showCross.value = true;
        isButtonEnabled.value = true;
      }
    });
  }






  void onSpinTap() {
    if (isButtonEnabled.value) {
      Get.offNamed(AppRoutes.spinWheelPage);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}