import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/weather_components.dart';

class WeatherResult {
  WeatherResult({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.sys,
    this.dtTxt,
    this.rain,
  });

  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  Sys sys;
  DateTime dtTxt;
  Rain rain;

  factory WeatherResult.fromJson(Map<String, dynamic> json) => WeatherResult(
        dt: json["dt"] == null ? null : json["dt"],
        main: json["main"] == null ? null : MainClass.fromJson(json["main"]),
        weather: json["weather"] == null
            ? null
            : List<Weather>.from(
                json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt == null ? null : dt,
        "main": main == null ? null : main.toJson(),
        "weather": weather == null
            ? null
            : List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds == null ? null : clouds.toJson(),
        "wind": wind == null ? null : wind.toJson(),
        "sys": sys == null ? null : sys.toJson(),
        "dt_txt": dtTxt == null ? null : dtTxt.toIso8601String(),
        "rain": rain == null ? null : rain.toJson(),
      };
}
