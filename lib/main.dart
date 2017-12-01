import 'package:flutter/material.dart';
import 'package:location/location.dart';

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
    new Location().getLocation.then((Map<String,double> location) {
      setState(() {
        this.location = location;
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
          new Text(location?.toString()),
        ],
      ),
    );

    return new Stack(children: stackChildren);
  }
}
