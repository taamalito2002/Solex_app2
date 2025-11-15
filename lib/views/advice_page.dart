import 'package:flutter/material.dart';

class AdvicePage extends StatefulWidget {
  final double temperature;

  const AdvicePage({super.key, required this.temperature});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  List<String> userAdvices = [];
  final TextEditingController _adviceController = TextEditingController();

  @override
  void didUpdateWidget(covariant AdvicePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.temperature != widget.temperature) {
      setState(() {});
    }
  }

  // Iconos segun la temperatura
  IconData _getIconForTemp(double temp) {
    if (temp < 15) return Icons.ac_unit; // Frio
    if (temp < 25) return Icons.wb_sunny; // Templado
    if (temp < 32) return Icons.thermostat; // Calor moderado
    return Icons.warning_amber; // Mucho calor
  }

  // Consejos adaptados para personas que trabajan en casa
  List<String> getDefaultAdvices(double temp) {
    if (temp < 15) {
      return [
        "Mantente abrigado para trabajar comodamente en casa.",
        "Si te da frio, realiza pausas activas para calentar el cuerpo.",
        "Evita trabajar cerca de ventanas abiertas para no enfriarte.",
        "Una bebida caliente te ayudara a mantener energia."
      ];
    } else if (temp < 25) {
      return [
        "Clima agradable para mantener la productividad.",
        "Aprovecha para ventilar tu espacio de trabajo.",
        "Mantente hidratado mientras trabajas.",
        "Organiza pausas cortas para estirarte."
      ];
    } else if (temp < 32) {
      return [
        "Evita trabajar cerca del sol directo en ventanas.",
        "Usa ropa ligera para mayor comodidad.",
        "Toma agua constantemente mientras trabajas.",
        "Ventila el lugar o usa un ventilador si es posible."
      ];
    } else {
      return [
        "Temperatura muy alta, evita actividades intensas en casa.",
        "Mantente en un espacio ventilado mientras trabajas.",
        "Hidrata constantemente para evitar agotamientos.",
        "Evita usar aparatos que generen mas calor."
      ];
    }
  }

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
    final advices = getDefaultAdvices(widget.temperature);

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
              // Titulo
              Text(
                "Temperatura actual: ${widget.temperature.toStringAsFixed(1)} °C",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),
              const Text(
                "Consejos del dia:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // Consejos predeterminados en Cards
              ...advices.map(
                (advice) => Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          _getIconForTemp(widget.temperature),
                          color: Colors.deepPurple,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            advice,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Divider(height: 40),

              // Crear consejos
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

              // Consejos personalizados
              ...userAdvices.map(
                (advice) => Card(
                  color: Colors.green.shade50,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.person, color: Colors.green, size: 26),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            advice,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
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
