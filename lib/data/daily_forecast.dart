import 'package:intl/intl.dart';

class DailyForecast {
  final DateTime date;
  final String dayOfWeek;
  final String description;
  final double temperature;
  final double humidity;
  final String icon;

  DailyForecast({
    required this.date,
    required this.dayOfWeek,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.icon,
  });

  static DailyForecast fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      dayOfWeek: DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
      description: json['weather'][0]['description'],
      temperature: json['temp']['day'].toDouble(),
      humidity: json['humidity'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
