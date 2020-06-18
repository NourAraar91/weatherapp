import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:weatherapp/datastore/datastore.dart';
import 'package:weatherapp/models/current_weather.dart';
import 'package:weatherapp/network/Repsonse.dart';
import 'package:weatherapp/repository/current_location_repository.dart';

class CurrentWeatherBloc {
  CurrentWeatherRepository _repository = CurrentWeatherRepository();
  DataStore dataStore;
  BehaviorSubject<Response<CurrentWeather>> _currentResultController;
  Stream<Response<CurrentWeather>> get currentResultStream =>
      _currentResultController.stream;

  CurrentWeatherBloc() {
    _currentResultController = BehaviorSubject<Response<CurrentWeather>>();
    dataStore = DataStore();
  }

  getCurrentWeatherByLatAndLong(String lat, String long) async {
    _currentResultController.sink
        .add(Response.loading("Getting Weather Data ..."));
    try {
      CurrentWeather result =
          await _repository.fetchCurrentWeatherBy(lat, long);
      _currentResultController.sink.add(Response.completed(result));
    } catch (e) {
      _currentResultController.sink.add(Response.error(e.toString()));
    }
  }

  getCurrentWeatherByName(String city) async {
    var cityCache = getCityFromCache(city);
    if (cityCache != null) {
      _currentResultController.sink.add(Response.completed(cityCache));
    } else {
      _currentResultController.sink
          .add(Response.loading("Getting Weather Data for $city ..."));
    }
    try {
      CurrentWeather result = await _repository.fetchCurrentWeatherFor(city);
      saveCityToCahche(city, result);
      _currentResultController.sink.add(Response.completed(result));
    } catch (e) {
      if (cityCache == null) {
        _currentResultController.sink.add(Response.error(e.toString()));
      }
    }
  }

  saveCityToCahche(String city, CurrentWeather weather) {
    if (dataStore.prefs == null) {
      return;
    }
    dataStore.prefs.setString('current_$city', currentWeatherToJson(weather));
  }

  CurrentWeather getCityFromCache(String city) {
    if (dataStore.prefs == null) {
      return null;
    }
    var cityStr = dataStore.prefs.getString('current_$city');
    var u = cityStr != null ? currentWeatherFromJson(cityStr) : null;
    return u;
  }

  dispose() {
    _currentResultController.close();
  }
}
