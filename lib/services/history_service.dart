class HistoryService {
  static final List<Map<String, dynamic>> _history = [];

  static void addWeatherRecord(Map<String, dynamic> data) {
    final record = {
      "city": data["city"],
      "temp": data["temp"],
      "humidity": data["humidity"],
      "wind": data["wind"],
      "description": data["description"],
      "date": DateTime.now(),
    };

    _history.add(record);
  }

  static List<Map<String, dynamic>> getHistory() => _history.reversed.toList();
}
