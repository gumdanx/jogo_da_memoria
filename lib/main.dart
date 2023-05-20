import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';

void main() {
  runApp(MaterialApp(home: MemoryGame()));
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
                          Text(
                            data[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
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
