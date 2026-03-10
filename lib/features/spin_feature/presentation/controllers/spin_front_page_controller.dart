import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class SpinFrontPageController extends GetxController {
  // //==== Observables ====
  var secondsRemaining = 5.obs;
  var showCross = false.obs;
  var isButtonEnabled = false.obs;
  Timer? _timer;

  // //==== Controller for Vertical Scroll (Wheel Effect) ====
  late FixedExtentScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = FixedExtentScrollController(initialItem: 0);
  }

  // //==== Timer Logic: Scrolls numbers down 5 to 1 ====
  void startTimer() {
    // Reset state in case of restart
    secondsRemaining.value = 5;
    showCross.value = false;
    isButtonEnabled.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 1) {
        secondsRemaining.value--;

        // //==== Animates the wheel downwards to the next index ====
        scrollController.animateToItem(
          5 - secondsRemaining.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      } else {
        // //==== Timer ends: Show cross and Enable Button ====
        secondsRemaining.value = 0;
        showCross.value = true;
        isButtonEnabled.value = true;
        _timer?.cancel();
      }
    });
  }

  // //==== Button Action: Navigates or triggers Spin Wheel ====
  void onSpinTap() {
    if (isButtonEnabled.value) {

      Get.toNamed(AppRoutes.spinWheelPage);
    }
  }

  @override
  void onClose() {
    // //==== Essential Cleanup to prevent memory leaks ====
    _timer?.cancel();
    scrollController.dispose();
    super.onClose();
  }
}