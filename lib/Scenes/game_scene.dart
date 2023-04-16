import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo_game/Scenes/app_scene.dart';
import 'package:flutter_demo_game/entities/player.dart';
import 'package:flutter_demo_game/utilits/global_vars.dart';

class GameScene extends AppScene {
  Player _player = Player();
  double _startGlobalPosition = 0;

  @override
  Widget buildScene() {
    //Stack никак не позиционирует виджеты и располагает их в координатах (0,0)
    return Stack(
      children: [
        _player.build(),

        //Контейнер в котором будут отслеживаться тапы для передвижения
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
            ),
          ),
        )
      ],
    );
  }

  @override
  void update() {
    _player.update();
  }

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
    print(_startGlobalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;

    //Вправо
    if (updateGlobalPosition > _startGlobalPosition + 30){
        _player.isMoveRight = true;
    }

    //Влево
    if (updateGlobalPosition < _startGlobalPosition - 30){
      _player.isMoveLeft = true;
    }
  }
}