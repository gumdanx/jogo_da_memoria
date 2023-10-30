import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/screens/logo_screen.dart';
import 'package:jogo_da_memoria/screens/hard_game.dart';
import 'package:jogo_da_memoria/screens/medium_game.dart';
import 'package:jogo_da_memoria/screens/easy_game.dart';
import 'package:jogo_da_memoria/screens/ranking.dart';

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
        child: Center(
          child: Container(
            padding: EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 20.0),),
                    Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EasyGame()),
                          );
                        },
                        label: Text("Fácil"),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20.0),),
                    Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MediumGame()),
                          );
                        },
                        label: Text("Médio"),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20.0),),
                    Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HardGame()),
                          );
                        },
                        label: Text("Difícil"),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 40.0),),
                    Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RankingScreen()),
                          );
                        },
                        label: Text("Pontuação"),
                        backgroundColor: Colors.green,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20.0),),
                    Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LogoScreen()),
                          );
                        },
                        label: Text("Realização"),
                        backgroundColor: Colors.green,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20.0),),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(editorial),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}