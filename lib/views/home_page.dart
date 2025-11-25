import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/history_service.dart';

class HomePage extends StatefulWidget {
  final Function(double) onTemperatureChanged;

  const HomePage({super.key, required this.onTemperatureChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _service = WeatherService();

  bool _loading = true;

  String _city = "Cali";
  double? _temp;
  int? _humidity;
  double? _wind;
  String? _description;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    if (!mounted) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    final data = await _service.getWeatherByLocation();

    if (!mounted) return;

    if (data != null) {
      _applyData(data);
    } else {
      final fallback = await _service.getWeather(_city);

      if (!mounted) return;

      if (fallback != null) {
        _applyData(fallback);
      } else {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _error = "No se pudo obtener el clima.";
        });
      }
    }
  }

  void _applyData(Map<String, dynamic> data) {
    if (!mounted) return;

    setState(() {
      _city = data['city'];
      _temp = data['temp'];
      _humidity = data['humidity'];
      _wind = data['wind'];
      _description = data['description'];
      _loading = false;
    });

    if (mounted && _temp != null) {
      widget.onTemperatureChanged(_temp!);
    }

    HistoryService.addWeatherRecord({
      "city": _city,
      "temp": _temp,
      "humidity": _humidity,
      "wind": _wind,
      "description": _description,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // si tienes un fondo, esto se puede quitar
      body: Stack(
        children: [

          // ----------------------
          // LOGO + NOMBRE ARRIBA IZQUIERDA
          // ----------------------
          Positioned(
            top: 20,
            left: -10,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/solex_logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(width: 4),
                const Text(
                  "SOLEX",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // ----------------------
          // CONTENIDO ORIGINAL DEL HOME
          // ----------------------
          Center(
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : _error != null
                    ? Text(
                        _error!,
                        style: const TextStyle(color: Colors.red, fontSize: 22),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Ciudad: $_city",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Temperatura: ${_temp?.toStringAsFixed(1)} °C",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Humedad: ${_humidity ?? '--'} %",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Viento: ${_wind?.toStringAsFixed(1)} km/h",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Pronostico: $_description",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _loadWeather,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text(
                              "Actualizar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
