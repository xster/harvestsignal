import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:location/location.dart' as gps;

void main() => runApp(
  new MaterialApp(
    home: new Scaffold(
      body: new Home())));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  bool loading = true;
  Map<String,double> location;

  @override
  void initState() {
    super.initState();
    new gps.Location().getLocation.then((Map<String,double> location) {
      new GoogleMapsGeocoding(null).searchByLocation(
        new Location(location['latitude'], location['longitude'])
      ).then((GeocodingResponse response) {
        if (response.status == GoogleResponseStatus.okay) {
          print(response.results[0].addressComponents);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = <Widget>[];
    if (location == null) {
      stackChildren.add(new Center(child: new Image.asset('assets/load.gif')));
    }

    stackChildren.add(
      new ListView(
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0),
            child: const Text(
              'Harvest',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 48.0,
                color: const Color(0xFF222222),
                ))),
        ],
      ),
    );

    return new Stack(children: stackChildren);
  }
}
