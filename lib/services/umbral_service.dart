import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UmbralService {
  double umbral = 28.0; // Puedes cambiarlo desde ConfigPage

  // Inicializamos el plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  UmbralService() {
    _initNotifications();
  }

  void actualizarUmbral(double nuevo) {
    umbral = nuevo;
  }

  Future<void> verificarUmbral(double temperatura) async {
    if (temperatura > umbral) {
      await _enviarNotificacionAlerta(temperatura);
    }
  }

  // Configuracion inicial
  void _initNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _enviarNotificacionAlerta(double temperatura) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alertas', // id del canal
      'Alertas de temperatura', // nombre del canal
      channelDescription: 'Notificaciones de alerta cuando la temperatura supera el umbral',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1,
      'Alerta de temperatura',
      'La temperatura actual es ${temperatura.toStringAsFixed(1)} °C y supera el umbral de $umbral °C.',
      platformChannelSpecifics,
      payload: 'alerta_temperatura',
    );
  }
}
