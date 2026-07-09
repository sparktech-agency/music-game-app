import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_game_app/app/my_app.dart';

void main() async {



  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    GetStorage.init(),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);


  runApp(const MyApp());
}
