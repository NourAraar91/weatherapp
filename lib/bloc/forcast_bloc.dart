import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:weatherapp/datastore/datastore.dart';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/network/Repsonse.dart';
import 'package:weatherapp/repository/forcast_weather_repository.dart';

class ForcastBloc {
  ForcastWeatherRepository _repository = ForcastWeatherRepository();
  DataStore dataStore;
  BehaviorSubject<Response<ForcastResult>> _forcastResultController;
  Stream<Response<ForcastResult>> get forcastResultStream =>
      _forcastResultController.stream;

  ForcastBloc() {
    _forcastResultController = BehaviorSubject<Response<ForcastResult>>();
    dataStore = DataStore();
  }

  getForcastByLatAndLong(String lat, String long) async {
    _forcastResultController.sink
        .add(Response.loading("Getting Weather Data ..."));
    try {
      ForcastResult result = await _repository.fetchForcastWeatherBy(lat, long);
      _forcastResultController.sink.add(Response.completed(result));
    } catch (e) {
      _forcastResultController.sink.addError(Response.error(e.toString()));
    }
  }

  getForcastByName(String city) async {
    var cityCache = getCityFromCache(city);
    if (cityCache != null) {
      _forcastResultController.sink.add(Response.completed(cityCache));
    } else {
      _forcastResultController.sink
          .add(Response.loading("Getting Weather Data for $city ..."));
    }
    try {
      ForcastResult result = await _repository.fetchForcastWeatherFor(city);
      saveCityToCahche(city, result);
      _forcastResultController.sink.add(Response.completed(result));
    } catch (e) {
      if (cityCache == null) {
        _forcastResultController.sink.add(Response.error(e.toString()));
      }
    }
  }

  saveCityToCahche(String city, ForcastResult weather) {
    if (dataStore.prefs == null) {
      return;
    }
    dataStore.prefs.setString('forcast_$city', forcastResultToJson(weather));
  }

  ForcastResult getCityFromCache(String city) {
    if (dataStore.prefs == null) {
      return null;
    }
    var cityStr = dataStore.prefs.getString('forcast_$city');
    var u = cityStr != null ? forcastResultFromJson(cityStr) : null;
    return u;
  }

  dispose() {
    _forcastResultController.close();
  }
}
