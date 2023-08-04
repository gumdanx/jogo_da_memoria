import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/utils/globals.dart';
import 'package:jogo_da_memoria/screens/main_menu.dart';

class LogoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement( // Usamos pushReplacement para substituir a tela SplashScreen pela MainMenu
            context,
            MaterialPageRoute(builder: (context) => MainMenu()),
          );
        },
        child: Container(
          child: Image.asset(
            logos,
            fit: BoxFit.cover, // Faz a imagem preencher completamente o espaço do container
          ),
        ),
      ),
    );
  }
}
