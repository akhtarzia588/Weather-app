class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windspeed;
  final int sunset;
  final int sunrise;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.windspeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num) - 273.15,
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      windspeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
