import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';

class MediumGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MediumGame> {
  List<BirdSpecies> data = [];
  List<bool> opened = [];

  int? firstIndex;
  int? secondIndex;

  @override
  void initState() {
    super.initState();
    var shuffledBirds = mediumBirdSpeciesList..shuffle();
    data.addAll(shuffledBirds.take(6));
    data = data + List.from(data);
    data.shuffle();
    opened = List<bool>.filled(data.length, true);
  }

  void resetGame() {
    setState(() {
      data.clear();
      var shuffledBirds = mediumBirdSpeciesList..shuffle();
      data.addAll(shuffledBirds.take(6));
      data = data + List.from(data);
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
      appBar: AppBar(
        title: Text('Médio'),
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
      body: GridView.builder(
        padding: EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Agora temos 3 colunas
          childAspectRatio: 1.0,
          mainAxisSpacing: 40.0,
          crossAxisSpacing: 7.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => openCard(index),
            child: Container(
              color: opened[index] ? Colors.blue : Colors.white,
              child: Center(
                child: opened[index]
                    ? /*Text(
                  '🐦',
                  style: TextStyle(
                    fontSize: 64,
                    color: Colors.white,
                  ),
                )*/
                Image.asset(
                    vito,
                    fit: BoxFit.cover
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
