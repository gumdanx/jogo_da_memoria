import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  Widget _buildBirdList() {
    birdSpeciesList.sort((a, b) => b.numCorrect.compareTo(a.numCorrect));
    return ListView.builder(
      itemCount: birdSpeciesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(birdSpeciesList[index].name),
          subtitle: Text('${birdSpeciesList[index].numCorrect} acertos'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildBirdList(),
    );
  }
}
