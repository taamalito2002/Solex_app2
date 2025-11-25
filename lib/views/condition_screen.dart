import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConditionsScreen extends StatefulWidget {
  const ConditionsScreen({super.key});

  @override
  State<ConditionsScreen> createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  bool accepted = false;
  bool loading = false;

  Future<void> _requestLocationPermission() async {
    setState(() => loading = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor activa la ubicacion')),
      );
      setState(() => loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso de ubicacion denegado')),
        );
        setState(() => loading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe activar permisos desde ajustes')),
      );
      setState(() => loading = false);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('accepted_conditions', true);

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo
          Image.asset(
            'assets/images/Fondo_Oscuro.png',
            fit: BoxFit.cover,
          ),

          // Capa con blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                // -------------------------------
                //  LOGO IZQUIERDA + SOLEX CENTRADO
                // -------------------------------
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: -20,
                        child: Image.asset(
                          'assets/images/solex_logo.png',
                          height: 150,
                          width: 150,
                        ),
                      ),
                      const Text(
                        "SOLEX",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Caja oscura grande
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),

                    child: Column(
                      children: [
                        const Text(
                          "Terminos y Condiciones",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Expanded(
                          child: SingleChildScrollView(
                            child: const Text(
                              '''
Bienvenido(a) a SOLEX.

Para ofrecerle un servicio eficiente, la aplicacion:

• Mide la temperatura y humedad para favorecer su comodidad.
• Utiliza su ubicacion para brindar pronosticos precisos.
• Envia notificaciones sobre los mejores momentos para ventilar, descansar y concentrarse.

Privacidad:
Sus datos se emplean exclusivamente para mejorar su experiencia y no se comparten con terceros.

Al continuar, usted acepta estos terminos y autoriza el uso de notificaciones y ubicacion.
                              ''',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Checkbox(
                              value: accepted,
                              onChanged: (v) =>
                                  setState(() => accepted = v ?? false),
                              activeColor: const Color(0xFFFF7F32),
                              checkColor: Colors.white,
                            ),
                            const Expanded(
                              child: Text(
                                "Acepto los terminos y condiciones",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: accepted && !loading
                                ? _requestLocationPermission
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7F32),
                              disabledBackgroundColor:
                                  Colors.orange.withOpacity(0.35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Continuar",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
