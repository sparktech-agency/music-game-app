import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/after_splash.dart';
import 'package:music_game_app/features/app_landing/presentation/app_landing.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_play_screen.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_sing_screen.dart';
import 'package:music_game_app/features/app_landing/presentation/main_splash.dart';
import 'package:music_game_app/features/authentication/presentation/email_input_page.dart';
import 'package:music_game_app/features/authentication/presentation/first_screen.dart';
import 'package:music_game_app/features/authentication/presentation/phone_input_page.dart';
import 'package:music_game_app/features/authentication/presentation/set_password_page.dart';
import 'package:music_game_app/features/game_play/presentation/gameplay_page.dart';
import 'package:music_game_app/features/prerequisite/presentation/player_name_team1.dart';
import 'package:music_game_app/features/prerequisite/presentation/round_selection.dart';
import 'package:music_game_app/features/prerequisite/presentation/singer_number.dart';
import 'package:music_game_app/features/prerequisite/presentation/team_name.dart';
import 'package:music_game_app/features/prerequisite/presentation/team_number.dart';
import 'package:music_game_app/features/prerequisite/presentation/which_team.dart';
import 'package:music_game_app/features/profile/presentation/account_settings_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_settings_screen.dart';
import 'package:music_game_app/features/profile/presentation/settings_screen.dart';
import 'package:music_game_app/features/spin_feature/presentation/lyrics_page.dart';
import 'package:music_game_app/features/spin_feature/presentation/selected_song.dart';
import 'package:music_game_app/features/spin_feature/presentation/song_pick_loading_page.dart';
import 'package:music_game_app/features/spin_feature/presentation/spin_front_page.dart';
import 'package:music_game_app/features/spin_feature/presentation/spin_wheel_page.dart';
import 'package:music_game_app/features/welcome_splash/presentation/two_button_page.dart';
import 'package:music_game_app/features/welcome_splash/presentation/welcome_splash.dart';


class AppRoutes{
  AppRoutes._();

  static const String firstScreen = "/firstScreen";
  static const String emailInputScreen = "/emailInputScreen";
  static const String phoneInputScreen = "/phoneInputScreen";
  static const String setPassScreen = "/setPassScreen";

  static const String welcomeSplash = "/welcomeSplash";
  static const String twoButtonPage = "/twoButtonPage";

  static const String appLanding = "/appLanding";
  static const String profileScreen = "/profileScreen";
  static const String settingsScreen = "/settingsScreen";
  static const String profileSettings = "/profileSettings";
  static const String accountSettings = "/accountSettings";
  static const String letsSingScreen = "/letsSingScreen";
  static const String letsPlayScreen = "/letsPlayScreen";
  static const String mainSplash = "/mainSplash";
  static const String afterSplash = "/afterSplash";
  static const String roundSelection = "/roundSelection";
  static const String teamNumber = "/teamNumber";
  static const String singerNumber = "/singerNumber";
  static const String teamName = "/teamName";
  static const String whichTeam = "/whichTeam";
  static const String playerNameTeam1 = "/playerNameTeam1";
  static const String spinFrontPage = "/spinFrontPage";
  static const String spinWheelPage = "/spinWheelPage";
  static const String songPickLoading = "/songPickLoading";
  static const String selectedSong = "/selectedSong";
  static const String lyricsPage = "/lyricsPage";
  static const String gameplayPage = "/gameplayPage";


}


List<GetPage> routes = [
  GetPage(name: AppRoutes.firstScreen, page: () => const FirstScreen()),
  GetPage(name: AppRoutes.emailInputScreen, page: () => const EmailInputPage()),
  GetPage(name: AppRoutes.phoneInputScreen, page: () => const PhoneInputPage()),
  GetPage(name: AppRoutes.setPassScreen, page: () => const SetPasswordPage()),
  GetPage(name: AppRoutes.welcomeSplash, page: () =>  WelcomeSplash()),
  GetPage(name: AppRoutes.twoButtonPage, page: () =>  TwoButtonPage()),

  GetPage(name: AppRoutes.appLanding, page: () =>  AppLanding()),
  GetPage(name: AppRoutes.profileScreen, page: () =>  ProfileScreen()),
  GetPage(name: AppRoutes.settingsScreen, page: () =>  SettingsScreen()),
  GetPage(name: AppRoutes.profileSettings, page: () =>  ProfileSettingsScreen()),
  GetPage(name: AppRoutes.accountSettings, page: () =>  AccountSettingsScreen()),
  GetPage(name: AppRoutes.letsSingScreen, page: () =>  LetsSingScreen()),
  GetPage(name: AppRoutes.letsPlayScreen, page: () =>  LetsPlayScreen()),
  GetPage(name: AppRoutes.mainSplash, page: () =>  MainSplash()),
  GetPage(name: AppRoutes.afterSplash, page: () =>  AfterSplash()),
  GetPage(name: AppRoutes.roundSelection, page: () =>  RoundSelection()),
  GetPage(name: AppRoutes.teamNumber, page: () =>  TeamNumber()),
  GetPage(name: AppRoutes.singerNumber, page: () =>  SingerNumber()),
  GetPage(name: AppRoutes.teamName, page: () =>  TeamName()),
  GetPage(name: AppRoutes.whichTeam, page: () =>  WhichTeam()),
  GetPage(name: AppRoutes.playerNameTeam1, page: () => PlayerNameTeam1()),
  GetPage(name: AppRoutes.spinFrontPage, page: () => SpinFrontPage()),
  GetPage(name: AppRoutes.spinWheelPage, page: () => SpinWheelPage()),
  GetPage(name: AppRoutes.songPickLoading, page: () => SongPickLoadingPage()),
  GetPage(name: AppRoutes.selectedSong, page: () => SelectedSong()),
  GetPage(name: AppRoutes.lyricsPage, page: () => LyricsPage()),
  GetPage(name: AppRoutes.gameplayPage, page: () => GameplayPage()),

];