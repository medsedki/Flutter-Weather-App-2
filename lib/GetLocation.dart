import 'package:geolocator/geolocator.dart';

class GetLocation {
  double latitude;
  double longitude;
  String city;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
      city = await getCityName(position.latitude, position.longitude);

      //getCityName(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }

  //get the city name
  Future<String> getCityName(double lat, double long) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(lat, long);

    //city = placemark[0].locality;

    return placemark[0].locality;
  }
}
