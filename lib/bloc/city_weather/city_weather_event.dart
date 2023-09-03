part of 'city_weather_bloc.dart';

abstract class CityWeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeatherForCityEvent extends CityWeatherEvent {
  final String cityName;

  FetchWeatherForCityEvent(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
