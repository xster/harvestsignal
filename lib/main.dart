import 'package:flutter/material.dart';

void main() => runApp(
  new MaterialApp(
    home: new Scaffold(
      body: new Home())));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        const Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0),
          child: const Text(
            'Harvest',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 32.0))),
      ],
    );
  }
}
