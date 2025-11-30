import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class UmbralTemperaturePage extends StatefulWidget {
  final double temperaturaActual;

  const UmbralTemperaturePage({
    super.key,
    required this.temperaturaActual,
  });

  @override
  State<UmbralTemperaturePage> createState() => _UmbralTemperaturePageState();
}

class _UmbralTemperaturePageState extends State<UmbralTemperaturePage> {
  double tempMin = 20;
  double tempMax = 30;

  @override
  void initState() {
    super.initState();
    _cargarUmbral();
  }

  Future<void> _cargarUmbral() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      tempMin = prefs.getDouble('tempMin') ?? 20;
      tempMax = prefs.getDouble('tempMax') ?? 30;
    });

    _verificarUmbral();
  }

  Future<void> _guardarUmbral() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tempMin', tempMin);
    await prefs.setDouble('tempMax', tempMax);

    _verificarUmbral();
  }

  void _verificarUmbral() {
    double temp = widget.temperaturaActual;

    if (temp < tempMin || temp > tempMax) {
      NotificationService.showNotification(
        title: "Alerta de temperatura",
        body:
            "Temperatura fuera del rango: $temp°C (Umbral: $tempMin°C - $tempMax°C)",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // fondo negro
      appBar: AppBar(
        title: const Text(
          "Umbral de temperatura",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Temperatura actual:",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.temperaturaActual}°C",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: (widget.temperaturaActual < tempMin ||
                        widget.temperaturaActual > tempMax)
                    ? Colors.redAccent
                    : Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Configura el rango permitido:",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            RangeSlider(
              values: RangeValues(tempMin, tempMax),
              min: 0,
              max: 50,
              divisions: 50,
              activeColor: const Color.fromARGB(255, 255, 95, 2),
              inactiveColor: Colors.white24,
              labels: RangeLabels(
                "${tempMin.toStringAsFixed(0)}°C",
                "${tempMax.toStringAsFixed(0)}°C",
              ),
              onChanged: (values) {
                setState(() {
                  tempMin = values.start;
                  tempMax = values.end;
                });
              },
              onChangeEnd: (values) {
                _guardarUmbral();
              },
            ),
            const SizedBox(height: 10),
            Text(
              "Umbral: ${tempMin.toStringAsFixed(0)}°C - ${tempMax.toStringAsFixed(0)}°C",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 244, 100, 4),
                side: const BorderSide(color: Colors.white, width: 1),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _guardarUmbral();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Umbral guardado correctamente"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                "Guardar cambios",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
