import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_demo_game/game_core/main_loop.dart';
import 'package:flutter_demo_game/utilits/global_vars.dart';

///Будет менять сцены
class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {


  //Порт для приема данных из главное изолята
  late ReceivePort _receivePort ;

  //Изолят(поток), но в отличии от других языков
  //Для каждого изолята выделяется отдельная куча в памяти и
  //Изолят A не имеет доступа к памяти изолят В, также как и В к А.
  //для этого и существуют порты(ReceivePort), чтобы передавать нужные данные между изолятами
  late Isolate _isolateLoop;



  void _startIsolateLoop() async {
    //Инициализируем порт и изолят
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);

    //Подключаем к порту слушатель, чтобы слушать пришло ли сообщение из главного изолята
    _receivePort.listen((message) {
      //Делаем update сцены, вся математика сцены расчиталась
      //и объекты начали двигаться
      GlobalVars.currentScene.update();

      setState(() {

      });
    });
  }

  @override
  void initState() {
    _startIsolateLoop();
    super.initState();

  }

  @override
  void dispose() {
    _receivePort.close();
    _isolateLoop.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalVars.currentScene.buildScene();
  }
}
