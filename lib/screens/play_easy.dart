import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';
import 'package:jogo_da_memoria/models/cards.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/screens/main_menu.dart';

class PlayEasy extends StatefulWidget {
  const PlayEasy({Key? key}) : super(key: key);

  @override
  _PlayEasyState createState() => _PlayEasyState();
}

class _PlayEasyState extends State<PlayEasy> {
  late List<BirdSpecies> _species;
  late List<int> _positions;
  late int _selectedIdx;
  bool _isFirstSelection = true;
  bool _isMatching = false;
  late int _numMatches;

  @override
  void initState() {
    super.initState();
    _species = List<BirdSpecies>.from(birdSpeciesList);
    _positions = List<int>.generate(6, (index) => index);
    _positions.shuffle();
    _selectedIdx = -1;
    _numMatches = 0;
  }

  void _onTap(int index) {
    if (_isMatching) {
      return;
    }
    if (_isFirstSelection) {
      setState(() {
        _selectedIdx = index;
        _isFirstSelection = false;
      });
    } else {
      setState(() {
        _isMatching = true;
      });
      if (_species[_positions[_selectedIdx]].name ==
          _species[_positions[index]].name) {
        setState(() {
          _numMatches++;
        });
        _species[_positions[_selectedIdx]].numCorrect++;
        _isFirstSelection = true;
        if (_numMatches == 3) {
          // start over
          _numMatches = 0;
          _species.sort((a, b) => a.numCorrect.compareTo(b.numCorrect));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PlayEasy(),
            ),
          );
        }
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstSelection = true;
            _isMatching = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
            );
          },
        ),
        title: Text('Jogo da Memória'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Cards(
                  birdSpecies: _species[_positions[index]],
                  isFlipped: _isFirstSelection ? false : _selectedIdx == index,
                  onTap: () => _onTap(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}