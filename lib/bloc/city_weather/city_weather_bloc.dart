import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/daily_forecast.dart';
import 'package:flutter_weather_app/data/weather_data.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';

part 'city_weather_event.dart';
part 'city_weather_state.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final WeatherRepository weatherRepository;

  CityWeatherBloc(this.weatherRepository) : super(CityWeatherInitialState()) {
    on<FetchWeatherForCityEvent>(_handleFetchWeather);
  }

  Future<void> _handleFetchWeather(
    FetchWeatherForCityEvent event,
    Emitter<CityWeatherState> emit,
  ) async {
    emit(CityWeatherLoadingState());
    try {
      WeatherData weather =
          await weatherRepository.fetchCityWeather(event.cityName);
      List<DailyForecast> forecast =
          await weatherRepository.fetchCityForecast(event.cityName);
      emit(CityWeatherLoadedState(weather, forecast));
    } catch (e) {
      emit(CityWeatherErrorState(e.toString()));
    }
  }
}
