import 'package:flutter_weather_app/models/weather_model_main.dart';
import 'package:intl/intl.dart';

class GeoWeatherModel {
  final WeatherModelMain main;
  final String icon;
  final String name;
  final int dt;
  final int humidity;

  GeoWeatherModel({
    required this.main,
    required this.icon,
    required this.name,
    required this.dt,
    required this.humidity,
  });

  factory GeoWeatherModel.fromJson(Map<String, dynamic> json) {
    return GeoWeatherModel(
      main: WeatherModelMain.fromJson(json['main'] ?? {}),
      icon: json['weather']?[0]['icon'] ?? '',
      name: json.containsKey('city') ? json['city']['name'] : json['name'],
      dt: json['dt'] ?? 0,
      humidity: json['main']['humidity'] ?? 0,
    );
  }

  String get day {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat('EEEE').format(date);
  }
}
