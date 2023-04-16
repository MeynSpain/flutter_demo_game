import 'package:flutter/material.dart';

abstract class AppScene{
  ///Отрисовывает сцену
  Widget buildScene();

  //Считает всю математику
  void update();
}
