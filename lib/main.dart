import 'dart:convert';

import 'package:Weather2/GetLocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  //Api Key
  String apiKey = "2f9db73a7e06c0763afd84b5c4f128a3";

  var description;
  var temp;
  var pressure;
  var humidity;
  var speed;
  var deg;
  var name;

  var now = DateTime.now();

  //Display image based on the current time
  displayImage() {
    //var now = DateTime.now();
    final currentTime = DateFormat.jm().format(now);

    if (currentTime.contains('AM')) {
      print("Current time is : $currentTime");

      return Image.asset('assets/dayTime.jpg');
    } else if (currentTime.contains('PM')) {
      print("Current time is : $currentTime");

      return Image.asset('assets/nightTime.jpg');
    }
  }

  //the first try ==> Success
  Future<void> getTempDesc(double lat, double lon) async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=439d4b804bc8187953eb36d2a8c26a02');
    print(response.body);

    var dataDecoded = jsonDecode(response.body);
    description = dataDecoded['weather'][0]['description'];
    temp = dataDecoded['main']['temp'];
    pressure = dataDecoded['main']['pressure'];
    humidity = dataDecoded['main']['humidity'];
    speed = dataDecoded['wind']['speed'];
    deg = dataDecoded['wind']['deg'];
    print(description);
    print(temp);
    print(pressure);
    print(humidity);
    print(speed);
    print(deg);
  }

  //Get current temperature
  Future<void> getTemp(double lat, double lon) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    print(response.body);

    var dataDecoded = jsonDecode(response.body);
    description = dataDecoded['weather'][0]['description'];
    temp = dataDecoded['main']['temp'];
    pressure = dataDecoded['main']['pressure'];
    humidity = dataDecoded['main']['humidity'];
    speed = dataDecoded['wind']['speed'];
    deg = dataDecoded['wind']['deg'];
    name = dataDecoded['name'];
    print("temp : $temp");
  }

  Future<String> getLocation() async {
    GetLocation getLocation = GetLocation();
    await getLocation.getCurrentLocation();

    print("latitude : ${getLocation.latitude}");
    print("Longitude : ${getLocation.longitude}");
    print("city : ${getLocation.city}");
    city = getLocation.city;
    //getTempDesc(getLocation.latitude, getLocation.longitude);

    getTemp(getLocation.latitude, getLocation.longitude);

    return city;
  }

  String getCity(String c) {
    if (c == null) {
      return "in Progress";
    } else
      return c;
  }

  @override
  Widget build(BuildContext context) {
    //to get the location
    getLocation();

    var newFormat = DateFormat("yyyy-MM-dd hh:mm");
    String updatedDt = newFormat.format(now);

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
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: displayImage(),
                  //Image.asset('assets/dayTime.jpg'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    updatedDt,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: Colors.orange,
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
                          "You are in :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
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
                          //city,
                          //getCity(city),
                          getCity(name),
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
                    title: Text('$description, Temp : $temp'),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.present_to_all,
                      color: Colors.amber,
                    ),
                    title: Text('Pressure : $pressure, Humidity : $humidity'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Text(
                          "Wind",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, top: 20.0),
                        child: Image.asset(
                          'assets/wind.png',
                          height: 50.0,
                        ),
                      ),
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
                      Icons.compare_arrows,
                      color: Colors.blueAccent,
                    ),
                    title: Text('Speed : $speed, Deg : $deg'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
