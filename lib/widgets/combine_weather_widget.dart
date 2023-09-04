import 'package:flutter/material.dart';
import 'package:flutter_weather_app/widgets/city_weather_widget.dart';
import 'package:flutter_weather_app/widgets/geo_weather_widget.dart';
import 'package:flutter_weather_app/widgets/input_city_name_text_field.dart';

class CombineWeatherWidget extends StatelessWidget {
  const CombineWeatherWidget(
      {super.key,
      required this.textEditingController,
      required this.inputCityNamePressed,
      required this.iconButtonGeoPressed,
      required this.showGeoWeather});

  final TextEditingController textEditingController;
  final VoidCallback inputCityNamePressed;
  final VoidCallback iconButtonGeoPressed;
  final bool showGeoWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 70, right: 16),
          child: Row(
            children: [
              Expanded(
                child: InputCityNameTextField(
                    textEditingController: textEditingController,
                    cityNamePressed: inputCityNamePressed),
              ),
              IconButton(
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: iconButtonGeoPressed,
              ),
            ],
          ),
        ),
        Expanded(
          child: showGeoWeather
              ? const GeoWeatherWidget()
              : const CityWeatherWidget(),
        ),
      ],
    );
  }
}
