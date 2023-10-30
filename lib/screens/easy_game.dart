import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';

class EasyGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<EasyGame> {
  List<bool> disabled = [];
  List<BirdSpecies> data = [];
  List<bool> opened = [];

  int? firstIndex;
  int? secondIndex;

  @override
  void initState() {
    super.initState();
    var shuffledBirds = birdSpeciesList..shuffle();
    data.addAll(shuffledBirds.take(4));
    data = data + data;
    data.shuffle();
    opened = List<bool>.filled(data.length, true);
    disabled = List<bool>.filled(data.length, false);
  }

  void resetGame() {
    setState(() {
      data.clear();
      var shuffledBirds = birdSpeciesList..shuffle();
      data.addAll(shuffledBirds.take(4));
      data = data + data;
      data.shuffle();
      opened = List<bool>.filled(data.length, true);
      firstIndex = null;
      secondIndex = null;
      disabled = List<bool>.filled(data.length, false);
    });
  }

  void openCard(int index) {
    if (disabled[index]) return;
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
        data[firstIndex!].incrementCorrect();
        setState(() {
          disabled[firstIndex!] = true;
          disabled[secondIndex!] = true;
        });
        firstIndex = null;
        secondIndex = null;
      }
    }
    if (firstIndex == null && secondIndex == null && !opened.contains(true)) {
      for (var bird in data) {
        saveScore(bird);
      }

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
      appBar: AppBar(
        title: Text('Fácil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetGame,
            tooltip: "Reiniciar o jogo",
          )
        ],
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
              color: opened[index] ? Color(0xFFBBD2EC) : Colors.white,
              child: Center(
                child: opened[index]
                    ? Image.asset(
                    vito,
                    fit: BoxFit.cover
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      data[index].image_easy,
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