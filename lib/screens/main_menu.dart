import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/logo_screen.dart';
import 'package:jogo_da_memoria/screens/medium_game.dart';
import 'package:jogo_da_memoria/screens/easy_game.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('As aves de Cabo Verde 🇨🇻'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EasyGame()),
                        );
                      },
                      label: Text("Fácil"),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MediumGame()),
                        );
                      },
                      label: Text("Médio"),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EasyGame()),
                        );
                      },
                      label: Text("Difícil"),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EasyGame()),
                        );
                      },
                      label: Text("Opções"),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogoScreen()),
                        );
                      },
                      label: Text("Realização"),
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Jogo desenvolvido pelo Projecto Vitó e o Tropibio para aproximar as crianças das aves marinhas de Cabo Verde 🇨🇻 e apresentar algumas curiosidades sobre elas",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
