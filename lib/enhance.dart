import 'package:flutter/material.dart';
import './criteria.dart';
import './hazard.dart';

class Enhance extends StatefulWidget {
  @override
  _EnhanceState createState() => _EnhanceState();
}

class _EnhanceState extends State<Enhance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 50.0,
          color: Colors.white,
        ),
        appBar: AppBar(title: Text("Performance Enhancement")),
        body: Container(
          child: ListView(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pipelining",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  ),
                  Text(
                    "Instructions being separated into small stages and processed simultaneously.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  ),
                  Card(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Example of stages"),
                      Image.asset("assets/Stages.png"),
                    ],
                  )),
                  Card(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Example of pipelining"),
                      Image.asset("assets/Pipeline illustration.png"),
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Considerations for Optimum Pipelining"),
                        onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Criteria()))
                            },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Pipelining Hazards"),
                        onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Hazard()))
                            },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
