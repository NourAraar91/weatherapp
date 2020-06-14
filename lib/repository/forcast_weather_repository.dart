
import 'dart:async';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/network/ApiProvider.dart';

class ForcastWeatherRepository {
  ApiProvider _provider = ApiProvider();

  Future<ForcastResult> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return ForcastResult.fromJson(response);
  }
}
