import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_demo_game/entities/player.dart';
import 'package:flutter_demo_game/game_core/main_loop.dart';
import 'package:flutter_demo_game/utilits/common_vars.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {


  late Player player;

  //Порт для приема данных из главное изолята
  late ReceivePort _receivePort ;

  //Изолят(поток), но в отличии от других языков
  //Для каждого изолята выделяется отдельная куча в памяти и
  //Изолят A не имеет доступа к памяти изолят В, также как и В к А.
  //для этого и существуют порты(ReceivePort), чтобы передавать нужные данные между изолятами
  late Isolate _isolateLoop;



  void startIsolateLoop() async {
    //Инициализируем порт и изолят
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);

    //Подключаем к порту слушатель, чтобы слушать пришло ли сообщение из главного изолята
    _receivePort.listen((message) {
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {

    //Чтобы при каждой отрисовки виджета не создавались новые изоляты
    if (isFirstStartGame){
      startIsolateLoop();
      isFirstStartGame = false;
      player = Player();
    }

    player.update();

    //Stack никак не позиционирует виджеты и располагает их в координатах (0,0)
    return Stack(
      children: [
        player.build()
      ],
    );
  }
}
