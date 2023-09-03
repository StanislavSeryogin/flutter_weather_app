import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';

class WeatherForecastScreen extends StatefulWidget {
  final WeatherRepository weatherRepository;

  WeatherForecastScreen({required this.weatherRepository, Key? key}) : super(key: key);

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  CityWeatherBloc? _weatherBloc;
  TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weatherBloc = CityWeatherBloc(widget.weatherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Forecast')),
      body: BlocProvider(
        create: (_) => _weatherBloc!,
        child: BlocBuilder<CityWeatherBloc, CityWeatherState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: 'Enter city',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _weatherBloc!.add(FetchWeatherForCityEvent(_cityController.text));
                        },
                        child: Text('Fetch Weather'),
                      ),
                    ],
                  ),
                ),
                if (state is CityWeatherLoadingState) Center(child: CircularProgressIndicator()),
                if (state is CityWeatherLoadedState) Expanded(
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(state.weather.city),
                          subtitle: Text(state.weather.description),
                          trailing: Text('${state.weather.temperature}°C'),
                          leading: Image.network(
                            'http://openweathermap.org/img/w/${state.weather.icon}.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      ...state.forecast.map((forecast) => ListTile(
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
                  ),
                ),
                if (state is CityWeatherErrorState) Center(child: Text(state.message)),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc!.close();
    super.dispose();
  }
}
