import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String result = _authController.login(
      _emailController.text,
      _passwordController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    if (result == "Login exitoso") {
  Navigator.pushReplacementNamed(context, '/main');
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
        );
      },
      child: const Text("¿Olvidaste tu contraseña?"),
    ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text("Crear cuenta"),
            ),
            
          ],
        ),
      ),
    );
  }
}
