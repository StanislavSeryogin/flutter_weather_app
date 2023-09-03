import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/bloc/geo_weather_bloc.dart';
import 'package:flutter_weather_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';

class CombinedWeatherScreen extends StatefulWidget {
  const CombinedWeatherScreen({super.key, required this.weatherRepository});
  final WeatherRepository weatherRepository;

  @override
  State<CombinedWeatherScreen> createState() => _CombinedWeatherScreenState();
}

class _CombinedWeatherScreenState extends State<CombinedWeatherScreen> {
CityWeatherBloc? _cityWeatherBloc;
  GeoWeatherBloc? _geoWeatherBloc;
  TextEditingController cityController = TextEditingController();
  bool _showGeoWeather = true;

  @override
  void initState() {
    super.initState();
    _cityWeatherBloc = CityWeatherBloc(widget.weatherRepository);
    _geoWeatherBloc = GeoWeatherBloc(widget.weatherRepository);
    _geoWeatherBloc!.add(FetchGeoWeatherEvent()); // Fetching the weather for the current location on screen load
  }

  Widget _buildGeoWeather() {
  return BlocBuilder<GeoWeatherBloc, GeoWeatherState>(
    builder: (context, state) {
      if (state is GeoWeatherLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GeoWeatherLoadedState) {
        return Expanded(child: buildWeatherList(state.weather, state.forecast));
      } else if (state is GeoWeatherErrorState) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    },
  );
}

Widget _buildCityWeather() {
  return BlocBuilder<CityWeatherBloc, CityWeatherState>(
    builder: (context, state) {
      if (state is CityWeatherLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is CityWeatherLoadedState) {
        return Expanded(child: buildWeatherList(state.weather, state.forecast));
      } else if (state is CityWeatherErrorState) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    },
  );
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Weather Forecast')),
    body: MultiBlocProvider(
      providers: [
        BlocProvider<CityWeatherBloc>(create: (context) => _cityWeatherBloc!),
        BlocProvider<GeoWeatherBloc>(create: (context) => _geoWeatherBloc!),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _cityWeatherBloc!.add(FetchWeatherForCityEvent(cityController.text));
                    setState(() {
                      _showGeoWeather = false;
                    });
                  },
                  child: Text('Search City'),
                ),
              ],
            ),
          ),
          _showGeoWeather ? _buildGeoWeather() : _buildCityWeather(),
        ],
      ),
    ),
  );
}


  Widget buildWeatherList(weather, List forecast) {
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text(weather.city),
            subtitle: Text(weather.description),
            trailing: Text('${weather.temperature}°C'),
            leading: Image.network(
              'http://openweathermap.org/img/w/${weather.icon}.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
        ...forecast.map((forecast) => ListTile(
              leading: Image.network(
                'http://openweathermap.org/img/w/${forecast.icon}.png',
                width: 50,
                height: 50,
              ),
              title: Text(forecast.dayOfWeek),
              subtitle: Text(forecast.description),
              trailing: Text('${forecast.temperature}°C'),
            ))
      ],
    );
  }

  @override
  void dispose() {
    _cityWeatherBloc!.close();
    _geoWeatherBloc!.close();
    super.dispose();
  }
}