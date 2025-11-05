import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey = "54c4d18f820b30293be9dbd0992f8c1c";

  // 🔹 Obtener el clima usando el nombre de la ciudad
  Future<Map<String, dynamic>?> getWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city,CO&appid=$apiKey&units=metric&lang=es",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseWeatherData(data);
      } else {
        print("Error en la API: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // 🔹 Obtener el clima usando la ubicación actual
  Future<Map<String, dynamic>?> getWeatherByLocation() async {
    try {
      // Verificar permisos de ubicación
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("El GPS está desactivado.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permiso de ubicación denegado.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Permisos de ubicación bloqueados permanentemente.");
      }

      // Obtener posición actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Llamar a la API con latitud y longitud
      final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&lang=es",
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseWeatherData(data);
      } else {
        print("Error en la API: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error obteniendo ubicación: $e");
      return null;
    }
  }

  // 🔹 Método auxiliar para parsear la respuesta
  Map<String, dynamic> _parseWeatherData(dynamic data) {
    return {
      "temp": data["main"]["temp"].toDouble(),
      "humidity": data["main"]["humidity"].toInt(),
      "wind": data["wind"]["speed"].toDouble() * 3.6, // m/s → km/h
      "description": data["weather"][0]["description"],
      "city": data["name"],
    };
  }
}
