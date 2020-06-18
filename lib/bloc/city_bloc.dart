import 'package:weatherapp/datastore/datastore.dart';
import 'package:weatherapp/models/place.dart';
import 'package:weatherapp/models/world_cities.dart';

class CitiesBloc {
  DataStore dataStore;

  CitiesBloc() {
    dataStore = DataStore();
  }
  String getCurrentCityCache() {
    return dataStore.prefs.getString("current_city");
  }

  setCurrentCityCache(String city) {
    dataStore.prefs.setString("current_city", city);
  }

  List<Place> getWorldCitiesList() {
    return worldCitiesJSON.map((e) {
      return Place.fromJson(e);
    }).toList();
  }

  dispose() {}
}
