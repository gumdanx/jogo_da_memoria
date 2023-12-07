import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/screens/logo_screen.dart';
import 'package:jogo_da_memoria/screens/game.dart';
import 'package:jogo_da_memoria/screens/ranking.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🎮 Jogo da Memória 🎮',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.green],
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
                            MaterialPageRoute(builder: (context) => Game(numberOfSpecies: 4, title: 'Fácil')
                            ),
                          );
                        },
                        label: Text(" Fácil "),
                        foregroundColor: Colors.white, // Cor do texto
                        backgroundColor: Colors.blue[900], // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Ajuste este valor para aumentar o arredondamento
                        ),
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
                            MaterialPageRoute(builder: (context) => Game(numberOfSpecies: 6, title: 'Médio')),
                          );
                        },
                        label: Text(" Médio "),
                        foregroundColor: Colors.white, // Cor do texto
                        backgroundColor: Colors.blue[900], // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Ajuste este valor para aumentar o arredondamento
                        ),
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
                            MaterialPageRoute(builder: (context) => Game(numberOfSpecies: 9, title: 'Difícil')),
                          );
                        },
                        label: Text(" Difícil "),
                        foregroundColor: Colors.white, // Cor do texto
                        backgroundColor: Colors.blue[900], // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Ajuste este valor para aumentar o arredondamento
                        ),
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
                        foregroundColor: Colors.white, // Cor do texto
                        backgroundColor: Colors.green, // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Ajuste este valor para aumentar o arredondamento
                        ),
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
                        foregroundColor: Colors.white, // Cor do texto
                        backgroundColor: Colors.green, // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // Ajuste este valor para aumentar o arredondamento
                        ),
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