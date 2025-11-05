import 'package:flutter/material.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'advice_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selected = 0;

  final List<Widget> _pages = [
    const HomePage(),     // tu pantalla del clima
    const HistoryPage(),  // historial semanal (vacío por ahora)
    const AdvicePage(),   // consejos (vacío por ahora)
  ];

  void _onTap(int idx) => setState(() => _selected = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected,
        onTap: _onTap,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.tips_and_updates), label: 'Consejos'),
        ],
      ),
    );
  }
}
