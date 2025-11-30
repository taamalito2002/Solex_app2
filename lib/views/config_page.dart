import 'package:flutter/material.dart';
import 'UmbralTemperature_page.dart';
import 'notifications_page.dart';
import 'login_page.dart';

class ConfigPage extends StatelessWidget {
  final double temperaturaActual;

  const ConfigPage({super.key, required this.temperaturaActual});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      appBar: AppBar(
        title: const Text(
          "Configuración",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ----------------------------
                // UMBRAL DE TEMPERATURA
                // ----------------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.thermostat, color: Colors.orangeAccent),
                    title: const Text(
                      "Umbral de temperatura",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UmbralTemperaturePage(
                            temperaturaActual: temperaturaActual,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // ----------------------------
                // NOTIFICACIONES
                // ----------------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.notifications_active,
                        color: Colors.yellowAccent),
                    title: const Text(
                      "Notificaciones",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ----------------------------
          // BOTON DE CERRAR SESION
          // ----------------------------
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.white, width: 1), // borde blanco
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Cerrar sesión",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey.shade900,
                      title: const Text("Confirmación",
                          style: TextStyle(color: Colors.white)),
                      content: const Text(
                        "¿Seguro que deseas cerrar sesión?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Cerrar sesión",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
