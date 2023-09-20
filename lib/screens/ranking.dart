import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';
import 'package:jogo_da_memoria/utils/globals.dart'; // Importe seu arquivo globals.dart

class RankingScreen extends StatelessWidget {
  // Cria uma função para calcular o total de numCorrect de todas as listas
  List<BirdSpecies> calculateTotalScore() {
    Map<String, BirdSpecies> consolidatedList = {};

    // Soma os numCorrect de todas as listas para cada espécie
    for (var list in [
      birdSpeciesList,
      easyBirdSpeciesList,
      mediumBirdSpeciesList,
      headsBirdSpeciesList,
      bodysBirdSpeciesList,
    ]) {
      for (var species in list) {
        if (!consolidatedList.containsKey(species.name)) {
          consolidatedList[species.name] = BirdSpecies(
            name: species.name,
            image: species.image,
            numCorrect: species.numCorrect,
          );
        } else {
          consolidatedList[species.name]!.numCorrect += species.numCorrect;
        }
      }
    }

    // Atualize a imagem para usar a versão 'head' para todas as espécies
    for (var headSpecies in headsBirdSpeciesList) {
      if (consolidatedList.containsKey(headSpecies.name)) {
        consolidatedList[headSpecies.name]!.image = headSpecies.image;
      }
    }

    // Retorna a lista consolidada de espécies
    return consolidatedList.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalScores = calculateTotalScore();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação'),
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
      body: ListView.builder(
        itemCount: totalScores.length,
        itemBuilder: (context, index) {
          final species = totalScores[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
              ),
              onPressed: () {
                // Ação ao pressionar o botão (se necessário)
              },
              child: Row(
                children: [
                  ClipOval(
                    child: Transform.scale(
                      scale: 1.1,  // ajuste o valor de acordo com o quanto você quer que a imagem ultrapasse o limite
                      child: Image.asset(
                        species.image,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${species.name} (${species.numCorrect})',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
