import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:flutter_weather_app/widgets/build_weather_list.dart';

class CityWeatherWidget extends StatelessWidget {
  const CityWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityWeatherBloc, CityWeatherState>(
      builder: (context, state) {
        if (state is CityWeatherLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CityWeatherLoadedState) {
          return BuildWeatherList(
            weather: state.weather,
            forecast: state.forecast,
          );
        } else if (state is CityWeatherErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}