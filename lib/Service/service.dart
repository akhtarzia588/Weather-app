import 'dart:convert';

import 'package:weather_app/models/models.dart';
import 'package:http/http.dart' as http;

class Service {
  final String apikey = '49d35455608a5b79a0f6a20fcb785493';

  Future<Weather> fetchweather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
