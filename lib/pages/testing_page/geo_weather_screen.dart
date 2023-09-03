// In geo_weather_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/bloc/geo_weather_bloc.dart';

class GeoWeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final geoWeatherBloc = BlocProvider.of<GeoWeatherBloc>(context);

    geoWeatherBloc.add(FetchGeoWeatherEvent());

    return BlocBuilder<GeoWeatherBloc, GeoWeatherState>(
      builder: (context, state) {
        if (state is GeoWeatherLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GeoWeatherLoadedState) {
          return Scaffold(
            appBar: AppBar(title: Text('Geo Weather')),
            body: BlocBuilder<GeoWeatherBloc, GeoWeatherState>(
              builder: (context, state) {
                if (state is GeoWeatherLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GeoWeatherLoadedState) {
                  return Column(
                    children: [
                      Text(
                          "Today's Weather in ${state.weather.city}: ${state.weather.temperature}°C"), // Replace 'temperature' with actual property name
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.forecast.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${state.forecast[index].dayOfWeek}: ${state.forecast[index].temperature}°C"),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is GeoWeatherErrorState) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text("Fetching weather..."));
              },
            ),
          );
        } else if (state is GeoWeatherErrorState) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text("Fetching weather..."));
      },
    );
  }
}
