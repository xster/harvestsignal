import 'package:flutter/material.dart';

import 'api.dart';

void main() => runApp(
  MaterialApp(
    home: const Scaffold(
      body: const DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Nunito'),
        child: const Home()))));

class Home extends StatefulWidget {
  const Home();

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  bool loading = true;
  List<Map<String, dynamic>> produce;

  @override
  void initState() {
    super.initState();

    getZipCode().then((String zipCode) {
      getProduce(zipCode).then((List<Map<String, dynamic>> result) {
        setState(() {
          produce = result;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = <Widget>[];
    if (produce == null) {
      stackChildren.add(new Center(child: new Image.asset('assets/load.gif')));
    }

    List<Widget> items = <Widget> [
    //   new SliverPersistentHeader(
    //   delegate: new SliverPersistentHeaderDelegate(

    //   ),
    // )
    ];
    // SliverAppBar(
    //   backgroundColor: Colors.white,

    //   title: const Text(
    //     'Harvest',
    //     style: const TextStyle(
    //       fontFamily: 'Nunito',
    //       fontSize: 48.0,
    //       color: const Color(0xFF222222),
    //     ),
    //   ),
    // )];

    if (produce != null) {
      items.add(
        SliverGrid.count(
          crossAxisCount: 2,
          children: produce.map((Map<String, dynamic> item) {
            return new Card(
              elevation: 10.0,
              child: Stack(
                children: <Widget>[
                  Image.network('https://harvestsignal.com/assets/produce-pictures/${item['slug']}.jpg'),
                  new Align(
                    alignment: FractionalOffset.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      color: const Color(0x77FFFFFF),
                      child: new Text(item['produce_name'])
                    ),
                  ),
                ]
              ),
            );
          }).toList(),
        ),
      );
    }

    stackChildren.add(
      CustomScrollView(
        slivers: items,
      ),
    );

    return Stack(children: stackChildren);
  }
}
