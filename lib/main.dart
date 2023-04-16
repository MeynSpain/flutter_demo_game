import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_game/game_core/game.dart';
import 'package:flutter_demo_game/game_core/main_loop.dart';
import 'package:flutter_demo_game/utilits/global_vars.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Сначала повернется экран, а затем уже создаться MaterialApp
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .whenComplete(() {
    //Убирает верхнюю строку со временем и всем остальным
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: MyApp(),
          ),
        )));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void didChangeDependencies() {
    initGame(context);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover)
        ),
        child: Game());
  }

  void initGame(BuildContext context) {
    GlobalVars.screenWidth = MediaQuery.of(context).size.width;
    GlobalVars.screenHeight = MediaQuery.of(context).size.height;
  }
}
