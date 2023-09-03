import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/bloc/geo_weather_bloc.dart';
import 'package:flutter_weather_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:flutter_weather_app/pages/testing_page/geo_weather_screen.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';

class WeatherPageWrapper extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WeatherPageWrapper({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityWeatherBloc>(
          create: (context) => CityWeatherBloc(weatherRepository),
        ),
        BlocProvider<GeoWeatherBloc>(
          create: (context) => GeoWeatherBloc(weatherRepository),
        ),
      ],
      child: GeoWeatherScreen(),
    );
  }
}
