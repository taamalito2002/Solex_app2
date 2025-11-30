import 'package:flutter/material.dart';
import '../services/history_service.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = HistoryService.getHistory();

    return Scaffold(
      backgroundColor: Colors.black, // FONDO NEGRO
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------
            // LOGO + TEXTO SOLEX
            // ------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/solex_logo.png",
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "SOLEX",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------
            // TÍTULO "Historial del día"
            // ------------------------------
            const Center(
              child: Text(
                "Historial del día",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------
            // LISTA DE REGISTROS
            // ------------------------------
            Expanded(
              child: history.isEmpty
                  ? const Center(
                      child: Text(
                        "No hay registros todavía",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final record = history[index];
                        final date =
                            DateFormat('HH:mm a').format(record["date"]);

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[850], // tarjeta gris oscura
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            // Ícono de temperatura como en el código viejo
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                              child: const Icon(
                                Icons.thermostat,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              "${record["temp"]?.toStringAsFixed(1)} °C - ${record["description"]}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ciudad: ${record["city"]}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Humedad: ${record["humidity"]} %",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Viento: ${record["wind"]} km/h",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Hora: $date",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
