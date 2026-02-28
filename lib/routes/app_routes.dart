import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/presentation/emai_input_page.dart';
import 'package:music_game_app/features/authentication/presentation/first_screen.dart';

class AppRoutes{
  AppRoutes._();


  static const String firstScreen = "/firstScreen";
  static const String emailInputScreen = "/emailInputScreen";





}


List<GetPage> routes = [
  GetPage(name: AppRoutes.firstScreen, page: () => const FirstScreen()),
  GetPage(name: AppRoutes.emailInputScreen, page: () => const EmailInputPage()),





];