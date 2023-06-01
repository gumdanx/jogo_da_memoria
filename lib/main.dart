import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';

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
          return MaterialApp(home: MemoryGame());
        } else {
          return MaterialApp(home: SplashScreen());
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          tropibio,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<BirdSpecies> data = [];
  List<bool> opened = [];

  int? firstIndex;
  int? secondIndex;

  @override
  void initState() {
    super.initState();
    var shuffledBirds = birdSpeciesList..shuffle();
    data.addAll(shuffledBirds.take(3));
    data = data + data;
    data.shuffle();
    opened = List<bool>.filled(data.length, true);
  }

  void resetGame() {
    setState(() {
      data.clear();
      var shuffledBirds = birdSpeciesList..shuffle();
      data.addAll(shuffledBirds.take(3));
      data = data + data;
      data.shuffle();
      opened = List<bool>.filled(data.length, true);
      firstIndex = null;
      secondIndex = null;
    });
  }

  void openCard(int index) {
    if (firstIndex == null) {
      firstIndex = index;
      setState(() {
        opened[index] = false;
      });
    } else if (secondIndex == null && index != firstIndex) {
      secondIndex = index;
      setState(() {
        opened[index] = false;
      });

      if (data[firstIndex!].name != data[secondIndex!].name) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            opened[firstIndex!] = true;
            opened[secondIndex!] = true;
            firstIndex = null;
            secondIndex = null;
          });
        });
      } else {
        firstIndex = null;
        secondIndex = null;
      }
    }
    if (firstIndex == null && secondIndex == null && !opened.contains(true)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Parabéns!'),
            content: Text('Você concluiu o jogo!'),
            actions: [
              TextButton(
                child: Text('Jogar novamente'),
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jogo da Memoria")),
      body: GridView.builder(
        padding: EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => openCard(index),
            child: Container(
              color: opened[index] ? Colors.blue : Colors.white,
              child: Center(
                child: opened[index]
                    ? Text(
                        '🐦',
                        style: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            data[index].image,
                            fit: BoxFit.contain,
                          ),
                          /* Text(
                            data[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ), */
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
