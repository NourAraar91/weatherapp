import 'dart:convert';

List<Place> placeFromJson(String str) =>
    List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));

String placeToJson(List<Place> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Place {
  Place({
    this.city,
    this.lat,
    this.lng,
  });

  String city;
  double lat;
  double lng;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        city: json["city"] == null ? null : json["city"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
