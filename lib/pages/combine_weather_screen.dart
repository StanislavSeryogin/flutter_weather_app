import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/bloc/geo_weather_bloc.dart';
import 'package:flutter_weather_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';
import 'package:flutter_weather_app/widgets/build_weather_list.dart';
import 'package:flutter_weather_app/widgets/input_city_name_text_field.dart';

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
  final ValueNotifier<String> _backgroundImageNotifier =
      ValueNotifier<String>('assets/mist.jpg');

  @override
  void initState() {
    super.initState();
    _cityWeatherBloc = CityWeatherBloc(widget.weatherRepository);
    _geoWeatherBloc = GeoWeatherBloc(widget.weatherRepository);
    _geoWeatherBloc!.add(FetchGeoWeatherEvent());
  }

  void _determineBackgroundImage(
      GeoWeatherState geoWeatherState, CityWeatherState cityWeatherState) {
    String? newImagePath;

    if (_showGeoWeather && geoWeatherState is GeoWeatherLoadedState) {
      newImagePath =
          'assets/${geoWeatherState.weather.description.replaceAll(' ', '').toLowerCase()}.jpg';
    } else if (!_showGeoWeather && cityWeatherState is CityWeatherLoadedState) {
      newImagePath =
          'assets/${cityWeatherState.weather.description.replaceAll(' ', '').toLowerCase()}.jpg';
    }

    if (newImagePath != null &&
        newImagePath != _backgroundImageNotifier.value) {
      _backgroundImageNotifier.value = newImagePath;
    }
  }

  Widget _buildGeoWeather() {
    return BlocBuilder<GeoWeatherBloc, GeoWeatherState>(
      builder: (context, state) {
        if (state is GeoWeatherLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GeoWeatherLoadedState) {
          return Expanded(
              child: BuildWeatherList(
                  weather: state.weather, forecast: state.forecast));
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is CityWeatherLoadedState) {
          return Expanded(
              child: BuildWeatherList(
                  weather: state.weather, forecast: state.forecast));
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityWeatherBloc>(create: (context) => _cityWeatherBloc!),
        BlocProvider<GeoWeatherBloc>(create: (context) => _geoWeatherBloc!),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CityWeatherBloc, CityWeatherState>(
            listener: (context, state) {
              _determineBackgroundImage(
                  context.read<GeoWeatherBloc>().state, state);
            },
          ),
          BlocListener<GeoWeatherBloc, GeoWeatherState>(
            listener: (context, state) {
              _determineBackgroundImage(
                  state, context.read<CityWeatherBloc>().state);
            },
          ),
        ],
        child: Builder(builder: (context) {
          return ValueListenableBuilder(
            valueListenable: _backgroundImageNotifier,
            builder:
                (BuildContext context, String backgroundImage, Widget? child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 70, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: InputCityNameTextField(
                                textEditingController: cityController,
                                voidCallback: () {
                                  _cityWeatherBloc!.add(
                                      FetchWeatherForCityEvent(
                                          cityController.text));
                                  // Debug information
                                  setState(() {
                                    _showGeoWeather = false;
                                  });
                                  cityController.clear();
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                _geoWeatherBloc!.add(FetchGeoWeatherEvent());
                                setState(() {
                                  _showGeoWeather = true;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      _showGeoWeather
                          ? _buildGeoWeather()
                          : _buildCityWeather(),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _cityWeatherBloc!.close();
    _geoWeatherBloc!.close();
    super.dispose();
  }
}
