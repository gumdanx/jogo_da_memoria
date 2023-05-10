import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/main_menu.dart';

class PlayHard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
