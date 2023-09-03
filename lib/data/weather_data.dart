class WeatherData {
  final String city;
  final String description;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final String icon;

  WeatherData({
    required this.city,
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.icon,
  });

  static WeatherData fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      description: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      maxTemperature: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
    );
  }
}
