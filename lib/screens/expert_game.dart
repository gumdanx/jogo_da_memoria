import 'package:flutter/material.dart';
import 'dart:math';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';

class ExpertGame extends StatefulWidget {
  @override
  _HardGameState createState() => _HardGameState();
}

class _HardGameState extends State<ExpertGame> {
  List<BirdSpecies> data = [];
  List<bool> opened = [];
  String selectedBirdName = '';
  List<String> guessedLetters = [];
  List<String> availableLetters = [];
  int? firstIndex;
  int? secondIndex;

  // Função para encontrar o caminho da imagem usando o nome
  String findImagePathByName(String name, List<BirdSpecies> list) {
    for (BirdSpecies species in list) {
      if (species.name == name) {
        return species.image;
      }
    }
    return '';
  }

  void setupGameForSelectedBird(String birdName) {
    selectedBirdName = birdName;
    guessedLetters = List.filled(birdName.length, '🐦');

    // Adicionando algumas letras distratoras - ajuste conforme necessário
    availableLetters = birdName.split('') + ['a', 'b', 'c', 'd'];
    availableLetters.shuffle();
  }

  void selectLetter(int index) {
    if(!guessedLetters.contains(availableLetters[index])) {
      int letterIndex = selectedBirdName.indexOf(availableLetters[index]);
      guessedLetters[letterIndex] = availableLetters[index];
      availableLetters[index] = '';  // Marcar a letra como usada

      if(!guessedLetters.contains('🐦')) {
        // Todas as letras foram adivinhadas
        print('Parabéns, você adivinhou a palavra!');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    var birdList = (Random().nextBool()) ? headsBirdSpeciesList : bodysBirdSpeciesList;

    var shuffledBirds = birdList..shuffle();
    data.addAll(shuffledBirds.take(4)); // Aumentado para 9 para tornar o jogo mais difícil
    data = data + List.from(data);
    data.shuffle();
    opened = List<bool>.filled(data.length, true);
  }

  void resetGame() {
    setState(() {
      data.clear();

      var birdList = (Random().nextBool()) ? headsBirdSpeciesList : bodysBirdSpeciesList;

      var shuffledBirds = birdList..shuffle();
      data.addAll(shuffledBirds.take(4)); // Aumentado para 9 para tornar o jogo mais difícil
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
        // Um par foi encontrado
        String birdName = data[firstIndex!].name; // Ajuste para obter o nome correto do pássaro
        setupGameForSelectedBird(birdName);

        // Encontrando os caminhos corretos para as imagens
        String headImagePath = findImagePathByName(birdName, headsBirdSpeciesList);
        String bodyImagePath = findImagePathByName(birdName, bodysBirdSpeciesList);

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 20.0),),
                // Linha 1: Fotos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180.0,  // Define a largura desejada aqui
                      height: 180.0, // Define a altura desejada aqui
                      child: Image.asset(headImagePath, fit: BoxFit.contain),
                    ),
                    Container(
                      width: 180.0,  // Define a largura desejada aqui
                      height: 180.0, // Define a altura desejada aqui
                      child: Image.asset(bodyImagePath, fit: BoxFit.contain),
                    ),
                  ],
                ),
                Padding(padding: const EdgeInsets.only(top: 20.0),),
                // Linha 2: Emojis de passarinho representando cada letra
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: guessedLetters.map((letter) => Text(letter, style: TextStyle(fontSize:28),)).toList(),
                ),
                Padding(padding: const EdgeInsets.only(top: 20.0),),
                // Linha 3: Letras disponíveis para escolha
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.center,
                  children: availableLetters.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectLetter(entry.key);
                        });
                      },
                      child: Text(
                        entry.value.toUpperCase(),
                        style: TextStyle(fontSize: 24.0),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );

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
        title: Text('Expert'),
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
          crossAxisCount: 2, // Colunas
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
