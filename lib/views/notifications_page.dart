import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // fondo negro
      appBar: AppBar(
        title: const Text(
          "Notificaciones",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1), // borde blanco
        ),
        child: ListTile(
          title: const Text(
            "Activar notificaciones",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Switch(
            value: notificationsEnabled,
            activeColor: const Color.fromARGB(255, 0, 0, 0), // color del thumb
            activeTrackColor: const Color.fromARGB(255, 236, 236, 236), // track
            inactiveThumbColor: Colors.white24,
            inactiveTrackColor: Colors.white10,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
