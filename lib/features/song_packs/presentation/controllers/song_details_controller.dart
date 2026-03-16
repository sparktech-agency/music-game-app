import 'package:get/get.dart';
import 'package:music_game_app/features/song_packs/data/song_details.dart';

class SongDetailsController extends GetxController {
  var songs = <Song>[].obs;
  var filteredSongs = <Song>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSongs();
  }

  void loadSongs() {
    List<Song> serverData = [
      Song(title: "Opalite", artist: "Taylor Swift", lyrics: "I had a bad habit...", imageUrl: "https://via.placeholder.com/150"),
      Song(title: "Nobody's Son", artist: "Sabrina Carpenter", lyrics: "Hi... I hope you're great...", imageUrl: "https://via.placeholder.com/150"),
      Song(title: "Man I Need", artist: "Olivia Dean", lyrics: "Talk to me, talk to me...", imageUrl: "https://via.placeholder.com/150"),
      Song(title: "Locked out of Heaven", artist: "Bruno Mars", lyrics: "One, two, one, two...", imageUrl: "https://via.placeholder.com/150"),
    ];
    songs.assignAll(serverData);
    filteredSongs.assignAll(serverData);
  }

  void searchSong(String query) {
    if (query.isEmpty) {
      filteredSongs.assignAll(songs);
    } else {
      filteredSongs.assignAll(songs.where((s) => s.title.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }
}