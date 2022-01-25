import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=Hong%20Kong&&units=metric&appid=c49e124d360a58b8eeae38a345124aa4");

  var location;
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    setState(() {
      location = results['name'];
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  location != null
                      ? "Currently in " + location.toString()
                      : "Loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(temp != null ? temp.toString() + "\u00B0" : "Loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600)),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  currently != null ? currently.toString() : "Loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ]),
      ),
      Expanded(
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView(children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Temperature"),
                trailing: Text(
                    temp != null ? temp.toString() + "\u00B0" : "Loading..."),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text(description != null
                    ? description.toString()
                    : "Loading..."),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing:
                    Text(humidity != null ? humidity.toString() : "Loading..."),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Wind Speed"),
                trailing: Text(
                    windSpeed != null ? windSpeed.toString() : "Loading..."),
              )
            ])),
      )
    ]));
  }
}
