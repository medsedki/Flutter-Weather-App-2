import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(new WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = '';

  //Display image based on the current time
  displayImage() {
    var now = DateTime.now();
    final currentTime = DateFormat.jm().format(now);

    if (currentTime.contains('AM')) {
      print("Current time is : $currentTime");

      return Image.asset('assets/dayTime.jpg');
    } else if (currentTime.contains('PM')) {
      print("Current time is : $currentTime");

      return Image.asset('assets/nightTime.jpg');
    }
  }

  //Get the currrent location
  //getCurrentLocation() async {
  //Future : it mean that the result gonna be transmetted in some fiew second in the future
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

      getCityName(position.latitude, position.longitude);

      print('The value of your position is : $position');
    } catch (e) {
      print(e);
    }
  }

  //get the city name
  Future<void> getCityName(double lat, double long) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(lat, long);

    city = placemark[0].locality;
    print('Your city name is : $city');
  }

  @override
  Widget build(BuildContext context) {
    //to get the location
    getCurrentLocation();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: displayImage(),
              //Image.asset('assets/dayTime.jpg'),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "You are in : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text(
                      //"Hergla",
                      city,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, top: 20.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 35.0,
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                ),
                title: Text('mchamsa 35°'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
