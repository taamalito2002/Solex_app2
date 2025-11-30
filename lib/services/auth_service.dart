import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // LOGIN
  Future<String> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Login exitoso";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Error desconocido";
    }
  }

  // REGISTRAR USUARIO
  Future<String> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Registro exitoso";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Error desconocido";
    }
  }

  // RECUPERAR CONTRASENA
  Future<String> recoverPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Se envio un correo para restablecer tu contrasena";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Error desconocido";
    }
  }
}
