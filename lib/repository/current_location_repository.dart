 import 'dart:async';
import 'package:weatherapp/models/current_weather.dart';
import 'package:weatherapp/network/ApiProvider.dart';
import 'package:weatherapp/utilities/secrets.dart';

class CurrentWeatherRepository {
  ApiProvider _provider = ApiProvider();

  Future<CurrentWeather> fetchCurrentWeatherFor(String city) async {
    final response = await _provider
        .get("/data/2.5/weather?q=$city&appid=$apiKEY&units=metric");
    return CurrentWeather.fromJson(response);
  }

  Future<CurrentWeather> fetchCurrentWeatherBy(String lat, String long) async {
    final response = await _provider
        .get("/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKEY&units=metric");
    return CurrentWeather.fromJson(response);
  }
}