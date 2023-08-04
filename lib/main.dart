import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/main_menu.dart';
import 'package:jogo_da_memoria/screens/splash_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  Future<void> loadApp() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(home: MainMenu());
        } else {
          return MaterialApp(home: SplashScreen());
        }
      },
    );
  }
}
