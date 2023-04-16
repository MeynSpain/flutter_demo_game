import 'package:flutter/cupertino.dart';

abstract class Entity {
  //Координаты сущности
  double x = 0;
  double y = 0;

  //Имя файла(картинки)
  final String spriteName;

  //Отрисовывается сущность или нет
  bool visible = true;

  //Лист для хранения спрайтов сущностей
  List sprites = [];

  //Номер спрайта
  int currentSprite = 0;

  int currentTick = 0;

  Entity(this.spriteName){
    for (var i = 0; i < 4; i++){
      sprites.add(Image.asset('assets/$spriteName$i.png'));
    }
  }

  void _animate(){
    currentTick++;
    if (currentTick > 15){
      currentSprite++;
      currentTick = 0;
    }

    if (currentSprite > 3)
      currentSprite = 0;
  }

  void update(){
    _animate();
    move();
  }

  void move();

  Widget build();

}
