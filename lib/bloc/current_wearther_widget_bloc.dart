import 'package:weatherapp/bloc/city_bloc.dart';
import 'package:weatherapp/bloc/current_weather_bloc.dart';
import 'package:weatherapp/bloc/forcast_bloc.dart';
import 'package:weatherapp/bloc/geo_location_bloc.dart';
import 'package:weatherapp/models/current_weather.dart';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/network/Repsonse.dart';

class CurrentWeartherWidgetBloc {
  CurrentWeatherBloc weatherBloc;
  ForcastBloc forcastBloc;
  GeoLocationBloc locationBloc;
  CitiesBloc citiesBloc;

  CurrentWeartherWidgetBloc() {
    weatherBloc = CurrentWeatherBloc();
    forcastBloc = ForcastBloc();
    locationBloc = GeoLocationBloc();
    citiesBloc = CitiesBloc();
  }

  Stream<Response<CurrentWeather>> get currentResultStream =>
      weatherBloc.currentResultStream;

  Stream<Response<ForcastResult>> get forcastResultStream =>
      forcastBloc.forcastResultStream;

  String get currentCity => citiesBloc.getCurrentCityCache() ?? 'Damascus';

  setCurrentCityCache(String city) {
    citiesBloc.setCurrentCityCache(city);
  }

  getCurrentWeatherByName(currentCity) {
    weatherBloc.getCurrentWeatherByName(currentCity);
  }

  getForcastByName(currentCity) {
    forcastBloc.getForcastByName(currentCity);
  }

  getCurrentlocation() {
    locationBloc.getCurrentLocation();
    locationBloc.currentPositionController.listen((value) {
      weatherBloc.getCurrentWeatherByLatAndLong(
          value.latitude.toString(), value.longitude.toString());
      forcastBloc.getForcastByLatAndLong(
          value.latitude.toString(), value.longitude.toString());
    }).onError((error) {
      print(error);
    });
  }
}
