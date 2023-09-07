import 'package:flutter_weather_app/data/daily_forecast.dart';
import 'package:flutter_weather_app/data/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class WeatherRepository {
  Future<WeatherData> fetchCityWeather(String city);
  Future<WeatherData> fetchCurrentLocationWeather(Position position);
  Future<List<DailyForecast>> fetchCityForecast(String city);
  Future<List<DailyForecast>> fetchCurrentLocationForecast(Position position);
}

class WeatherRepositoryImpl implements WeatherRepository {
  final String apiKey = 'bb7f17a8b8d4851f643f47e6049edd89';
  final http.Client client;

  WeatherRepositoryImpl({required this.client});

  @override
  Future<WeatherData> fetchCityWeather(String city) async {
    final url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data for $city');
    }
  }

  @override
  Future<WeatherData> fetchCurrentLocationWeather(Position position) async {
    final url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch weather data.');
    }
  }

  @override
  Future<List<DailyForecast>> fetchCityForecast(String city) async {
    final weatherUrl = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    final weatherResponse = await client.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Failed to load weather data for $city');
    }

    final weatherData = json.decode(weatherResponse.body);
    final lat = weatherData['coord']['lat'];
    final lon = weatherData['coord']['lon'];

    final forecastUrl = Uri.parse(
        'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&units=metric');

    final forecastResponse = await client.get(forecastUrl);

    if (forecastResponse.statusCode == 200) {
      var jsonData = json.decode(forecastResponse.body);
      var dailyForecastList = jsonData['daily'] as List;
      return dailyForecastList
          .map((data) => DailyForecast.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load forecast data for $city');
    }
  }

  @override
  Future<List<DailyForecast>> fetchCurrentLocationForecast(
      Position position) async {
    final urlForecast = Uri.parse(
        'http://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=hourly,minutely&appid=$apiKey&units=metric');
    final response = await client.get(urlForecast);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var dailyForecastList = jsonData['daily'] as List;
      return dailyForecastList
          .map((data) => DailyForecast.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to fetch forecast data.');
    }
  }
}
