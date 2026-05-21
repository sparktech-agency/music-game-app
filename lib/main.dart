import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_game_app/app/my_app.dart';

void main() async {


  //portrait mode off
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  runApp(const MyApp());
}
