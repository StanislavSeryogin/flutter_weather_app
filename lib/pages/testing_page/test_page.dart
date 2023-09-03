import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/daily_forecast.dart';
import 'package:flutter_weather_app/data/weather_data.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';

import 'package:http/http.dart' as http;

class WeatherForecastPage extends StatefulWidget {
  final WeatherRepository weatherRepository;

  WeatherForecastPage({required this.weatherRepository});

  @override
  _WeatherForecastPageState createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  WeatherData? _weatherData;
  List<DailyForecast>? _forecastData;
  TextEditingController _cityController = TextEditingController();
  final weatherRepository = WeatherRepositoryImpl(client: http.Client());

  _fetchWeatherForCity() async {
    try {
      WeatherData weather =
          await widget.weatherRepository.fetchCityWeather(_cityController.text);
      List<DailyForecast> forecast = await widget.weatherRepository
          .fetchCityForecast(_cityController.text);
      setState(() {
        _weatherData = weather;
        _forecastData = forecast;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Forecast')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _fetchWeatherForCity,
                  child: Text('Fetch Weather'),
                ),
              ],
            ),
          ),
          if (_weatherData != null)
            Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '${_weatherData!.city}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Image.network(
                      'http://openweathermap.org/img/w/${_weatherData!.icon}.png',
                      width: 50,
                      height: 50,
                    ),
                    Text('${_weatherData!.temperature}°C'),
                    Text(_weatherData!.description),
                  ],
                ),
              ),
            ),
          if (_forecastData != null)
            Expanded(
              child: ListView.builder(
                itemCount: _forecastData!.length,
                itemBuilder: (context, index) {
                  final dailyForecast = _forecastData![index];
                  return ListTile(
                    leading: Image.network(
                      'http://openweathermap.org/img/w/${dailyForecast.icon}.png',
                      width: 50,
                      height: 50,
                    ),
                    title: Text(dailyForecast.dayOfWeek),
                    subtitle: Text(dailyForecast.description),
                    trailing: Text('${dailyForecast.temperature}°C'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
