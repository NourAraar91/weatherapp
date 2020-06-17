import 'package:shared_preferences/shared_preferences.dart';

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
