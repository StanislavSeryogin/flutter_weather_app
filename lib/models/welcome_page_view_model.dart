import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/combine_weather_page.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

class WelcomePageViewModel {
  final BuildContext context;
  final weatherRepository = WeatherRepositoryImpl(client: http.Client());

  WelcomePageViewModel({required this.context});

  void init() {
    Future.delayed(const Duration(seconds: 2), navigateToHomePage);
  }

  void navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CombinedWeatherPage(weatherRepository: weatherRepository)
      ),
    );
  }
}
