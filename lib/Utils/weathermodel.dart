import 'package:geolocator/geolocator.dart';

class WeatherModel {
  var longitude, latitude;
  Future<void> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      print(e.toString());
    }
  }
}
