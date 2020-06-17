// To parse this JSON data, do
//
//     final forcastResult = forcastResultFromJson(jsonString);

import 'dart:convert';

import 'package:weatherapp/models/weather_result.dart';

import 'city.dart';

ForcastResult forcastResultFromJson(String str) => ForcastResult.fromJson(json.decode(str));

String forcastResultToJson(ForcastResult data) => json.encode(data.toJson());

class ForcastResult {
    ForcastResult({
        this.cod,
        this.message,
        this.cnt,
        this.list,
        this.city,
    });

    String cod;
    int message;
    int cnt;
    List<WeatherResult> list;
    City city;

    factory ForcastResult.fromJson(Map<String, dynamic> json) => ForcastResult(
        cod: json["cod"] == null ? null : json["cod"],
        message: json["message"] == null ? null : json["message"],
        cnt: json["cnt"] == null ? null : json["cnt"],
        list: json["list"] == null ? null : List<WeatherResult>.from(json["list"].map((x) => WeatherResult.fromJson(x))),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
    );

    Map<String, dynamic> toJson() => {
        "cod": cod == null ? null : cod,
        "message": message == null ? null : message,
        "cnt": cnt == null ? null : cnt,
        "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
        "city": city == null ? null : city.toJson(),
    };
}


