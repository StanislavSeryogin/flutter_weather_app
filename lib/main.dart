import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/weather/weather_page_wrapper.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';

import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherRepository = WeatherRepositoryImpl(client: http.Client());

    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherPageWrapper(weatherRepository: weatherRepository),
      //home: const WelcomePage(),
    );
  }
}

