import 'package:flutter/material.dart';
import 'views/splash_screen.dart';
import 'views/welcome_page.dart';
import 'views/login_page.dart';
import 'views/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLEX_APP',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      // Pantalla inicial
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
