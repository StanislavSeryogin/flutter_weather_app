import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/weather_data.dart';
import 'package:flutter_weather_app/utilities/constants.dart';

class BuildWeatherList extends StatelessWidget {
  const BuildWeatherList({
    super.key,
    required this.weather,
    required this.forecast,
  });

  final WeatherData weather;
  final List forecast;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            weather.city,
            style: kCityNameTextStyle,
          ),
          Image.network(
            'http://openweathermap.org/img/w/${weather.icon}.png',
            width: 50,
            height: 50,
          ),
          Text(weather.description),
          Text('${weather.temperature}°C'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final item = forecast[index];
              return SizedBox(
                width: 150,
                child: Card(
                  color: Colors.white10,
                  elevation: 0,
                  child: ListTile(
                    leading: Image.network(
                      'http://openweathermap.org/img/w/${item.icon}.png',
                      width: 50,
                      height: 50,
                    ),
                    title: Text(item.dayOfWeek),
                    subtitle: Text(item.description),
                    trailing: Column(
                      children: [
                        Text('${item.temperature}°C'),
                        Text('${item.humidity}%'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
