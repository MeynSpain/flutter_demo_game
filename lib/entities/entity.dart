import 'package:flutter/cupertino.dart';

abstract class Entity {
  //Координаты сущности
  late double x;
  late double y;

  //Имя файла(картинки)
  late String spriteName;

  //Отрисовывается сущность или нет
  bool visible = true;

  //Лист для хранения спрайтов сущностей
  List sprites = [];

  Entity(this.spriteName){
    for (var i = 0; i < 4; i++){
      sprites.add(Image.asset('assets/$spriteName$i.png'));
    }
  }

  void update();
  void move();

  Widget build();

}
