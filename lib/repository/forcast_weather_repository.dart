import 'dart:async';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/network/ApiProvider.dart';
import 'package:weatherapp/utilities/secrets.dart';

class ForcastWeatherRepository {
  ApiProvider _provider = ApiProvider();

  Future<ForcastResult> fetchForcastWeatherFor(String city) async {
    final response = await _provider
        .get("/data/2.5/forecast?q=$city&appid=$apiKEY&units=metric");
    return ForcastResult.fromJson(response);
  }

  Future<ForcastResult> fetchForcastWeatherBy(String lat, String long) async {
    final response = await _provider
        .get("/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKEY&units=metric");
    return ForcastResult.fromJson(response);
  }
}
