import 'package:flutter/material.dart';

class AdvicePage extends StatefulWidget {
  final double? currentTemperature; // 🌡 Recibe la temperatura desde el MainScreen

  const AdvicePage({super.key, this.currentTemperature});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  List<String> userAdvices = [];
  final TextEditingController _adviceController = TextEditingController();

  // 🔹 Consejos automáticos según la temperatura actual
  List<String> getDefaultAdvices(double temp) {
    if (temp < 15) {
      return [
        "Abrígate bien, podría hacer más frío durante la noche.",
        "Toma bebidas calientes para mantener tu temperatura corporal.",
        "Evita salir sin chaqueta.",
        "Aprovecha para descansar y mantenerte en lugares cálidos."
      ];
    } else if (temp < 25) {
      return [
        "Temperatura agradable, ideal para actividades al aire libre.",
        "Mantente hidratado durante el día.",
        "Usa ropa cómoda y ligera.",
        "Evita exponerte demasiado al sol del mediodía."
      ];
    } else if (temp < 32) {
      return [
        "Evita el sol directo entre las 11 a.m. y 3 p.m.",
        "Usa protector solar y gorra.",
        "Bebe mucha agua.",
        "Busca sombra si estás al aire libre."
      ];
    } else {
      return [
        "Temperaturas muy altas, limita la exposición al sol.",
        "Evita actividades físicas intensas al aire libre.",
        "Permanece en lugares ventilados o con sombra.",
        "Rehidrátate constantemente."
      ];
    }
  }

  // 🔹 Agregar consejos personalizados
  void addUserAdvice() {
    if (_adviceController.text.isNotEmpty) {
      setState(() {
        userAdvices.add(_adviceController.text);
        _adviceController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final temp = widget.currentTemperature;
    final advices = temp != null ? getDefaultAdvices(temp) : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Consejos y Recomendaciones"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                temp == null
                    ? "Esperando datos del clima..."
                    : "Temperatura actual: ${temp.toStringAsFixed(1)}°C",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Consejos del día:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (temp != null)
                ...advices.map((advice) => ListTile(
                      leading: const Icon(Icons.lightbulb, color: Colors.amber),
                      title: Text(advice),
                    ))
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "No hay temperatura disponible aún. Revisa la pestaña de Inicio.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              const Divider(height: 40),
              const Text(
                "Crea tus propios consejos:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _adviceController,
                decoration: const InputDecoration(
                  labelText: "Escribe un consejo",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: addUserAdvice,
                icon: const Icon(Icons.add),
                label: const Text("Agregar Consejo"),
              ),
              const SizedBox(height: 20),
              if (userAdvices.isNotEmpty)
                const Text(
                  "Tus consejos personalizados:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ...userAdvices.map((advice) => ListTile(
                    leading: const Icon(Icons.person, color: Colors.green),
                    title: Text(advice),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
