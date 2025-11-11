import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    // Animacion (fade-in)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Espera 4 segundos y navega a la pantalla de bienvenida
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Escalado relativo al tamano de la pantalla
    double logoSize = width * 0.55;
    double fontSize = width * 0.08;
    double spacing = height * 0.03;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo con opacidad
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              'assets/images/fondoamanecer.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Animacion de aparicion
          FadeTransition(
            opacity: _fadeIn,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo adaptable
                  Image.asset(
                    'assets/images/solex_logo.png',
                    width: logoSize,
                  ),

                  SizedBox(height: spacing),

                  // Texto de la app adaptable
                  Text(
                    "SOLEX_APP",
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: spacing),

                  // Indicador de carga elegante
                  SizedBox(
                    width: width * 0.08,
                    height: width * 0.08,
                    child: const CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                      strokeWidth: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
