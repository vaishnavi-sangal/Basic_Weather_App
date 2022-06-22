import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(title: "Weather App", home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description = "";
  var humidity;
  var wind_speed;
  var currently;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Shamli&appid=eb509a98a17f18bf60308f3d45537c88"));

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.humidity = results['main']['humidity'];
      this.wind_speed = results['wind']['speed'];
      this.currently = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.yellow),
          padding: EdgeInsets.fromLTRB(40, 150, 40, 30),
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Text('Currently in boston'),

              // Text(description !=null ? description.toString():"loading'),
              Text(temp != null ? temp.toString() + "\u00B0" : "loading"),
              Text(description.toString()),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 30, 60),
            child: ListView(children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Temperature"),
                trailing:
                    Text(temp != null ? temp.toString() + "\u00B0" : "loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text(description.toString()),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing:
                    Text(humidity != null ? humidity.toString() : "loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Wind Speed"),
                trailing: Text(
                    wind_speed != null ? wind_speed.toString() : "loading"),
              )
            ]),
          ),
        )
      ],
    ));
  }
}
