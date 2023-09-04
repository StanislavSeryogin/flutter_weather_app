import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/repository/weather_repository.dart';
import 'package:flutter_weather_app/widgets/combine_weather_widget.dart';

import '../bloc/bloc_export.dart';

class CombinedWeatherPage extends StatefulWidget {
  final WeatherRepository weatherRepository;

  const CombinedWeatherPage({Key? key, required this.weatherRepository})
      : super(key: key);

  @override
  State<CombinedWeatherPage> createState() => _CombinedWeatherPageState();
}

class _CombinedWeatherPageState extends State<CombinedWeatherPage> {
  late CityWeatherBloc _cityWeatherBloc;
  late GeoWeatherBloc _geoWeatherBloc;
  late BackgroundImageBloc _backgroundImageBloc;
  final TextEditingController cityController = TextEditingController();
  bool _showGeoWeather = true;

  @override
  void initState() {
    super.initState();
    _cityWeatherBloc = CityWeatherBloc(widget.weatherRepository);
    _geoWeatherBloc = GeoWeatherBloc(widget.weatherRepository);
    _backgroundImageBloc = BackgroundImageBloc();
    _geoWeatherBloc.add(FetchGeoWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityWeatherBloc>(create: (context) => _cityWeatherBloc),
        BlocProvider<GeoWeatherBloc>(create: (context) => _geoWeatherBloc),
        BlocProvider<BackgroundImageBloc>(
            create: (context) => _backgroundImageBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CityWeatherBloc, CityWeatherState>(
            listener: (context, state) {
              if (state is CityWeatherLoadedState) {
                context.read<BackgroundImageBloc>().add(
                      UpdateBackgroundImage(state.weather.description),
                    );
              }
            },
          ),
          BlocListener<GeoWeatherBloc, GeoWeatherState>(
            listener: (context, state) {
              if (state is GeoWeatherLoadedState) {
                context.read<BackgroundImageBloc>().add(
                      UpdateBackgroundImage(state.weather.description),
                    );
              }
            },
          ),
        ],
        child: BlocBuilder<BackgroundImageBloc, BackgroundImageState>(
          builder: (context, state) {
            return Stack(fit: StackFit.expand, children: [
              const DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: DecoratedBox(
                  key: ValueKey<String>(state.imagePath),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(state.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: CombineWeatherWidget(
                      showGeoWeather: _showGeoWeather,
                      textEditingController: cityController,
                      inputCityNamePressed: () {
                        _cityWeatherBloc
                            .add(FetchWeatherForCityEvent(cityController.text));
                        setState(() => _showGeoWeather = false);
                        cityController.clear();
                      },
                      iconButtonGeoPressed: () {
                        _geoWeatherBloc.add(FetchGeoWeatherEvent());
                        setState(() => _showGeoWeather = true);
                      },
                    ),
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityWeatherBloc.close();
    _geoWeatherBloc.close();
    _backgroundImageBloc.close();
    super.dispose();
  }
}
