part of 'geo_weather_bloc.dart';

abstract class GeoWeatherEvent extends Equatable {
  const GeoWeatherEvent();
}

class FetchGeoWeatherEvent extends GeoWeatherEvent {
  @override
  List<Object> get props => [];
}
