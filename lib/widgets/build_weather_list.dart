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
          const SizedBox(height: 20),
          Text(
            weather.city,
            style: kCityNameTextStyle,
          ),
          Image.asset(
            'assets/icons/${weather.description.replaceAll(' ', '').toLowerCase()}.png',
            width: 150,
            height: 150,
          ),
          Text(
            weather.description,
            style: kMainDescriptionTextStyle,
          ),
          Text(
            '${weather.temperature}°C',
            style: kMainDescriptionTextStyle,
          ),
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
                    title: Text(
                      item.dayOfWeek,
                      style: kMainListTextStyle,
                    ),
                    subtitle: Text(
                      item.description,
                      style: kTitleListTextStile,
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          '${item.temperature}°C',
                          style: kMainListTextStyle,
                        ),
                        Text(
                          '${item.humidity}%',
                          style: kTitleListTextStile,
                        ),
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
