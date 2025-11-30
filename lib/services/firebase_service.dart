import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // --------------------------
  // GUARDAR TEMPERATURA
  // --------------------------
  Future<void> guardarLecturaTemperatura(double valor) async {
    await db.collection("lecturasTemperatura").add({
      "valor": valor,
      "fecha": DateTime.now(),
    });
  }

  // --------------------------
  // LEER UMBRAL DE USUARIO
  // --------------------------
  Future<double> obtenerUmbral(String userId) async {
    DocumentSnapshot doc = await db.collection("users").doc(userId).get();
    if (doc.exists && doc["umbral"] != null) {
      return (doc["umbral"] as num).toDouble();
    }
    return 0; // si no existe tomamos 0
  }

  // --------------------------
  // GUARDAR ALERTA
  // --------------------------
  Future<void> guardarAlerta(String mensaje, double temperatura) async {
    await db.collection("alertasGeneradas").add({
      "mensaje": mensaje,
      "temperatura": temperatura,
      "fecha": DateTime.now(),
    });
  }

  // --------------------------
  // ACTUALIZAR UMBRAL
  // --------------------------
  Future<void> actualizarUmbral(String userId, double nuevoUmbral) async {
    await db.collection("users").doc(userId).update({
      "umbral": nuevoUmbral,
    });
  }
}
