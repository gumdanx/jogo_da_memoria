import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jogo_da_memoria/screens/splash_screen.dart' as splashScreen;
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1280), // 9:16 ratio
      builder: () => MaterialApp(
        title: 'Jogo da Memória',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: splashScreen.SplashScreen(),
      ),
    );
  }
}
