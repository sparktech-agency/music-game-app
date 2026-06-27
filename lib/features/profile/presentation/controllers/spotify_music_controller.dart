import 'package:get/get.dart';

class SpotifyMusicController extends GetxController {
  var isLoading = false.obs;
  var isConnected = true.obs;

  void disconnectSpotify() {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      isConnected.value = false;
    });
  }
}