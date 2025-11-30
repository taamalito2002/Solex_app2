import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/history_service.dart';
import 'config_page.dart';

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
    final size = MediaQuery.of(context).size;
    final circleSize = size.height * 0.4;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : _error != null
                ? Center(
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red, fontSize: 22),
                    ),
                  )
                : SingleChildScrollView(   // <<-- AQUI YA NO HABRA GLOW
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/solex_logo.png",
                                    height: 65,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "SOLEX",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings, color: Colors.white, size: 32),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConfigPage(
                                        temperaturaActual: _temp ?? 0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24, width: 1),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _city,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    letterSpacing: 1,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                Center(
                                  child: SizedBox(
                                    width: circleSize,
                                    height: circleSize,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/Simbolo.temperatura.png",
                                          fit: BoxFit.contain,
                                        ),
                                        Positioned(
                                          top: circleSize * 0.28,
                                          child: Text(
                                            "${_temp?.toStringAsFixed(1)}°C",
                                            style: const TextStyle(
                                              fontSize: 38,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: circleSize * 0.28,
                                          right: circleSize * 0.15,
                                          child: Image.asset(
                                            "assets/images/Nubes.sol.png",
                                            width: circleSize * 0.45,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                Column(
                                  children: [
                                    _infoRow("Humedad Actual", "${_humidity ?? "--"}%"),
                                    _divider(),
                                    _infoRow("Pronostico", _description ?? "--"),
                                    _divider(),
                                    _infoRow("Viento", "${_wind?.toStringAsFixed(1) ?? "--"} km/h"),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                ElevatedButton(
                                  onPressed: _loadWeather,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                                    side: const BorderSide(color: Colors.white24),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "ACTUALIZAR",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontFamily: "Montserrat",
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Montserrat",
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(color: Colors.white24, thickness: 1);
  }
}
