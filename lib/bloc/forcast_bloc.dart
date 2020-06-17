import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/network/Repsonse.dart';
import 'package:weatherapp/repository/forcast_weather_repository.dart';

class ForcastBloc {
  ForcastWeatherRepository _repository = ForcastWeatherRepository();

  BehaviorSubject<Response<ForcastResult> > _forcastResultController;
  Stream<Response<ForcastResult>> get forcastResultStream =>
      _forcastResultController.stream;

  ForcastBloc() {
    _forcastResultController = BehaviorSubject<Response<ForcastResult>>();
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
    _forcastResultController.sink
        .add(Response.loading("Getting Weather Data for $city ..."));
    try {
      ForcastResult result = await _repository.fetchForcastWeatherFor(city);
      _forcastResultController.sink.add(Response.completed(result));
    } catch (e) {
      _forcastResultController.sink.addError(Response.error(e.toString()));
    }
  }

  dispose() {
    _forcastResultController.close();
  }
}
