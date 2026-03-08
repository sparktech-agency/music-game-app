import 'package:get/get.dart';

class PrerequisiteController extends GetxController {

  var selectedRound = 3.obs;

  void selectRound(int round) {
    selectedRound.value = round;
  }
}