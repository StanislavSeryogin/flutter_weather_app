part of 'city_weather_bloc.dart';


abstract class CityWeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CityWeatherInitialState extends CityWeatherState {}

class CityWeatherLoadingState extends CityWeatherState {}

class CityWeatherLoadedState extends CityWeatherState {
  final WeatherData weather;
  final List<DailyForecast> forecast;

  CityWeatherLoadedState(this.weather, this.forecast);

  @override
  List<Object?> get props => [weather, forecast];
}

class CityWeatherErrorState extends CityWeatherState {
  final String message;

  CityWeatherErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
