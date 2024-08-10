import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final String apiKey = '5d264c0a5bf783bb55a0a9316be0ffee';
  final WeatherService weatherService =
      WeatherService(apiKey: '5d264c0a5bf783bb55a0a9316be0ffee');
    Weather? _weather;

     //fetch weather
  Future<void> _fetchWeather() async {
    final city = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(city);
    setState(() {
      _weather = weather;
    });
    } catch (e) {
      print(e);
    }
    
  }
  

  //weather animantion

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //cityname
          Text(_weather?. cityName ??"loading city"),
         SizedBox(height: 50,),
         //animantion
         Lottie.asset('assets/thurnder.json'),

          SizedBox(height: 50,),
          //weather tempreture
         Text('${_weather?.temperature.round()} c'),

          // //weather condition
          // Text(_weather?.weatherCondition  ?? "loading weather condition"),

        ],),
      )
    );
  }
}
