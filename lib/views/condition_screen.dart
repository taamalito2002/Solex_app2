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
        const SnackBar(content: Text('Por favor activa la ubicación')),
      );
      setState(() => loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso de ubicación denegado')),
        );
        setState(() => loading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de ubicación denegado permanentemente')),
      );
      setState(() => loading = false);
      return;
    }

    // ✅ Guardar que ya aceptó los términos y permisos
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('accepted_conditions', true);

    setState(() => loading = false);

    // ✅ Redirigir al Home solo una vez aceptado
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
Bienvenido a SOLEX_APP.

Al continuar, aceptas nuestros términos y condiciones de uso.
Esto incluye la autorización para usar tu ubicación con el fin de
mostrarte información personalizada, calcular rutas o identificar
tu posición en el mapa. Tus datos no serán compartidos con terceros.

Por favor, lee detenidamente antes de continuar.
                  ''',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: accepted,
                  onChanged: (v) => setState(() => accepted = v ?? false),
                  activeColor: Colors.deepPurple,
                ),
                const Expanded(
                  child: Text(
                    'Acepto los términos y condiciones y el uso de mi ubicación',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: accepted && !loading ? _requestLocationPermission : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
