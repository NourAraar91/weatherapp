import 'package:rxdart/subjects.dart';
import 'package:weatherapp/datastore/datastore.dart';
import 'package:weatherapp/models/place.dart';
import 'package:weatherapp/models/world_cities.dart';

class CitiesBloc {
  DataStore dataStore;
  List<String> _selectedCities;
  BehaviorSubject<String> _selectedCityController = BehaviorSubject<String>();
  Stream<String> get selectedCityStream => _selectedCityController.stream;
  
  CitiesBloc() {
    dataStore = DataStore();
  }

  String getCurrentCityCache() {
    return dataStore.prefs.getString("current_city");
  }

  setCurrentCityCache(String city) {
    dataStore.prefs.setString("current_city", city);
    _selectedCityController.sink.add(city);
  }

  List<Place> getWorldCitiesList() {
    return worldCitiesJSON.map((e) {
      return Place.fromJson(e);
    }).toList();
  }

  saveSelectedCitiesCache() {
    if (dataStore.prefs == null) {
      return;
    }
    dataStore.prefs.setStringList('selected_cities', _selectedCities);
  }

  List<String> getSelectedCitiesCache() {
    if (dataStore.prefs == null) {
      return null;
    }
    var cityList =
        dataStore.prefs.getStringList('selected_cities') ?? List<String>();
    return cityList;
  }

  List<String> get selectedCities {
    if (_selectedCities != null) {
      return _selectedCities;
    }
    _selectedCities = getSelectedCitiesCache();
    return _selectedCities;
  }

  set selectedCities(List<String> newValue) {
    _selectedCities = newValue;
    saveSelectedCitiesCache();
  }

  addNewCityToSelectedCities(String city) {
    if (selectedCities.indexOf(city) == -1) {
      selectedCities.add(city);
    }
    setCurrentCityCache(city);
    saveSelectedCitiesCache();
  }

  dispose() {
    _selectedCityController.close();
  }
}
