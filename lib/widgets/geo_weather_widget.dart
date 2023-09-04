import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/geo_weather/geo_weather_bloc.dart';
import 'package:flutter_weather_app/widgets/build_weather_list.dart';

class GeoWeatherWidget extends StatelessWidget {
  const GeoWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoWeatherBloc, GeoWeatherState>(
      builder: (context, state) {
        if (state is GeoWeatherLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GeoWeatherLoadedState) {
          return BuildWeatherList(
            weather: state.weather,
            forecast: state.forecast,
          );
        } else if (state is GeoWeatherErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}