import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/daily_forecast.dart';
import 'package:flutter_weather_app/data/weather_data.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'geo_weather_event.dart';
part 'geo_weather_state.dart';

class GeoWeatherBloc extends Bloc<GeoWeatherEvent, GeoWeatherState> {
  final WeatherRepository weatherRepository;

  GeoWeatherBloc(this.weatherRepository) : super(GeoWeatherInitialState()) {
    on<FetchGeoWeatherEvent>(fetchWeatherAndForecast);
  }

  Future<void> fetchWeatherAndForecast(FetchGeoWeatherEvent event, Emitter<GeoWeatherState> emit) async {
    emit(GeoWeatherLoadingState());
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      
      WeatherData weather = await weatherRepository.fetchCurrentLocationWeather(currentPosition);
      List<DailyForecast> forecast = await weatherRepository.fetchCurrentLocationForecast(currentPosition);
      
      emit(GeoWeatherLoadedState(weather, forecast));
    } catch (e) {
      emit(GeoWeatherErrorState(e.toString()));
    }
  }
}

 








