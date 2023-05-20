// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// Versão com animação
import 'package:jogo_da_memoria/models/bird_species.dart';

class Cards extends StatefulWidget {
  final BirdSpecies birdSpecies;
  final bool isFlipped;
  final VoidCallback onTap;

  const Cards({
    Key? key,
    required this.birdSpecies,
    required this.isFlipped,
    required this.onTap,
  }) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _frontRotation =
        Tween<double>(begin: 0, end: -1).animate(_animationController);
    _backRotation =
        Tween<double>(begin: 1, end: 0).animate(_animationController);
    flipCard(isFlipped: widget.isFlipped);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void flipCard({required bool isFlipped}) {
    if (isFlipped) {
      if (_animationController.status != AnimationStatus.completed) {
        _animationController.forward();
      }
    } else {
      if (_animationController.status != AnimationStatus.dismissed) {
        _animationController.reverse();
      }
    }
    _isFrontVisible = !isFlipped;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          final double rotation =
              _isFrontVisible ? _frontRotation.value : _backRotation.value;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(rotation * 0.5 * 3.1415926535897932),
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: _isFrontVisible
                  ? const Center(
                      child: Text(
                        '🐦',
                        style: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          widget.birdSpecies.image,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          widget.birdSpecies.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
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
