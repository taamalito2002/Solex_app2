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
  double? _temperature;

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
      backgroundColor: Colors.black, // 🖤 Fondo negro
      body: pages[_selected],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // 🖤 Fondo negro en el menú
        currentIndex: _selected,
        onTap: _onTap,
        
        selectedItemColor: Colors.white,    // 🤍 Íconos activos en blanco
        unselectedItemColor: Colors.white70, // 🤍 Íconos inactivos en blanco suave
        
        type: BottomNavigationBarType.fixed, // evita animaciones raras

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates),
            label: 'Consejos',
          ),
        ],
     ),
);
}
}