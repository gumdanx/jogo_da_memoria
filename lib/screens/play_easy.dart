import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/cards.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';
import 'package:jogo_da_memoria/globals.dart' as globals;

class PlayEasy extends StatefulWidget {
  @override
  _PlayEasyState createState() => _PlayEasyState();
}

class _PlayEasyState extends State<PlayEasy> {
  late List<BirdSpecies> gameBirds;
  late List<bool> isFlipped;
  int? firstCardIndex;
  int? secondCardIndex;
  int numMatches = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    gameBirds = [];
    isFlipped = List<bool>.filled(6, true);
    firstCardIndex = null;
    secondCardIndex = null;
    numMatches = 0;

    var shuffledBirds = globals.birdSpeciesList..shuffle();
    shuffledBirds.sort((a, b) => a.numCorrect.compareTo(b.numCorrect));
    gameBirds.addAll(shuffledBirds.take(3));
    gameBirds.addAll(gameBirds);
    gameBirds.shuffle();
  }

  void flipCard(int index) {
    if (firstCardIndex == null) {
      firstCardIndex = index;
    } else if (firstCardIndex != index) {
      secondCardIndex = index;
      if (gameBirds[firstCardIndex!].name == gameBirds[secondCardIndex!].name) {
        gameBirds[firstCardIndex!].numCorrect++;
        gameBirds[secondCardIndex!].numCorrect++;
        numMatches++;
        if (numMatches == 3) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Parabéns, você venceu!'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Jogar novamente'),
                      onPressed: () {
                        setState(() {
                          startGame();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
        firstCardIndex = null;
        secondCardIndex = null;
      }
    } else {
      firstCardIndex = null;
      secondCardIndex = null;
    }
    setState(() {
      isFlipped[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fácil'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: gameBirds.length,
        itemBuilder: (context, index) {
          return Cards(
            birdSpecies: gameBirds[index],
            isFlipped: isFlipped[index],
            onTap: () => flipCard(index),
          );
        },
      ),
    );
  }
}
