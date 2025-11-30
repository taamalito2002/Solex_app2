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

  // Iconos según la temperatura
  IconData _getIconForTemp(double temp) {
    if (temp < 15) return Icons.ac_unit;       // Copo de nieve
    if (temp < 25) return Icons.wb_sunny;     // Sol
    if (temp < 32) return Icons.thermostat;   // Termostato
    return Icons.warning_amber;               // Alerta
  }

  // Color según temperatura
  Color _getIconColor(double temp) {
    if (temp < 15) return Colors.cyanAccent;       // Copo de nieve - azul
    if (temp < 25) return Colors.yellowAccent;     // Sol - amarillo
    if (temp < 32) return Colors.orangeAccent;     // Termostato - naranja
    return Colors.redAccent;                       // Alerta - rojo
  }

  List<String> getDefaultAdvices(double temp) {
    if (temp < 15) {
      return [
        "Mantente abrigado para trabajar cómodamente en casa.",
        "Si te da frío, realiza pausas activas para calentar el cuerpo.",
        "Evita trabajar cerca de ventanas abiertas para no enfriarte.",
        "Una bebida caliente te ayudará a mantener energía."
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
        "Evita usar aparatos que generen más calor."
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

  Widget _buildCard(String advice, IconData icon,
      {bool isUser = false, double? temp}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUser
              ? [Colors.grey.shade900, Colors.grey.shade800]
              : [Colors.black87, Colors.black54],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isUser
                  ? Colors.deepPurpleAccent
                  : _getIconColor(temp ?? 0),
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                advice,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final advices = getDefaultAdvices(widget.temperature);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Consejos y Recomendaciones",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Temperatura actual: ${widget.temperature.toStringAsFixed(1)} °C",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                "Consejos del día:",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              ...advices.map(
                (advice) => _buildCard(advice, _getIconForTemp(widget.temperature),
                    temp: widget.temperature),
              ),
              const Divider(height: 40, color: Colors.white24),
              const Text(
                "Crea tus propios consejos:",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _adviceController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Escribe un consejo",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: addUserAdvice,
                icon: const Icon(Icons.add),
                label: const Text("Agregar Consejo"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 5, 5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.white, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (userAdvices.isNotEmpty)
                const Text(
                  "Tus consejos personalizados:",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              const SizedBox(height: 10),
              ...userAdvices.map(
                (advice) => _buildCard(advice, Icons.person, isUser: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
