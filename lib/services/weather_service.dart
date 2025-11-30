import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey = "2bf37db5d23780226eeef1b2a6982495";

  // 🔹 Obtener el clima usando el nombre de la ciudad
  Future<Map<String, dynamic>?> getWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city,CO&appid=$apiKey",
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


  Future<Map<String, dynamic>?> getWeatherByLocation() async {
    try {

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


  Map<String, dynamic> _parseWeatherData(dynamic data) {
    return {
      "temp": data["main"]["temp"].toDouble(),
      "humidity": data["main"]["humidity"].toInt(),
      "wind": data["wind"]["speed"].toDouble() * 3.6, 
      "description": data["weather"][0]["description"],
      "city": data["name"],
    };
  }
}
