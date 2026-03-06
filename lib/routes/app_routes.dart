import 'package:get/get.dart';
import 'package:music_game_app/features/app_landing/presentation/app_landing.dart';
import 'package:music_game_app/features/app_landing/presentation/lets_sing_screen.dart';
import 'package:music_game_app/features/authentication/presentation/emai_input_page.dart';
import 'package:music_game_app/features/authentication/presentation/first_screen.dart';
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

];