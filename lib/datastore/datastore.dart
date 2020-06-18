import 'package:shared_preferences/shared_preferences.dart';

/// this class is responisble for handling the shared preferences
/// and cache for the app
/// you can create an opject of this class and use the prefs 
/// attribute to save and retrive data from cache

class DataStore {
  static SharedPreferences _prefs;

  DataStore._privateConstructor();

  static final DataStore _instance = DataStore._privateConstructor();

  static Future initPrefs() async {
    if (_prefs != null) {
      return _prefs;
    }
    _prefs = await SharedPreferences.getInstance();
    print("Shared is instantiated");
    return _prefs;
  }

  factory DataStore() {
    initPrefs();
    return _instance;
  }

  SharedPreferences get prefs => _prefs;
}
