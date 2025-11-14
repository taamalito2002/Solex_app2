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
    setState(() {
      _loading = true;
      _error = null;
    });

    final data = await _service.getWeatherByLocation();
    if (data != null) {
      _applyData(data);
    } else {
      final fallback = await _service.getWeather(_city);
      if (fallback != null) {
        _applyData(fallback);
      } else {
        setState(() {
          _loading = false;
          _error = "No se pudo obtener el clima.";
        });
      }
    }
  }

  // ================================
  //      AQUI ESTA LA PARTE BUENA
  // ================================
  void _applyData(Map<String, dynamic> data) {
    setState(() {
      _city = data['city'];
      _temp = data['temp'];
      _humidity = data['humidity'];
      _wind = data['wind'];
      _description = data['description'];
      _loading = false;
    });

    // 1️⃣ Enviar la temperatura al MainScreen
    if (_temp != null) {
      widget.onTemperatureChanged(_temp!);
    }

    // 2️⃣ Guardar TODO el clima en el historial
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
      appBar: AppBar(
        title: const Text('Clima actual'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
                ? Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Ciudad: $_city",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Temperatura: ${_temp?.toStringAsFixed(1)} °C",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Humedad: ${_humidity ?? '--'} %",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Viento: ${_wind?.toStringAsFixed(1)} km/h",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Pronostico: $_description",
                        style: const TextStyle(fontSize: 18),
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
    );
  }
}
