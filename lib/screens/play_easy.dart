import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/cards.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';
import 'package:jogo_da_memoria/utils/globals.dart' as globals;

class PlayEasy extends StatefulWidget {
  @override
  _PlayEasyState createState() => _PlayEasyState();
}

class _PlayEasyState extends State<PlayEasy> {
  late List<BirdSpecies> gameBirds; // The list of bird species in the game
  late List<bool> isFlipped; // The state of each card (flipped or not)
  int? firstCardIndex; // The index of the first selected card
  int? secondCardIndex; // The index of the second selected card
  int numMatches = 0; // The number of matches found

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    gameBirds = []; // Initialize the list of game cards
    isFlipped = List<bool>.filled(
        6, true); // Initialize the state of each card as flipped
    firstCardIndex = null; // No cards are selected at start
    secondCardIndex = null; // No cards are selected at start
    numMatches = 0; // No matches are found at start

    var shuffledBirds = globals.birdSpeciesList..shuffle();
    shuffledBirds.sort((a, b) => a.numCorrect.compareTo(b.numCorrect));
    gameBirds.addAll(shuffledBirds.take(3));
    gameBirds.addAll(gameBirds);
    gameBirds.shuffle();
  }

  Future<void> flipCard(int index) async {
    if (firstCardIndex == null) {
      firstCardIndex = index;
    } else if (firstCardIndex != index) {
      secondCardIndex = index;
      if (gameBirds[firstCardIndex!].name == gameBirds[secondCardIndex!].name) {
        gameBirds[firstCardIndex!].numCorrect++;
        numMatches++;
        if (numMatches == 3) {
          await Future.delayed(const Duration(seconds: 1));
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
      } else {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          isFlipped[firstCardIndex!] = true;
          isFlipped[secondCardIndex!] = true;
        });
        firstCardIndex = null;
        secondCardIndex = null;
      }
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
