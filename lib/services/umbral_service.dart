import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UmbralService {
  static double umbralCache = 28.0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  UmbralService() {
    _initNotifications();
  }

  /// -------------------------------
  /// LEE el umbral desde Firestore
  /// -------------------------------
  static Future<double> getUmbral() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return umbralCache; // En caso de que no haya login
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists && doc.data()!.containsKey('umbral')) {
      umbralCache = (doc['umbral'] as num).toDouble();
    }

    return umbralCache;
  }

  /// -------------------------------
  /// GUARDA el umbral en Firestore
  /// -------------------------------
  static Future<void> setUmbral(double nuevoUmbral) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    umbralCache = nuevoUmbral;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(
      {'umbral': nuevoUmbral},
      SetOptions(merge: true),
    );
  }

  /// -------------------------------
  /// VERIFICAR UMBRAL CON NOTIFICACIONES
  /// -------------------------------
  Future<void> verificarUmbral(double temperatura) async {
    final umbral = await getUmbral();

    if (temperatura > umbral) {
      await _enviarNotificacionAlerta(temperatura, umbral);
    }
  }

  /// -------------------------------
  /// Inicializacion de notificaciones
  /// -------------------------------
  void _initNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// -------------------------------
  /// ENVIAR NOTIFICACION
  /// -------------------------------
  Future<void> _enviarNotificacionAlerta(
      double temperatura, double umbral) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'alertas',
      'Alertas de temperatura',
      channelDescription:
          'Notificaciones cuando la temperatura supera el umbral.',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notifDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      'Alerta de temperatura',
      'Temperatura: ${temperatura.toStringAsFixed(1)}°C (Umbral: $umbral°C)',
      notifDetails,
    );
  }
}
