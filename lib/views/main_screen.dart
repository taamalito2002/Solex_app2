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
  double? _temperature; // 🔥 guardamos la temperatura actual

  void _onTemperatureChanged(double temp) {
    setState(() {
      _temperature = temp;
    });
  }

  void _onTap(int idx) => setState(() => _selected = idx);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onTemperatureChanged: _onTemperatureChanged),
      const HistoryPage(),
      AdvicePage(temperature: _temperature ?? 0),

    ];

    return Scaffold(
      body: pages[_selected],
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
