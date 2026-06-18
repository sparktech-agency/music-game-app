import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/after_splash.dart';
import 'package:music_game_app/features/app_landing/presentation/app_landing.dart';
import 'package:music_game_app/features/app_landing/presentation/bindings/app_landing_binding.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_play_screen.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_sing_screen.dart';
import 'package:music_game_app/features/app_landing/presentation/main_splash.dart';
import 'package:music_game_app/features/authentication/presentation/bindings/auth_binding.dart';
import 'package:music_game_app/features/authentication/presentation/enter_email_page.dart';
import 'package:music_game_app/features/authentication/presentation/login_page.dart';
import 'package:music_game_app/features/authentication/presentation/first_screen.dart';
import 'package:music_game_app/features/authentication/presentation/phone_input_page.dart';
import 'package:music_game_app/features/authentication/presentation/registration_page.dart';
import 'package:music_game_app/features/authentication/presentation/set_password_page.dart';
import 'package:music_game_app/features/authentication/presentation/verify_email_page.dart';
import 'package:music_game_app/features/authentication/presentation/verify_phone_page.dart';
import 'package:music_game_app/features/game_play/presentation/gameplay_page.dart';
import 'package:music_game_app/features/game_play/presentation/result_page.dart';
import 'package:music_game_app/features/profile/presentation/account_settings_screen.dart';
import 'package:music_game_app/features/profile/presentation/bindings/profile_binding.dart';
import 'package:music_game_app/features/profile/presentation/profile_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_settings_screen.dart';
import 'package:music_game_app/features/profile/presentation/settings_screen.dart';
import 'package:music_game_app/features/session/presentation/bindings/session_bindings.dart';
import 'package:music_game_app/features/session/presentation/player_name.dart';
import 'package:music_game_app/features/session/presentation/round_selection.dart';
import 'package:music_game_app/features/session/presentation/singer_number.dart';
import 'package:music_game_app/features/session/presentation/team_name.dart';
import 'package:music_game_app/features/session/presentation/team_number.dart';
import 'package:music_game_app/features/session/presentation/which_team.dart';
import 'package:music_game_app/features/spin_feature/presentation/bindings/spin_feature_bindings.dart';
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
  static const String loginPage = "/loginPage";
  static const String registrationPage = "/registrationPage";
  static const String verifyEmailPage = "/verifyEmailPage";
  static const String verifyPhonePage = "/verifyPhonePage";
  static const String enterEmailPage = "/enterEmailPage";
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
  static const String playerName = "/playerName";
  static const String spinFrontPage = "/spinFrontPage";
  static const String spinWheelPage = "/spinWheelPage";
  static const String songPickLoading = "/songPickLoading";
  static const String selectedSong = "/selectedSong";
  static const String lyricsPage = "/lyricsPage";
  static const String gameplayPage = "/gameplayPage";
  static const String resultPage = "/resultPage";


}


List<GetPage> routes = [

  GetPage(name: AppRoutes.firstScreen, page: () => const FirstScreen()),

  GetPage(
      name: AppRoutes.loginPage,
      page: () => const LogInPage(),
      binding: AuthBinding(),
  ),

  GetPage(
      name: AppRoutes.registrationPage,
      page: () => const RegistrationPage(),
      binding: AuthBinding(),

  ),

  GetPage(
      name: AppRoutes.verifyEmailPage,
      page: () => const VerifyEmailPage(),
      binding: AuthBinding()
  ),

  GetPage(
      name: AppRoutes.verifyPhonePage,
      page: () => const VerifyPhonePage(),
      binding: AuthBinding()
  ),

  GetPage(
      name: AppRoutes.enterEmailPage,
      page: () => const EnterEmailPage(),
      binding: AuthBinding()
  ),



  GetPage(name: AppRoutes.phoneInputScreen, page: () => const PhoneInputPage()),
  GetPage(name: AppRoutes.setPassScreen, page: () => const SetPasswordPage()),
  GetPage(name: AppRoutes.welcomeSplash, page: () =>  WelcomeSplash()),
  GetPage(name: AppRoutes.twoButtonPage, page: () =>  TwoButtonPage()),

  GetPage(
      name: AppRoutes.appLanding,
      page: () =>  AppLanding(),
      bindings: [
        AppLandingBinding(),
        ProfileBinding()


      ]
      ),



  GetPage(
      name: AppRoutes.profileScreen,
      page: () =>  ProfileScreen(),
      binding: ProfileBinding()
  ),





  GetPage(name: AppRoutes.settingsScreen, page: () =>  SettingsScreen()),
  GetPage(name: AppRoutes.profileSettings, page: () =>  ProfileSettingsScreen()),
  GetPage(name: AppRoutes.accountSettings, page: () =>  AccountSettingsScreen()),
  GetPage(name: AppRoutes.letsSingScreen, page: () =>  LetsSingScreen()),
  GetPage(name: AppRoutes.letsPlayScreen, page: () =>  LetsPlayScreen()),
  GetPage(name: AppRoutes.mainSplash, page: () =>  MainSplash()),
  GetPage(name: AppRoutes.afterSplash, page: () =>  AfterSplash()),






  GetPage(
      name: AppRoutes.roundSelection,
      page: () =>  RoundSelection(),
      binding: SessionBindings()
  ),

  GetPage(
      name: AppRoutes.teamNumber,
      page: () =>  TeamNumber(),
      binding: SessionBindings()
  ),


  GetPage(
      name: AppRoutes.singerNumber,
      page: () =>  SingerNumber(),
      binding: SessionBindings()
  ),


  GetPage(
      name: AppRoutes.teamName,
      page: () =>  TeamName(),
      binding: SessionBindings()
  ),


  GetPage(
      name: AppRoutes.whichTeam,
      page: () =>  WhichTeam(),
      binding: SessionBindings()
  ),




  GetPage(
      name: AppRoutes.playerName,
      page: () => PlayerName(),
      binding: SessionBindings()
  ),







  GetPage(
      name: AppRoutes.spinFrontPage,
      page: () => SpinFrontPage(),
      binding: SpinFeatureBindings()
  ),










  GetPage(name: AppRoutes.spinWheelPage, page: () => SpinWheelPage()),
  GetPage(name: AppRoutes.songPickLoading, page: () => SongPickLoadingPage()),
  GetPage(name: AppRoutes.selectedSong, page: () => SelectedSong()),
  GetPage(name: AppRoutes.lyricsPage, page: () => LyricsPage()),
  GetPage(name: AppRoutes.gameplayPage, page: () => GameplayPage()),
  GetPage(name: AppRoutes.resultPage, page: () => ResultPage()),

];