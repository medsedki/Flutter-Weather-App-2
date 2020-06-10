import 'package:Weather2/GetLocation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(new WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = "";

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

  //getLocation
  void getLocation() async {
    GetLocation getLocation = GetLocation();
    await getLocation.getCurrentLocation();

    print("latitude : ${getLocation.latitude}");
    print("Longitude : ${getLocation.longitude}");
    print("city : ${getLocation.city}");
    city = getLocation.city;
  }

  @override
  Widget build(BuildContext context) {
    //to get the location
    getLocation();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Weather App',
          ),
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
