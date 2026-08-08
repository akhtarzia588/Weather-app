import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/models.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String formatTime(int timestamp) {
      final date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
      return DateFormat('hh : mm a').format(date);
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white38,
          ),

          //color: const Color.fromARGB(181, 255, 255, 255),
          margin: EdgeInsets.all(17),
          padding: EdgeInsets.all(17),
          child: Column(
            children: [
              Lottie.asset(
                weather.description == 'overcast clouds'
                    ? 'assets/cloudy-weather-animation.json'
                    : weather.description == 'sunny'
                    ? 'assets/sunny-weather-animation.json'
                    : weather.description == 'light rain'
                    ? 'assets/rainy-weather-animation.json'
                    : weather.description == 'clear sky'
                    ? 'assets/sunny-weather-animation.json'
                    : 'assets/sunny-weather-animation.json',

                height: 150,
                width: 300,
              ),

              SizedBox(height: 8),
              Text(
                '${weather.temperature.toStringAsFixed(1)} C',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
              ),

              SizedBox(height: 10),
              Text(
                weather.description,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Humidity: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${weather.humidity}%',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),

                  SizedBox(width: 20),
                  Text(
                    'Wind: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${weather.windspeed}m/s',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 12),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny, size: 30, color: Colors.amber),
                      Text(
                        "Sunrise  ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        formatTime(weather.sunrise),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 20),
                  Column(
                    children: [
                      Icon(
                        Icons.nights_stay_outlined,
                        size: 30,
                        color: const Color.fromARGB(255, 247, 82, 32),
                      ),
                      Text(
                        'Sunset ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        formatTime(weather.sunset),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
