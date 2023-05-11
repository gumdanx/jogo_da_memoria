import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/main_menu.dart' as mainMenu;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => mainMenu.MainMenu()),
      );
    });

    return Container(
      color: Colors.white,
      child: Image.asset('assets/images/logo_tropibio.png'),
    );
  }
}
