import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherDisplay extends StatelessWidget {
  final GeoWeatherModel weatherModel;

  const WeatherDisplay({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            weatherModel.name,
            style: const TextStyle(fontSize: 30),
          ),
          Image.network(
            'http://openweathermap.org/img/w/${weatherModel.icon}.png',
            scale: 0.5,
          ),
          Text(
            '${weatherModel.main.temp.toStringAsFixed(0)}°',
            style: const TextStyle(fontSize: 50),
          ),
          Text(
            'Max: ${weatherModel.main.tempMax.toStringAsFixed(0)}°  Min: ${weatherModel.main.tempMin.toStringAsFixed(0)}°',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            'Humidity: ${weatherModel.humidity}%',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            'Day: ${DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(weatherModel.dt * 1000))}',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
