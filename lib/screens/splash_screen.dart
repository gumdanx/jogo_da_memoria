import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Define a largura do container para ocupar toda a tela
        height: double.infinity, // Define a altura do container para ocupar toda a tela
        child: Image.asset(
          tropibio,
          fit: BoxFit.cover, // Faz a imagem preencher completamente o espaço do container
        ),
      ),
    );
  }
}
