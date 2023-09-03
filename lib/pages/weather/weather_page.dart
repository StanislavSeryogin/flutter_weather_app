// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_weather_app/data/weather_data.dart';
// import 'package:flutter_weather_app/repository/weather_repository.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:intl/intl.dart';

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({super.key});

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//  final TextEditingController _cityController = TextEditingController();
//   Map<String, dynamic>? _weatherData;
//   Map<String, dynamic>? _forecastData;
//   String apiKey = 'bb7f17a8b8d4851f643f47e6049edd89';
//   String weather = 'clear';
//    final weatherRepository = WeatherRepositoryImpl(client: http.Client());

//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrentLocationWeather();
//   }

 

// _fetchCityWeather() async {
//     try {
//         WeatherData weatherData = await weatherRepository.fetchCityWeather(_cityController.text);
//         setState(() {
//             _weatherData = weatherData;
//         });
//     } catch (e) {
//         print('Failed to fetch city weather: $e');
//     }
// }

// _fetchCurrentLocationWeather() async {
//    try {
//         WeatherData weatherData = await weatherRepository.fetchCurrentLocationWeather(_cityController.text);
//         setState(() {
//             _weatherData = weatherData;
//         });
//     } catch (e) {
//         print('Failed to fetch city weather: $e');
//     }
// }


// //  Future<String?> _fetchCurrentLocationWeather() async {
// //   try {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       return 'Location services are disabled.';
// //     }

// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         return 'Location permissions are denied';
// //       }
// //     }

// //     if (permission == LocationPermission.deniedForever) {
// //       return 'Location permissions are permanently denied, we cannot request permissions.';
// //     }

// //     Position position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high);

// //     final urlGeo = 'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';
// //     final urlForecast = 'http://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=hourly,minutely&appid=$apiKey&units=metric';

// //     final response = await http.get(Uri.parse(urlGeo));
// //     if (response.statusCode != 200) {
// //       return 'Failed to fetch weather data.';
// //     }

// //     final responseForecast = await http.get(Uri.parse(urlForecast));
// //     if (responseForecast.statusCode != 200) {
// //       return 'Failed to fetch forecast data.';
// //     }

// //     setState(() {
// //       _weatherData = json.decode(response.body);
// //       _forecastData = json.decode(responseForecast.body);
// //       weather = _weatherData!['weather'][0]['main'].toLowerCase();
// //     });

// //     return null; // return null if everything went fine
// //   } catch (e) {
// //     if (kDebugMode) {
// //       print("Error: $e");
// //     }
// //     return 'Failed to fetch current location weather.';
// //   }
// // }


//   // _fetchCityWeather() async {
//   //   const apiKey = 'bb7f17a8b8d4851f643f47e6049edd89';
//   //   final city = _cityController.text;

//   //   // Get city's latitude and longitude using the weather endpoint
//   //   final weatherUrl =
//   //       'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

//   //   var weatherResponse = await http.get(Uri.parse(weatherUrl));

//   //   if (weatherResponse.statusCode == 200) {
//   //     _weatherData = json.decode(weatherResponse.body);

//   //     final lat = _weatherData!['coord']['lat'];
//   //     final lon = _weatherData!['coord']['lon'];

//   //     final forecastUrl =
//   //         'http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&units=metric';

//   //     var forecastResponse = await http.get(Uri.parse(forecastUrl));

//   //     if (forecastResponse.statusCode == 200) {
//   //       setState(() {
//   //         _forecastData = json.decode(forecastResponse.body);
//   //         weather = _weatherData!['weather'][0]['main'].toLowerCase();
//   //       });
//   //     } else {
//   //       throw Exception('Failed to load forecast data for $city');
//   //     }
//   //   } else {
//   //     throw Exception('Failed to load weather data for $city');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     if (_weatherData != null && _forecastData!['daily'] != null) {
//       return DecoratedBox(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/$weather.png'),
//             fit: BoxFit.cover,
//             alignment: Alignment.center,
//           ),
//         ),
//         child: Scaffold(
          
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 40),
//                 TextField(
//                   controller: _cityController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter City Name',
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: _fetchCityWeather,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 if (_weatherData != null)
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           "${_weatherData!['name']}",
//                           style: const TextStyle(
//                               fontSize: 32, fontWeight: FontWeight.bold),
//                         ),
//                         Image.network(
//                           'http://openweathermap.org/img/w/${_weatherData!['weather'][0]['icon']}.png',
//                           scale: 0.5,
//                         ),
//                         Text(
//                           "${_weatherData!['main']['temp']}°C",
//                           style: const TextStyle(fontSize: 24),
//                         ),
//                         Text("Humidity: ${_weatherData!['main']['humidity']}%"),
//                         Text(
//                             "Min: ${_weatherData!['main']['temp_min']}°C  Max: ${_weatherData!['main']['temp_max']}°C"),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 const SizedBox(height: 20),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _forecastData?['daily']?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final item = _forecastData!['daily'][index];
//                       final date = DateTime.fromMillisecondsSinceEpoch(
//                           item['dt'] * 1000);

//                       final imageUrl =
//                           'http://openweathermap.org/img/w/${item['weather'][0]['icon']}.png';

//                       return ListTile(
//                         title: Row(
//                           children: [
//                             Image.network(
//                               imageUrl,
//                               scale: 0.5,
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(DateFormat('EEEE, d MMMM').format(date)),
//                                   Text('${item['temp']['day']}°C'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         trailing: Text(item['weather'][0]['description']),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//     return const Center(
//         child: CircularProgressIndicator(
//       color: Colors.white,
//     ));
//   }
// }