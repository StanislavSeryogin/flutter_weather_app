// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_weather_app/bloc/bloc/geo_weather_bloc.dart';
// import 'package:flutter_weather_app/bloc/city_weather/city_weather_bloc.dart';
// import 'package:flutter_weather_app/pages/combine_weather_page.dart';
// import 'package:flutter_weather_app/repository/weather_repository.dart';

// class CombineWeatherPageWraper extends StatelessWidget {
//   final WeatherRepository weatherRepository;
//   final ValueNotifier<String> _backgroundImageNotifier = ValueNotifier<String>('assets/mist.jpg');

//   CombineWeatherPageWraper({Key? key, required this.weatherRepository}) : super(key: key);

//   String _getImagePathFromWeatherDescription(String? description) {
//     if (description == null) return 'assets/mist.jpg';
//     return 'assets/${description.replaceAll(' ', '').toLowerCase()}.jpg';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<CityWeatherBloc>(
//           create: (context) => CityWeatherBloc(weatherRepository),
//         ),
//         BlocProvider<GeoWeatherBloc>(
//           create: (context) => GeoWeatherBloc(weatherRepository),
//         ),
//       ],
//       child: MultiBlocListener(
//         listeners: [
//           BlocListener<CityWeatherBloc, CityWeatherState>(
//             listener: (context, state) {
//               if (state is CityWeatherLoadedState) {
//                 _backgroundImageNotifier.value = _getImagePathFromWeatherDescription(state.weather.description);
//               }
//             },
//           ),
//           BlocListener<GeoWeatherBloc, GeoWeatherState>(
//             listener: (context, state) {
//               if (state is GeoWeatherLoadedState) {
//                 _backgroundImageNotifier.value = _getImagePathFromWeatherDescription(state.weather.description);
//               }
//             },
//           ),
//         ],
//         child: ValueListenableBuilder(
//           valueListenable: _backgroundImageNotifier,
//           builder: (BuildContext context, String backgroundImage, Widget? child) {
//             return CombinedWeatherScreen(
//               weatherRepository: weatherRepository,
//               backgroundImage: backgroundImage,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
