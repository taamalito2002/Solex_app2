import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() => _instance;
  AuthController._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================================
  //   REGISTRAR USUARIO
  // ================================
  Future<String> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "OK";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") return "El correo ya existe";
      if (e.code == "invalid-email") return "Correo invalido";
      if (e.code == "weak-password") return "Contrasena muy debil";
      return "Error desconocido";
    }
  }

  // ================================
  //   LOGIN USUARIO
  // ================================
  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "OK";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") return "Usuario no existe";
      if (e.code == "wrong-password") return "Contrasena incorrecta";
      if (e.code == "invalid-email") return "Correo invalido";
      return "Error desconocido";
    }
  }

  // ================================
  //   RECUPERAR CONTRASENA
  // ================================
  Future<String> recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "OK";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") return "El correo no existe";
      if (e.code == "invalid-email") return "Correo invalido";
      return "Error desconocido";
    }
  }
}
