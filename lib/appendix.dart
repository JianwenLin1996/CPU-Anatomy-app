import 'package:flutter/material.dart';
import './structure.dart';
import './simplifysimulation.dart';
import './enhance.dart';

/*void main() {
  runApp(new MaterialApp(
    home: new Appendix(),
  ));
}*/

class Appendix extends StatefulWidget {
  @override
  _AppendixState createState() => _AppendixState();
}

class _AppendixState extends State<Appendix> {
  Widget _chapter(String title, Color fontcolor, Color bgcolor) {
    return GestureDetector(
        child: Row(
          children: <Widget>[
            new CircleAvatar(
              child: new Text(
                title,
                style: TextStyle(color: fontcolor, fontWeight: FontWeight.w800),
              ),
              radius: 90.0,
              backgroundColor: bgcolor,
            )
          ],
        ),
        onTap: () => {
              _proceed(title),
            });
  }

  void _proceed(String title) {
    if (title == "Structure of CPU")
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Structure()));
    else if (title == "Dataflow Simulation")
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Simplifysimulation()));
    else if (title == "Performance Enhance")
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Enhance()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.white,
      ),
      appBar: new AppBar(
        backgroundColor: Colors.grey[200],
        title: new Text(
          "CPU Tutorial",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _chapter("Structure of CPU", Colors.black45,
                          Colors.greenAccent[200]),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _chapter("Dataflow Simulation", Colors.purple[400],
                          Colors.blue[100]),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _chapter("Performance Enhance", Colors.black87,
                          Colors.yellow[200]),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
