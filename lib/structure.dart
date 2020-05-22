import 'package:flutter/material.dart';

class Structure extends StatefulWidget {
  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  Widget structure(String description, String image) {
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            new Text(
              description,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
            new Image.asset(image),
            Padding(
              padding: EdgeInsets.all(10.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.white,
      ),
      appBar: AppBar(
        title: new Text("Computer Top-Level Diagram"),
      ),
      body: new ListView(
        children: <Widget>[
          structure("Computer", "assets/Computer.png"),
          structure("CPU", "assets/CPU.png"),
          structure("Control Unit", "assets/Control Unit.png")
        ],
      ),
    );
  }
}
