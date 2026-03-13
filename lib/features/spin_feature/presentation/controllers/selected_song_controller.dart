import 'package:get/get.dart';

class SelectedSongController extends GetxController {

  var songTitle = "Night Changes".obs;
  var artistName = "One Direction".obs;
  var userName = "marsbrunny".obs;
  var albumArt = "assets/images/one_direction.jpg".obs;

  void onNext() {

    print("Moving to the next stage...");
  }
}