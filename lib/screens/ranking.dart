import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {

  Future<List<BirdSpecies>> calculateTotalScore() async {
    Map<String, BirdSpecies> consolidatedList = {};

    for (var bird in birdSpeciesList) {
      int? score = await getScore(bird.name);
      if (score != null) {
        bird.numCorrect = score;
      }
    }

    for (var species in birdSpeciesList) {
      if (!consolidatedList.containsKey(species.name)) {
        consolidatedList[species.name] = BirdSpecies(
          name: species.name,
          image: species.image,
          image_easy: species.image_easy,
          image_body: species.image_body,
          image_head: species.image_head,
          image_medium: species.image_medium,
          numCorrect: species.numCorrect,
        );
      } else {
        consolidatedList[species.name]!.numCorrect += species.numCorrect;
      }
    }

    // Retorna a lista consolidada de espécies, ordenada pelo número de acertos
    var sortedList = consolidatedList.values.toList();
    sortedList.sort((a, b) => b.numCorrect.compareTo(a.numCorrect)); // Ordena do maior para o menor
    return sortedList;
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deseja zerar a pontuação?'),
          actions: <Widget>[
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                for (var bird in birdSpeciesList) {
                  await prefs.setInt(bird.name, 0);
                }
                Navigator.of(context).pop();

                // Forçando a atualização da tela
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [ // Adicione esta linha
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(context);
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
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
      body: FutureBuilder<List<BirdSpecies>>(
        future: calculateTotalScore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Erro ao carregar as pontuações."));
            }

            final totalScores = snapshot.data ?? [];

            return ListView.builder(
              itemCount: totalScores.length,
              itemBuilder: (context, index) {
                final species = totalScores[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
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
                              species.image_head,
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${species.name} (${species.numCorrect})',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator()); // Enquanto carrega, mostra um indicador de progresso
          }
        },
      ),
    );
  }
}
