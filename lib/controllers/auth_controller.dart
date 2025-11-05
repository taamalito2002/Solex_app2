import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() => _instance;
  AuthController._internal();

  final AuthService _authService = AuthService();

  String register(String email, String password) {
    bool success = _authService.register(User(email: email, password: password));
    return success ? "Registro exitoso" : "El email ya está registrado";
  }

  String login(String email, String password) {
    bool success = _authService.login(email, password);
    return success ? "Login exitoso" : "Email o contraseña incorrectos";
  }

  // Añadir este método dentro de la clase AuthController
String recoverPassword(String email) {
  // Verifica si existe el usuario
  bool exists = _authService.usersExist(email); // método que crearemos en AuthService
  if (!exists) return "Email no encontrado";

  // Simulamos envío de correo
  return "Se ha enviado un correo para recuperar la contraseña a $email";
}

}
