import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo_game/Scenes/app_scene.dart';
import 'package:flutter_demo_game/entities/bullet.dart';
import 'package:flutter_demo_game/entities/player.dart';
import 'package:flutter_demo_game/utilits/global_vars.dart';

class GameScene extends AppScene {
  Player _player = Player();
  double _startGlobalPosition = 0;
  List<Bullet> _listBullets = [];
  List<Widget> _listWidgets = [];

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
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
            ),
          ),
        ),

        //Контейнер для отслеживания тапов задания скорости корабля
        Positioned(
          top: 0,
          left: GlobalVars.screenWidth / 2 + 1,
          child: Container(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight / 2,
            child: GestureDetector(
              onTap: _onAcceleration,
            ),
          ),
        ),

        //Контейнер для отслеживания тапов для выстрела
        Positioned(
          top: GlobalVars.screenHeight / 2 - 1,
          left: GlobalVars.screenWidth / 2 + 1,
          child: Container(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight / 2,
            child: GestureDetector(
              onTap: _onShoot,
            ),
          ),
        ),

        Stack(
          children: _listWidgets,
        )
      ],
    );
  }

  @override
  void update() {
    _player.update();

    _listWidgets.clear();
    _listBullets.removeWhere((element) => !element.visible);  //Удаление всех пуль которые не видимы

    _listBullets.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });
  }

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
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

  void _onAcceleration() {
    _player.isAcceleration = _player.isAcceleration ? false : true;
  }



  void _onShoot() {
    _listBullets.add(Bullet(playerAngle: _player.getAngle,playerX:  _player.x,playerY:  _player.y));
  }
}