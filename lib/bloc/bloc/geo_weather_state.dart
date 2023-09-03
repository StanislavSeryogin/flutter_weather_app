part of 'geo_weather_bloc.dart';

abstract class GeoWeatherState extends Equatable {
  const GeoWeatherState();
}

class GeoWeatherInitialState extends GeoWeatherState {
  @override
  List<Object> get props => [];
}

class GeoWeatherLoadingState extends GeoWeatherState {
  @override
  List<Object> get props => [];
}

class GeoWeatherLoadedState extends GeoWeatherState {
  final WeatherData weather;
  final List<DailyForecast> forecast;

  GeoWeatherLoadedState(this.weather, this.forecast);

  @override
  List<Object> get props => [weather, forecast];
}

class GeoWeatherErrorState extends GeoWeatherState {
  final String message;

  GeoWeatherErrorState(this.message);

  @override
  List<Object> get props => [message];
}
