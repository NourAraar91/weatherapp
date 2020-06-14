import 'package:geolocator/geolocator.dart';
import 'package:rxdart/subjects.dart';

class GeoLocationBloc {
  
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;

  BehaviorSubject<Position> _currentPositionController =
      BehaviorSubject<Position>();
  Stream<Position> get currentPositionStream =>
      _currentPositionController.stream;

  BehaviorSubject<Placemark> _currentPositionPlaceController =
      BehaviorSubject<Placemark>();
  Stream<Placemark> get currentPositionPlaceStream =>
      _currentPositionPlaceController.stream;

  void getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPositionController.sink.add(position);
      _currentPosition = position;
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
      _currentPositionController.sink.addError(e);
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      print("${place.locality}, ${place.postalCode}, ${place.country}");
      _currentPositionPlaceController.sink.add(place);
      print(place.locality);
    } catch (e) {
      print(e);
      _currentPositionPlaceController.sink.addError(e);
    }
  }

  dispose() {
    _currentPositionController.close();
    _currentPositionPlaceController.close();
  }
}
