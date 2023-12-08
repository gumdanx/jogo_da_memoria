import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/models/bird_species.dart';

class Game extends StatefulWidget {
  final int? numberOfSpecies;
  final String? title; // difficulty
                      // Outros parâmetros conforme necessário

  Game({this.numberOfSpecies, this.title});

  @override
    _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<bool> disabled = [];
  List<BirdSpecies> data = [];
  List<bool> opened = [];
  int? firstIndex;
  int? secondIndex;
  Timer? gameTimer;
  GameState gameState = GameState.paused; 
  Duration timeLeft = Duration(minutes: 0);
  bool showingInitialCards = true;

  @override
    void initState() {
      super.initState();
      initializeGame();
      setupTimer();
      gameState = GameState.playing;
    }

  void initializeGame() {
    bool useHeads = false;
    timeLeft = Duration(seconds: 120 + widget.numberOfSpecies!);
    if(widget.numberOfSpecies == 9) {
      useHeads = (Random().nextInt(2) == 0);
    }
    var shuffledBirds = birdSpeciesList..shuffle();
    data.addAll(shuffledBirds.take(widget.numberOfSpecies!));
    for (var bird in data) {
      bird.image = getBirdImage(bird, useHeads);
    }
    data = data + List.from(data);
    data.shuffle();

    // Inicialmente, todas as cartas são abertas
    opened = List<bool>.filled(data.length * 2, false); // Multiplicado por 2, se necessário
    disabled = List<bool>.filled(data.length * 2, false);

    // Após 2 segundos, todas as cartas são fechadas
    Future.delayed(Duration(seconds: widget.numberOfSpecies!), () {
      setState(() {
        opened = List<bool>.filled(data.length, true);
        showingInitialCards = false;
      });
    });
  }


  String getBirdImage(BirdSpecies bird, bool useHeads) {
    switch (widget.numberOfSpecies) {
      case 4: // Fácil
        return bird.image_easy;
      case 6: // Médio
        return bird.image_medium;
      default: // Difícil
        return useHeads ? bird.image_head : bird.image_body;
    }
  }

  void setupTimer() {
    gameTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timeLeft == Duration.zero) {
        timer.cancel();
        setState(() {
          gameState = GameState.finished;
          showCompletionDialog("Tempo Esgotado", "O tempo acabou! Tente novamente.");
        });
      } else {
        setState(() {
          timeLeft = timeLeft - Duration(seconds: 1);
        });
      }
    });
  }


  void resetGame() {
    if (gameTimer != null && gameTimer!.isActive) {
      gameTimer!.cancel();
    }
    setState(() {
        data.clear();
        opened = List<bool>.filled(data.length * 2, false);
        disabled = List<bool>.filled(data.length * 2, false);
        firstIndex = null;
        secondIndex = null;
        initializeGame();
        setupTimer();
        gameState = GameState.playing;
    });
  }

  void openCard(int index) {
    if (index >= disabled.length || index >= opened.length) {
      return;
    }

    // Impede a alteração do estado das cartas durante a exibição inicial
    if (showingInitialCards || gameState != GameState.playing || disabled[index]) {
      return;
    }

    bool isFirstCard = firstIndex == null;
    bool isSecondCard = secondIndex == null && index != firstIndex;

    if (isFirstCard) {
      firstIndex = index;
      updateCardOpenStatus(index, false);
    } else if (isSecondCard) {
      secondIndex = index;
      updateCardOpenStatus(index, false);
      checkForMatch();
    }

    if (isGameCompleted()) {
      if (gameState == GameState.playing) {
        setState(() {
          gameState = GameState.finished;
          showCompletionDialog("Parabéns!", "Você concluiu o jogo!");
        });
      }
    }
  }

  void updateCardOpenStatus(int index, bool isOpen) {
    setState(() {
        opened[index] = isOpen;
        });
  }

  void checkForMatch() {
    if (data[firstIndex!].name != data[secondIndex!].name) {
      resetCardsAfterDelay();
    } else {
      markCardsAsMatched();
    }
  }

  void resetCardsAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
        setState(() {
            opened[firstIndex!] = true;
            opened[secondIndex!] = true;
            resetSelection();
            });
        });
  }

  void markCardsAsMatched() {
    data[firstIndex!].incrementCorrect();
    setState(() {
        disabled[firstIndex!] = true;
        disabled[secondIndex!] = true;
        resetSelection();
        });
  }

  void resetSelection() {
    firstIndex = null;
    secondIndex = null;
  }

  bool isGameCompleted() {
    bool completed = firstIndex == null && secondIndex == null && !opened.contains(true);
    if (completed && gameState == GameState.playing) {
      if (gameTimer != null && gameTimer!.isActive) {
        gameTimer!.cancel();
      }
      setState(() {
        gameState = GameState.finished;
        showCompletionDialog("Parabéns!", "Você concluiu o jogo!");
      });
    }
    return completed;
  }


  void showCompletionDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title, style: TextStyle(color: Colors.blue.shade900),),
          content: Text(content, style: TextStyle(color: Colors.blue.shade900),),
          actions: [
            TextButton(
              child: Text('Jogar novamente', style: TextStyle(color: Colors.white),),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // Cor de fundo do botão
              ),
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

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
    Widget build(BuildContext context) {
      int crossAxisCount = getCrossAxisCount();

      return Scaffold(
          appBar: AppBar(
            title: gameState == GameState.playing 
              ? Text(
                formatDuration(timeLeft),
              style: TextStyle(
                color: timeLeft.inSeconds > 120
                    ? Colors.red
                    : Colors.white, // Cor vermelha se o tempo for maior que 120 segundos
              ),
              ) 
              : Text(
                widget.title!,
                style: TextStyle(color: Colors.white),
              ),
            centerTitle: true,
            actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: resetGame,
              tooltip: "Reiniciar o jogo",
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
        body: GridView.builder(
            padding: EdgeInsets.all(20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.0,
              mainAxisSpacing: 7.0,
              crossAxisSpacing: 7.0,
              ),
            itemCount: data.length,
            itemBuilder: (context, index) {
            return buildCard(index);
            },
            ),
        );
    }

  int getCrossAxisCount() {
    switch (widget.numberOfSpecies) {
      case 4: // Fácil
        return 2;
      case 6: // Médio
        return 3;
      case 8: // Difícil
        return 4;
      default:
        return 3; // Valor padrão para outras configurações
    }
  }

  Widget buildCard(int index) {
    return GestureDetector(
      onTap: () => openCard(index),
      child: Container(
        color: opened[index] ? Color(0xFFBBD2EC) : Colors.white,
          child: Center(
            child: opened[index]
            ? Image.asset(vito, fit: BoxFit.cover) // Verso da carta
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset(
                data[index].image, // Frente da carta
                fit: BoxFit.contain,
              ),
              // Você pode adicionar mais elementos aqui, se necessário
            ],
          ),
        ),
      ),
    );
  }
}

enum GameState { playing, paused, finished }