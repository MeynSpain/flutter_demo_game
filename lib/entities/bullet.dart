import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo_game/entities/entity.dart';
import 'package:flutter_demo_game/utilits/global_vars.dart';

class Bullet extends Entity {
  final double playerAngle;
  double _speed = 10;

  Bullet({required this.playerAngle, required double playerX, required double playerY}) : super('bullet') {
    x = playerX;
    y = playerY;
  }

  @override
  Widget build() {
    return Positioned(
        top: y,
        left: x,
        child: Transform.rotate(
          angle: playerAngle,
          child: sprites[currentSprite],
        ));
  }

  @override
  void move() {
    x += sin(playerAngle) * _speed;
    y -= cos(playerAngle) * _speed;

    if (x < 0 || x > GlobalVars.screenWidth ||
        y < 0 || y > GlobalVars.screenHeight) {
      visible = false;
    }
  }

}
