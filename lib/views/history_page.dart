import 'package:flutter/material.dart';
import '../services/history_service.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = HistoryService.getHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial del dia"),
        backgroundColor: Colors.deepPurple,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "No hay registros todavia",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];
                final date = DateFormat('HH:mm a').format(record["date"]);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: const Icon(Icons.thermostat, color: Colors.white),
                    ),
                    title: Text(
                      "${record["temp"]?.toStringAsFixed(1)} °C - ${record["description"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ciudad: ${record["city"]}"),
                          Text("Humedad: ${record["humidity"]} %"),
                          Text("Viento: ${record["wind"]} km/h"),
                          Text("Hora: $date"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
