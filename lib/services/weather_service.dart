import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;


class WeatherService{
  static const 
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String city) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$city&appid=$apiKey'));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } 
  else {
    throw Exception('Failed to load weather');
  }
}

  Future<String> getCurrentCity() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
   
   String? city = placemark[0].locality;

  return city ?? '';
}

}