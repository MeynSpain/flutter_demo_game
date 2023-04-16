//Нижнее подчеркивание это модификатор private
bool _running = true;

///Запуск тика и обновления картинки в игре
void startLoop() {
  final double _fps = 50;
  final double _second = 1000;
  final double _updateTime = _second / _fps; //Каждые updateTime милисекунд нужно обновлять игру
  double _updates = 0;

  //Стандартный таймер, который будет считать сколько времени прошло
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  Stopwatch _timerWatch = Stopwatch();
  _timerWatch.start();

  while (_running) {
    //Каждый updateTime обновляем картинку
    if (_loopWatch.elapsedMilliseconds > _updateTime) {
      _updates++;
      _loopWatch.reset();
    }

    if (_timerWatch.elapsedMilliseconds > _second){
      print('${DateTime.now()} FPS: $_updates');
      _updates = 0;
      _timerWatch.reset();
    
    }
  }
}

///Остановка тика и обновления картинки в игре
void stopLoop() {
  _running = false;
}
