// To parse this JSON data, do
//
//     final currentWeather = currentWeatherFromJson(jsonString);

import 'dart:convert';

import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/weather_components.dart';

CurrentWeather currentWeatherFromJson(String str) => CurrentWeather.fromJson(json.decode(str));

String currentWeatherToJson(CurrentWeather data) => json.encode(data.toJson());

class CurrentWeather {
    CurrentWeather({
        this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod,
    });

    Coord coord;
    List<Weather> weather;
    String base;
    Main main;
    int visibility;
    Wind wind;
    Clouds clouds;
    int dt;
    Sys sys;
    int timezone;
    int id;
    String name;
    int cod;

    factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"] == null ? null : json["base"],
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        visibility: json["visibility"] == null ? null : json["visibility"],
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        dt: json["dt"] == null ? null : json["dt"],
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        timezone: json["timezone"] == null ? null : json["timezone"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        cod: json["cod"] == null ? null : json["cod"],
    );

    Map<String, dynamic> toJson() => {
        "coord": coord == null ? null : coord.toJson(),
        "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base == null ? null : base,
        "main": main == null ? null : main.toJson(),
        "visibility": visibility == null ? null : visibility,
        "wind": wind == null ? null : wind.toJson(),
        "clouds": clouds == null ? null : clouds.toJson(),
        "dt": dt == null ? null : dt,
        "sys": sys == null ? null : sys.toJson(),
        "timezone": timezone == null ? null : timezone,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "cod": cod == null ? null : cod,
    };
}
