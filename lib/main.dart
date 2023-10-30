import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/main_menu.dart';
import 'package:jogo_da_memoria/screens/splash_screen.dart';
import 'package:jogo_da_memoria/utils/globals.dart'; // Certifique-se de importar este arquivo se 'birdSpeciesList' e 'getScore' estiverem definidos aqui.

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  Future<void> loadScores() async {
    for (var bird in birdSpeciesList) {
      int? score = await getScore(bird.name);
      if (score != null) {
        bird.numCorrect = score;
      }
    }
  }

  Future<void> loadApp() async {
    await Future.delayed(const Duration(seconds: 3));
    await loadScores();
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
