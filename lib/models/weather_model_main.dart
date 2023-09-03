class WeatherModelMain {
  final double temp;
  final double tempMax;
  final double tempMin;

  WeatherModelMain({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
  });

  factory WeatherModelMain.fromJson(Map<String, dynamic> json) {
    return WeatherModelMain(
      temp: json['temp'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
    );
  }
}
