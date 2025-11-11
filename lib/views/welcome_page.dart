import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de pantalla
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Escalas relativas
    double logoSize = width * 0.45;
    double titleFont = width * 0.07;
    double subtitleFont = width * 0.065;
    double descFont = width * 0.045;
    double buttonFont = width * 0.055;
    double buttonPaddingV = height * 0.025;
    double buttonPaddingH = width * 0.25;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondoamanecer.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5), // Capa oscura para contraste
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),

              // Logo adaptable
              Image.asset(
                'assets/images/solex_logo.png',
                width: logoSize,
              ),

              SizedBox(height: height * 0.04),

              // Texto "Bienvenido a"
              Text(
                "Bienvenido a",
                style: TextStyle(
                  fontSize: titleFont,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: height * 0.04),

              // Subtítulo
              Text(
                "La app meteorológica más confiable",
                style: TextStyle(
                  fontSize: subtitleFont,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: height * 0.06),

              // Texto descriptivo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Text(
                  "Tu aliado para mantener un ambiente cómodo y productivo.",
                  style: TextStyle(
                    fontSize: descFont,
                    color: Colors.white70,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(flex: 2),

              // Botón "Comenzar"
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.08),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: buttonPaddingH,
                      vertical: buttonPaddingV,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 8,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Comenzar",
                    style: TextStyle(
                      fontSize: buttonFont,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
