import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_game/game_core/game.dart';
import 'package:flutter_demo_game/game_core/main_loop.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Сначала повернется экран, а затем уже создаться MaterialApp
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .whenComplete(() {

        //Убирает верхнюю строку со временем и всем остальным
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game()
    ));
  });
}
