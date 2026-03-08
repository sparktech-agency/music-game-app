import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/after_splash.dart';
import 'package:music_game_app/features/app_landing/presentation/app_landing.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_play_screen.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_sing_screen.dart';
import 'package:music_game_app/features/app_landing/presentation/main_splash.dart';
import 'package:music_game_app/features/authentication/presentation/emai_input_page.dart';
import 'package:music_game_app/features/authentication/presentation/first_screen.dart';
import 'package:music_game_app/features/prerequisite/presentation/round_selection.dart';
import 'package:music_game_app/features/prerequisite/presentation/team_number.dart';
import 'package:music_game_app/features/profile/presentation/account_settings_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_screen.dart';
import 'package:music_game_app/features/profile/presentation/profile_settings_screen.dart';
import 'package:music_game_app/features/profile/presentation/settings_screen.dart';


class AppRoutes{
  AppRoutes._();

  static const String firstScreen = "/firstScreen";
  static const String emailInputScreen = "/emailInputScreen";
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


}


List<GetPage> routes = [
  GetPage(name: AppRoutes.firstScreen, page: () => const FirstScreen()),
  GetPage(name: AppRoutes.emailInputScreen, page: () => const EmailInputPage()),
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

];