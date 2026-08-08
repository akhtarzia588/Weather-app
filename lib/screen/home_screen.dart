import 'package:flutter/material.dart';
import 'package:weather_app/Service/service.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/widget/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final Service _weatherservice = Service();
  bool _isLoading = false;

  Weather? _weather;

  void _getweather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherservice.fetchweather(_controller.text);
      setState(() {
        _isLoading = false;
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load Weather')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                  _weather!.description.toLowerCase().contains('light rain')
              ? LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 75, 162, 233),
                    Colors.grey,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains('sunny')
              ? LinearGradient(
                  colors: [Colors.orangeAccent, Colors.red.shade100],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains(
                      'scattered cloud',
                    )
              ? LinearGradient(
                  colors: [Colors.grey.shade400, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [Colors.grey.shade400, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),

        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        //margin: EdgeInsets.all(0),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Weather App',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 13),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _controller,

                    decoration: InputDecoration(
                      hintText: 'Enter your City Name',
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                      filled: true,
                      fillColor: Colors.white30,
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 13),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    onPressed: _getweather,
                    child: Text(
                      'Get Weather',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 12),
                  if (_isLoading)
                    Padding(
                      padding: EdgeInsetsGeometry.all(9),
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  if (_weather != null) WeatherCard(weather: _weather!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
