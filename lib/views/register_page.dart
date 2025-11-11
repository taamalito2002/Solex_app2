import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'condition_screen.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    String result = _authController.register(
      _emailController.text,
      _passwordController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    if (result == "Registro exitoso") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ConditionsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
            ElevatedButton(onPressed: _register, child: const Text("Registrar")),
          ],
        ),
      ),
    );
  }
}
