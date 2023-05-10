import 'package:flutter/material.dart';
import 'play_easy.dart' as easyGame;
import 'play_medium.dart' as mediumGame;
import 'play_hard.dart' as hardGame;
import 'options.dart' as options;

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Menu Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => easyGame.PlayEasy()),
                );
              },
              child: Text('Jogar - Fácil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => mediumGame.PlayMedium()),
                );
              },
              child: Text('Jogar - Médio'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => hardGame.PlayHard()),
                );
              },
              child: Text('Jogar - Difícil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => options.Options()),
                );
              },
              child: Text('Opções'),
            ),
          ],
        ),
      ),
    );
  }
}