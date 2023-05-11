import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/splash_screen.dart' as splashScreen;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Memória',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashScreen.SplashScreen(),
    );
  }
}
