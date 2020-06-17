import 'package:rxdart/subjects.dart';
import 'package:weatherapp/datastore/datastore.dart';
import 'package:weatherapp/models/city.dart';

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
}
