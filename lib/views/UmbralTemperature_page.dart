import 'package:flutter/material.dart';
import '../services/umbral_service.dart';

class UmbralTemperaturePage extends StatefulWidget {
  final double temperaturaActual;

  const UmbralTemperaturePage({super.key, required this.temperaturaActual});

  @override
  State<UmbralTemperaturePage> createState() => _UmbralTemperaturePageState();
}

class _UmbralTemperaturePageState extends State<UmbralTemperaturePage> {
  double? umbral;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarUmbral();
  }

  Future<void> cargarUmbral() async {
    final valor = await UmbralService.getUmbral();
    setState(() {
      umbral = valor;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Configurar umbral", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Umbral actual",
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "${umbral?.toStringAsFixed(1)} °C",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            Slider(
              value: umbral!,
              min: 10,
              max: 60,
              divisions: 50,
              activeColor: Colors.orangeAccent,
              onChanged: (value) {
                setState(() {
                  umbral = value;
                });
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () async {
                  await UmbralService.setUmbral(umbral!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Umbral guardado correctamente"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Guardar umbral",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
