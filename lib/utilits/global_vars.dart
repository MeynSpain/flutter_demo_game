//Файл где будут храниться все общедоступные переменные,
//которые можно испольховать во всем приложении


import 'package:flutter_demo_game/Scenes/app_scene.dart';
import 'package:flutter_demo_game/Scenes/game_scene.dart';

class GlobalVars {
  static AppScene currentScene = GameScene();

  //Размеры экрана пользователя
  static double screenWidth = 0;
  static double screenHeight = 0;
}