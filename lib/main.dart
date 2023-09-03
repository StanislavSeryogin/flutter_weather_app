import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? _weatherData;
  Map<String, dynamic>? _forecastData;
  String apiKey = 'bb7f17a8b8d4851f643f47e6049edd89';

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  _fetchCurrentLocationWeather() async {
    const apiKey = 'bb7f17a8b8d4851f643f47e6049edd89';
    try {
      // Check if the location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location services are disabled.')),
        );
        return;
      }

      // Check for permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permissions are denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Location permissions are permanently denied, we cannot request permissions.')),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final urlGeo =
          'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';

      final urlForecast =
          'http://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=hourly,minutely&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(urlGeo));
      final responseForecast = await http.get(Uri.parse(urlForecast));

      setState(() {
        _weatherData = json.decode(response.body);
        _forecastData = json.decode(responseForecast.body);
        print(responseForecast.body);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch current location weather.')),
      );
    }
  }

  _fetchCityWeather() async {
    const apiKey = 'bb7f17a8b8d4851f643f47e6049edd89';
    final city = _cityController.text;

    // Get city's latitude and longitude using the weather endpoint
    final weatherUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    var weatherResponse = await http.get(Uri.parse(weatherUrl));

    if (weatherResponse.statusCode == 200) {
      _weatherData = json.decode(weatherResponse.body);

      // Use city's lat and lon to fetch forecast using the onecall endpoint
      final lat = _weatherData!['coord']['lat'];
      final lon = _weatherData!['coord']['lon'];

      final forecastUrl =
          'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&units=metric';

      var forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (forecastResponse.statusCode == 200) {
        setState(() {
          _forecastData = json.decode(forecastResponse.body);
          print(forecastResponse.body);
        });
      } else {
        throw Exception('Failed to load forecast data for $city');
      }
    } else {
      throw Exception('Failed to load weather data for $city');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchCityWeather,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_weatherData != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "${_weatherData!['name']}",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Image.network(
                      'http://openweathermap.org/img/w/${_weatherData!['weather'][0]['icon']}.png',
                      scale: 0.5,
                    ),
                    Text(
                      "${_weatherData!['main']['temp']}°C",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text("Humidity: ${_weatherData!['main']['humidity']}%"),
                    Text(
                        "Min: ${_weatherData!['main']['temp_min']}°C  Max: ${_weatherData!['main']['temp_max']}°C"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: _forecastData != null && _forecastData!['daily'] != null
                  ? ListView.builder(
                      itemCount: _forecastData?['daily']?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = _forecastData!['daily'][index];
                        final date = DateTime.fromMillisecondsSinceEpoch(
                            item['dt'] * 1000);

                        final imageUrl =
                            'http://openweathermap.org/img/w/${item['weather'][0]['icon']}.png';

                        return ListTile(
                          title: Row(
                            children: [
                              Image.network(
                                imageUrl,
                                scale: 0.5,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat('EEEE, d MMMM')
                                        .format(date)),
                                    Text('${item['temp']['day']}°C'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(item['weather'][0]['description']),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
